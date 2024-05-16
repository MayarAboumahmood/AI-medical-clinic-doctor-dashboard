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

  ChatBloc() : super(ChatInitial()) {
    channelName = '${user2ID.toString()}graduationProject${userID.toString()}';

    pubnub = PubNub(
      defaultKeyset: Keyset(
        subscribeKey: subscribeKey,
        publishKey: publishKey,
        userId: UserId(
          userID.toString(),
        ),
      ),
    );

    on<ReceiveNewMessageEvent>((event, emit) async {
      // Ensure subscription is active and not null.
      if (_subscription == null || _subscription!.isPaused) {
        // Handle case where subscription might not be set up or is paused.
        print("Subscription is not active.");
        return;
      }

      try {
        // Await for each message in the subscription's stream.
        await for (final message in _subscription!.messages) {
          print('Received message: ${message.content}');
          print('Received message: ${message.content['content']}');

          // Check if Bloc is closed before emitting a new state.
          if (isClosed) {
            print("Bloc is closed, stopping message processing.");
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
            iAmTheSender:
                false, // Determine this based on message sender ID vs current user ID
          );

          // Add the new message to your list of messages.
          messages.add(newReceivedMessage);

          // Emit a new state with the received message.
          emit(NewMessageReceivedState(
              messageModel: newReceivedMessage, dateTime: DateTime.now()));
        }
      } catch (e) {
        print('Error processing messages: $e');
        // Optionally handle or emit error state
      }
    });

// Helper method to determine message type from envelope
    MessageTypeEnum getMessageTypeFromEnvelope(dynamic envelope) {
      // Implement logic based on envelope properties
      return MessageTypeEnum.text; // Example default return
    }

    on<UnsubscribeEvent>((event, emit) {
      messages.clear();
      _subscription?.unsubscribe();
      print('sssssssssssssssssssss unsubscribe: $messages');

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
        await pubnub.publish(
          channelName,
          {
            'senderId': senderId,
            'content': event.message,
          },
        );
        final MessageModel newMessage = MessageModel(
            type: event.messageType,
            content: event.message,
            timestamp: event.timestamp,
            iAmTheSender: true);
        messages.add(newMessage);
        emit(MessageSentState(messageModel: newMessage));
      } catch (e) {
        print(
            'sssssssssssssssss error in the bloc when sending the message: ${e.toString()}');
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

  Future<void> getAllMessages(Emitter<ChatState> emit) async {
    final myChannel = pubnub.channel(channelName);
    var history = myChannel.history(chunkSize: 50);
    await history.more();
    try {
      for (final envelope in history.messages) {
        print('Received envelope in loop: ${envelope.content}');
        bool iAmTheSender = envelope.content['senderId'] == userID.toString();
        print('I am the sender: $iAmTheSender');

        final String timestamp =
            DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
        messages.add(MessageModel(
            type: MessageTypeEnum
                .text, // Make sure this is dynamically determined based on actual message
            content: envelope.content['content'], // Ensure this key is correct
            timestamp: timestamp,
            iAmTheSender: iAmTheSender));
        emit(NewMessageState(envelope.content));
      }
    } catch (e) {
      debugPrint('Error while getting messages: $e');
      emit(ChatErrorState(e.toString()));
    }

    // Always emit a state to update the UI
    emit(GotAllMessagesState(messages: messages));
  }

  // @override
  // Future<void> close() {
  //   _subscription?.unsubscribe();
  //   messages.clear();
  //   print('sssssssssssssssssssss unsubscribe: $messages');
  //   return super.close();
  // }
}
