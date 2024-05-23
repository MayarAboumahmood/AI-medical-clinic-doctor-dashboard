import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:graduation_project_therapist_dashboard/app/features/chat/bloc/chat_functions.dart';

import 'package:pubnub/pubnub.dart';
import 'package:uuid/uuid.dart';

import 'package:graduation_project_therapist_dashboard/app/features/chat/bloc/chat_event.dart';
import 'package:graduation_project_therapist_dashboard/app/features/chat/bloc/chat_state.dart';
import 'package:graduation_project_therapist_dashboard/app/features/chat/models/chat_card_model.dart';
import 'package:graduation_project_therapist_dashboard/app/features/chat/models/message_model.dart';

String publishKey = 'pub-c-720243bc-7287-40bc-8607-378fe73e2447';
String subscribeKey = 'sub-c-8fbae32e-cb72-4994-b3db-0ddbdf57f043';
String secretKey = 'sec-c-MDdiNWFiYzAtY2I1ZS00MTYxLTk4MGEtMGE5YjA2Y2Y5ZWMw';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  late PubNub pubnub;
  final int userID = 1;
  Uint8List? imageToSend;
  int chunkSize = 20;

  int user2ID = 2;
  late String channelName;
  Subscription? _subscription;
  List<ChatCardModel> chatsCardsModels = [
    ChatCardModel(name: 'one', image: ''),
    ChatCardModel(name: 'two', image: ''),
    ChatCardModel(name: 'three', image: ''),
  ];

  List<MessageModel> messages = [];

  String generateUserId() {
    var uuid = const Uuid();
    return uuid.v4();
  }

  ChatBloc() : super(ChatInitial()) {
    channelName = assignChannelName(user2ID, userID);
    pubnub = PubNub(
      defaultKeyset: Keyset(
        subscribeKey: subscribeKey,
        publishKey: publishKey,
        userId: UserId(
          userID.toString(),
        ),
      ),
    );

    on<AddImageToSendEvent>((event, emit) async {
      imageToSend = event.imageToSend;
    });

    on<ReceiveNewMessageEvent>((event, emit) async {
      if (_subscription == null || _subscription!.isPaused) {
        debugPrint("Subscription is not active.");
        return;
      }

      try {
        await for (final message in _subscription!.messages) {
          if (isClosed) {
            debugPrint("Bloc is closed, stopping message processing.");
            return;
          }
          var content = message.content['content'];
          bool iAmTheSender = false;
          String messageType =
              message.content['messageType'] == 'text' ? 'text' : 'image';
          if (messageType == 'image') {
            iAmTheSender = userID.toString() == message.content['message'];

            String fileId = message.content['file']['id'];
            String fileName = message.content['file']['name'];
            Uri fileUrl =
                pubnub.files.getFileUrl(channelName, fileId, fileName);
            content = fileUrl;
          } else {
            iAmTheSender = message.content['senderId'] == userID.toString();
          }

          MessageModel newReceivedMessage = MessageModel(
            type: messageTypeFromString(messageType),
            content: content,
            timestamp: DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
            iAmTheSender: iAmTheSender,
          );

          messages.add(newReceivedMessage);
          emit(NewMessageReceivedState(
              messageModel: newReceivedMessage, dateTime: DateTime.now()));
        }
      } catch (e) {
        debugPrint('Error processing messages: $e');
      }
    });
    final Channel myChannel = pubnub.channel(channelName);

    on<LoadEarlierMessagesEvent>((event, emit) async {
      emit(LoadingEarlierMessagesState());
      chunkSize += 20;
      PaginatedChannelHistory history = myChannel.history(chunkSize: chunkSize);
      try {
        await history.more(); // This fetches the next page of messages
        if (messages.length == history.messages.length) {
          emit(EarlierMessagesLoadedState(
              earlierMessages: messages, noMoreMessages: true));
        } else {
          messages.clear();
          List<MessageModel> newMessages = [];
          Uri? fileUrl;
          bool iAmTheSender = false;
          for (final envelope in history.messages) {
            String messageType =
                envelope.content['messageType'] == 'text' ? 'text' : 'image';
            if (messageType == 'image') {
              iAmTheSender = userID.toString() == envelope.content['message'];

              String fileId = envelope.content['file']['id'];
              String fileName = envelope.content['file']['name'];
              fileUrl = pubnub.files.getFileUrl(channelName, fileId, fileName);
            } else {
              iAmTheSender = userID.toString() ==
                  envelope.originalMessage['message']['senderId'];
            }
            newMessages.add(MessageModel(
              type: messageTypeFromString(messageType),
              content:
                  messageType == 'text' ? envelope.content['content'] : fileUrl,
              timestamp:
                  DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
              iAmTheSender: iAmTheSender,
            ));
          }
          messages.insertAll(
              0, newMessages); // Prepend new messages to the list

          emit(EarlierMessagesLoadedState(
              earlierMessages: messages, noMoreMessages: false));
        }
      } catch (e) {
        debugPrint('Error while loading earlier messages: $e');
        emit(ChatErrorState(e.toString()));
      }
    });

    on<UnsubscribeEvent>((event, emit) {
      messages.clear();
      _subscription?.unsubscribe();
      chunkSize = 20;
      emit(UnsubscribedState());
    });
    on<SubscribeMessagesEvent>((event, emit) async {
      // Subscription to the channel
      _subscription = pubnub.subscribe(channels: {channelName});
    });
    Future<void> getAllMessages(Emitter<ChatState> emit) async {
      PaginatedChannelHistory history = myChannel.history(chunkSize: 20);
      await history.more();
      try {
        Uri? fileUrl;
        for (final envelope in history.messages) {
          bool iAmTheSender = false;
          if (!hasMessageData(envelope.originalMessage)) {
            iAmTheSender = userID.toString() == envelope.content['message'];
            String fileId = envelope.originalMessage['message']['file']['id'];
            String fileName =
                envelope.originalMessage['message']['file']['name'];
            fileUrl = pubnub.files.getFileUrl(channelName, fileId, fileName);
          } else {
            iAmTheSender = userID.toString() ==
                envelope.originalMessage['message']['senderId'];
          }

          final String timestamp =
              DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
          messages.add(MessageModel(
              type: messageTypeFromString(
                  envelope.content['messageType'] == 'text' ? 'text' : 'image'),
              content: hasMessageData(envelope.originalMessage)
                  ? envelope.content['content']
                  : fileUrl,
              timestamp: timestamp,
              iAmTheSender: iAmTheSender));
        }
      } catch (e) {
        debugPrint('Error while getting messages: $e');
        emit(ChatErrorState(e.toString()));
      }
      emit(GotAllMessagesState(messages: messages));
    }

    on<SendMessageEvent>((event, emit) async {
      try {
        late Object? content;
        if (event.messageType == MessageTypeEnum.image &&
            event.imageData != null) {
          content = event.imageData;
          await pubnub.files.sendFile(
            channelName,
            event.imageName!,
            event.imageData!,
            fileMessage: userID.toString(),
            fileMessageMeta: {
              'senderId': userID.toString(),
              'messageType': getMessageTypeFromEnvelope(event.messageType),
            },
          );
        } else {
          content = event.message;
          await pubnub.publish(
            channelName,
            {
              'senderId': userID.toString(),
              'content': content,
              'messageType': getMessageTypeFromEnvelope(event.messageType),
            },
          );
        }
      } catch (e) {
        debugPrint('Error when sending the message: ${e.toString()}');
        emit(ChatErrorState(e.toString()));
      }
    });

    on<GetAllChatsEvent>((event, emit) async {
      emit(ChatsLoadingState());
      Future.delayed(const Duration(milliseconds: 200), () {
        emit(GotAllChatsState(chatsCardsModels));
      });
    });
    on<GetAllMessagesEvent>((event, emit) async {
      emit(ChatsLoadingState());
      await getAllMessages(emit);
    });
  }
}
