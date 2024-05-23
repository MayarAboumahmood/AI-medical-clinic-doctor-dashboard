import 'dart:math';
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
  final int userID = 2;
  Uint8List? imageToSend;

  int user2ID = 1;
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

  String assignChannelName() {
    int firstID = max(userID, user2ID);
    int secondID = min(userID, user2ID);
    return '${firstID}graduationProjecttestrelease$secondID';
  }

  ChatBloc() : super(ChatInitial()) {
    channelName = assignChannelName();
    pubnub = PubNub(
      defaultKeyset: Keyset(
        subscribeKey: subscribeKey,
        publishKey: publishKey,
        userId: UserId(
          userID.toString(),
        ),
      ),
    );

    final KeysetStore keysetStore = pubnub.keysets;
    late String senderId;
    on<AddImageToSendEvent>((event, emit) async {
      imageToSend = event.imageToSend;
    });

    on<ReceiveNewMessageEvent>((event, emit) async {
      if (_subscription == null || _subscription!.isPaused) {
        print("Subscription is not active.");
        return;
      }
      if (keysetStore.keysets.isNotEmpty) {
        final Keyset keyset = keysetStore.keysets.first;
        senderId = keyset.userId.value;
      }

      try {
        await for (final message in _subscription!.messages) {
          if (isClosed) {
            print("Bloc is closed, stopping message processing.");
            return;
          }
          var content = message.content['content'];
          print("receiving up: $content");

          String messageType =
              message.content['messageType'] == 'text' ? 'text' : 'image';
          if (messageType == 'image') {
            String fileId = message.content['file']['id'];
            String fileName = message.content['file']['name'];
            Uri fileUrl =
                pubnub.files.getFileUrl(channelName, fileId, fileName);
            content = fileUrl;
          }

          bool iAmTheSender = senderId == userID.toString();

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
        print('Error processing messages: $e');
      }
    });

    on<UnsubscribeEvent>((event, emit) {
      messages.clear();
      _subscription?.unsubscribe();

      emit(UnsubscribedState());
    });
    on<SubscribeMessagesEvent>((event, emit) async {
      // Subscription to the channel
      _subscription = pubnub.subscribe(channels: {channelName});
    });
    Future<void> getAllMessages(Emitter<ChatState> emit) async {
      final myChannel = pubnub.channel(channelName);
      var history = myChannel.history(chunkSize: 50);
      await history.more();
      if (keysetStore.keysets.isNotEmpty) {
        final Keyset keyset = keysetStore.keysets.first;
        senderId = keyset.userId.value;
      }

      try {
        Uri? fileUrl;
        for (final envelope in history.messages) {
          bool iAmTheSender = senderId == userID.toString();

          if (!hasMessageData(envelope.originalMessage)) {
            String fileId = envelope.originalMessage['message']['file']['id'];
            String fileName =
                envelope.originalMessage['message']['file']['name'];
            fileUrl = pubnub.files.getFileUrl(channelName, fileId, fileName);
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
          emit(NewMessageState(envelope.content));
        }
      } catch (e) {
        print('Error while getting messages: $e');
        emit(ChatErrorState(e.toString()));
      }
      emit(GotAllMessagesState(messages: messages));
    }

    on<SendMessageEvent>((event, emit) async {
      try {
        if (keysetStore.keysets.isNotEmpty) {
          final Keyset keyset = keysetStore.keysets.first;
          senderId = keyset.userId.value;
        }
        late Object? content;
        if (event.messageType == MessageTypeEnum.image &&
            event.imageData != null) {
          content = event.imageData;
          await pubnub.files.sendFile(
            channelName,
            event.imageName!,
            event.imageData!,
            fileMessage: '',
            fileMessageMeta: {
              'senderId': senderId,
              'messageType': getMessageTypeFromEnvelope(event.messageType),
            },
          );
        } else {
          content = event.message;
          await pubnub.publish(
            channelName,
            {
              'senderId': senderId,
              'content': content,
              'messageType': getMessageTypeFromEnvelope(event.messageType),
            },
          );
        }
      } catch (e) {
        print('Error when sending the message: ${e.toString()}');
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
