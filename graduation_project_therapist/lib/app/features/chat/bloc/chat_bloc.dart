import 'dart:math';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

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
    return '${firstID}graduationProjectll$secondID';
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

    on<AddImageToSendEvent>((event, emit) async {
      imageToSend = event.imageToSend;
    });

    on<ReceiveNewMessageEvent>((event, emit) async {
      // Ensure subscription is active and not null.
      if (_subscription == null || _subscription!.isPaused) {
        // Handle case where subscription might not be set up or is paused.
        debugPrint("Subscription is not active.");
        return;
      }
      try {
        // Await for each message in the subscription's stream.
        await for (final message in _subscription!.messages) {
          // Check if Bloc is closed before emitting a new state.
          if (isClosed) {
            debugPrint("Bloc is closed, stopping message processing.");
            return;
          }
          if (message.content['senderId'] == userID.toString()) {
            return;
          }
          // Create a new received message model.
          MessageModel newReceivedMessage = MessageModel(
            type: MessageTypeEnum
                .text, // Determine type more dynamically if needed
            content: message.content['content'],
            timestamp: DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
            iAmTheSender: false,
          );

          messages.add(newReceivedMessage);
          emit(NewMessageReceivedState(
              messageModel: newReceivedMessage, dateTime: DateTime.now()));
        }
      } catch (e) {
        debugPrint('Error processing messages: $e');
      }
    });

    String getMessageTypeFromEnvelope(MessageTypeEnum messageType) {
      switch (messageType) {
        case MessageTypeEnum.text:
          return 'text';
        case MessageTypeEnum.image:
          return 'image';
        case MessageTypeEnum.voice:
          return 'voice';
        default:
          return 'text';
      }
    }

    on<UnsubscribeEvent>((event, emit) {
      messages.clear();
      _subscription?.unsubscribe();

      emit(UnsubscribedState());
    });
    on<SubscribeMessagesEvent>((event, emit) async {
      // Subscription to the channel
      _subscription = pubnub.subscribe(channels: {channelName});
    });
    final KeysetStore keysetStore = pubnub.keysets;
    late String senderId;

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
            'fileName',
            event.imageData!,
            fileMessage: '',
            fileMessageMeta: {
              'senderId': senderId,
              'content': content,
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
        final MessageModel newMessage = MessageModel(
            type: event.messageType,
            content: content,
            timestamp: event.timestamp,
            iAmTheSender: true);
        messages.add(newMessage);
        emit(MessageSentState(messageModel: newMessage));
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

  MessageTypeEnum messageTypeFromString(String type) {
    switch (type) {
      case 'text':
        return MessageTypeEnum.text;
      case 'image':
        return MessageTypeEnum.image;
      case 'voice':
        return MessageTypeEnum.voice;
      default:
        throw MessageTypeEnum.text;
    }
  }

  bool hasMessageData(Map<String, dynamic> messageObj) {
    if (messageObj.containsKey('message')) {
      Map<String, dynamic> message = messageObj['message'];

      if (message.containsKey('content') &&
          message['content'] != null &&
          message['content'].toString().isNotEmpty) {
        return true;
      }
      if (message.containsKey('senderId') && message['senderId'] != null) {
        return true;
      }
      if (message.containsKey('messageType') &&
          message['messageType'] != null &&
          message['messageType'].toString().isNotEmpty) {
        return true;
      }
    }
    return false;
  }

  Future<void> getAllMessages(Emitter<ChatState> emit) async {
    final myChannel = pubnub.channel(channelName);
    var history = myChannel.history(chunkSize: 50);
    await history.more();
    try {
      for (final envelope in history.messages) {
        if (!hasMessageData(envelope.originalMessage)) {
          print(
              'sssssssssssssssssss error: ${envelope.originalMessage['message']['file']}');
        }

        bool iAmTheSender = envelope.content['senderId'] == userID.toString();
        final String timestamp =
            DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
        messages.add(MessageModel(
            type: messageTypeFromString(
                envelope.content['messageType'] ?? 'image'),
            content: envelope.content['content'],
            timestamp: timestamp,
            iAmTheSender: iAmTheSender));
        emit(NewMessageState(envelope.content));
      }
    } catch (e) {
      debugPrint('Error while getting messages: $e');
      emit(ChatErrorState(e.toString()));
    }
    emit(GotAllMessagesState(messages: messages));
  }
}
