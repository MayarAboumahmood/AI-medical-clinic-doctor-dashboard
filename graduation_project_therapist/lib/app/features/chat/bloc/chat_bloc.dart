import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/app/features/chat/bloc/chat_functions.dart';
import 'package:graduation_project_therapist_dashboard/app/features/chat/repo/chat_repo.dart';
import 'package:graduation_project_therapist_dashboard/app/features/chat/view/screens/chat_page.dart';
import 'package:graduation_project_therapist_dashboard/app/features/home_page/data_source/models/user_profile_model.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

import 'package:pubnub/pubnub.dart';

import 'package:graduation_project_therapist_dashboard/app/features/chat/bloc/chat_event.dart';
import 'package:graduation_project_therapist_dashboard/app/features/chat/bloc/chat_state.dart';
import 'package:graduation_project_therapist_dashboard/app/features/chat/models/chat_card_model.dart';
import 'package:graduation_project_therapist_dashboard/app/features/chat/models/message_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

String publishKey = 'pub-c-720243bc-7287-40bc-8607-378fe73e2447';
String subscribeKey = 'sub-c-8fbae32e-cb72-4994-b3db-0ddbdf57f043';
String secretKey = 'sec-c-MDdiNWFiYzAtY2I1ZS00MTYxLTk4MGEtMGE5YjA2Y2Y5ZWMw';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatRepositoryImp chatRepositoryImp;
  late PubNub pubnub;
  late Channel myChannel;

  Future<int?> getMyIdFromPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('user_profile')) return null;

    String userProfileString = prefs.getString('user_profile')!;
    Map<String, dynamic> userJson = json.decode(userProfileString);
    return UserProfileModel.fromMap(userJson).userId;
  }

  late int userID;
  Uint8List? imageToSend;
  int chunkSize = 20;
  Future<void> _initializeUserID() async {
    userID = await getMyIdFromPrefs() ?? 0; // Default to 0 if userID is null
  }

  late String channelName;
  Subscription? _subscription;
  List<ChatCardModel> chatsCardsModels = [
    ChatCardModel(name: 'one', image: ''),
    ChatCardModel(name: 'two', image: ''),
    ChatCardModel(name: 'three', image: ''),
  ];

  List<MessageModel> messages = [];
  void _initializePubNub() {
    pubnub = PubNub(
      defaultKeyset: Keyset(
        subscribeKey: subscribeKey,
        publishKey: publishKey,
        userId: UserId(userID.toString()),
      ),
    );
  }

  final Completer<void> _initializationCompleter = Completer<void>();
  ChatBloc({required this.chatRepositoryImp}) : super(ChatInitial()) {
    _initializeUserID().then((_) {
      _initializePubNub();
      _initializationCompleter.complete();
    });

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
          var content = message.content['content'] ?? 'unknown';
          bool iAmTheSender = false;
          String sendeDate = '';
          String messageType =
              message.content['messageType'] == 'text' ? 'text' : 'image';
          if (messageType == 'image') {
            iAmTheSender = userID.toString() ==
                getFileSenderID(message.content['message'] ?? 'unknown');
            sendeDate = getFileDate(message.content['message'] ?? 'unknown');

            String fileId = message.content['file']['id'] ?? 'unknown';
            String fileName = message.content['file']['name'] ?? 'unknown';
            Uri fileUrl =
                pubnub.files.getFileUrl(channelName, fileId, fileName);
            content = fileUrl;
          } else {
            sendeDate = message.content['time'] ?? 'unknown';
            iAmTheSender = message.content['senderId'] == userID.toString();
          }

          MessageModel newReceivedMessage = MessageModel(
            type: messageTypeFromString(messageType),
            content: content,
            timestamp: sendeDate,
            iAmTheSender: iAmTheSender,
          );

          messages.add(newReceivedMessage);
          print('the messages: $messages');
          emit(NewMessageReceivedState(
              messageModel: newReceivedMessage, dateTime: DateTime.now()));
        }
      } catch (e) {
        debugPrint('Error processing messages: $e');
      }
    });

    on<LoadEarlierMessagesEvent>((event, emit) async {
      emit(LoadingEarlierMessagesState());
      chunkSize += 20;
      myChannel = pubnub.channel(channelName);
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
          String sendeDate = '';

          for (final envelope in history.messages) {
            String messageType =
                envelope.content['messageType'] == 'text' ? 'text' : 'image';
            if (messageType == 'image') {
              iAmTheSender = userID.toString() ==
                  getFileSenderID(envelope.content['message'] ?? 'unknown');
              sendeDate = getFileDate(envelope.content['message'] ?? 'unknown');

              String fileId = envelope.content['file']['id'] ?? 'unknown';
              String fileName = envelope.content['file']['name'] ?? 'unknown';
              fileUrl = pubnub.files.getFileUrl(channelName, fileId, fileName);
            } else {
              sendeDate =
                  envelope.originalMessage['message']['time'] ?? 'unknown';
              iAmTheSender = userID.toString() ==
                  envelope.originalMessage['message']['senderId'];
            }
            newMessages.add(MessageModel(
              type: messageTypeFromString(messageType),
              content:
                  messageType == 'text' ? envelope.content['content'] : fileUrl,
              timestamp: sendeDate,
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
      myChannel = pubnub.channel(channelName);
      PaginatedChannelHistory history = myChannel.history(chunkSize: 20);
      await history.more();
      try {
        Uri? fileUrl;
        for (final envelope in history.messages) {
          String sendeDate = '';
          bool iAmTheSender = false;
          if (!hasMessageData(envelope.originalMessage)) {
            iAmTheSender = userID.toString() ==
                getFileSenderID(envelope.content['message'] ?? 'unknown');
            sendeDate = getFileDate(envelope.content['message'] ?? 'unknown');

            String fileId =
                envelope.originalMessage['message']['file']['id'] ?? 'unknown';
            String fileName = envelope.originalMessage['message']['file']
                    ['name'] ??
                'unknown';
            fileUrl = pubnub.files.getFileUrl(channelName, fileId, fileName);
          } else {
            sendeDate = envelope.content['time'] ?? 'unknown';
            iAmTheSender = userID.toString() ==
                envelope.originalMessage['message']['senderId'];
          }

          messages.add(MessageModel(
              type: messageTypeFromString(
                  envelope.content['messageType'] == 'text' ? 'text' : 'image'),
              content: hasMessageData(envelope.originalMessage)
                  ? envelope.content['content'] ?? 'unknown'
                  : fileUrl,
              timestamp: sendeDate,
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
            fileMessage:
                '$userID///${DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())}',
            // fileMessageMeta: {
            //   'senderId': userID.toString(),
            //   'messageType': getMessageTypeFromEnvelope(event.messageType),
            // },
          );
        } else {
          content = event.message;
          await pubnub.publish(
            channelName,
            {
              'senderId': userID.toString(),
              'time': DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
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

    on<GetChatInformation>((event, emit) async {
      final getData =
          await chatRepositoryImp.getChatInformation(event.patientID);
      getData.fold((l) => emit(ChatErrorState(l)), (chatInfoModel) {
        channelName = chatInfoModel.data.channelName;
        print('the channel name from the bloc: $channelName');
        emit(GotChatInfoState());
      });
    });
    on<SendToBackendForNotification>((event, emit) async {
      late String userName;
      if (userData != null) {
        userName = userData!.fullName;
      } else {
        userName = 'Unkown';
      }
      final getData = await chatRepositoryImp.sendToBackendForNotification(
          event.patientID, userName, "message");
      getData.fold((l) {
        isThisFirstMessage = true;
      }, (done) {
        isThisFirstMessage = false;
      });
    });

    on<GetAllMessagesEvent>((event, emit) async {
      emit(ChatsLoadingState());

      await getAllMessages(emit);
    });
  }
}
