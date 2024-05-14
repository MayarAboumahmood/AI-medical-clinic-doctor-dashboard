import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:pubnub/pubnub.dart';
import 'package:uuid/uuid.dart';

import 'package:graduation_project_therapist_dashboard/app/features/chat/bloc/chat_event.dart';
import 'package:graduation_project_therapist_dashboard/app/features/chat/bloc/chat_state.dart';
import 'package:graduation_project_therapist_dashboard/app/features/chat/models/chat_card_model.dart';
import 'package:graduation_project_therapist_dashboard/app/features/chat/models/message_model.dart';

String publishKey = 'pub-c-720243bc-7287-40bc-8607-378fe73e2447';
String subscribeKey = 'sub-c-8fbae32e-cb72-4994-b3db-0ddbdf57f043';
String channelName = 'graduationProject';
String secretKey = 'sec-c-MDdiNWFiYzAtY2I1ZS00MTYxLTk4MGEtMGE5YjA2Y2Y5ZWMw';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  late PubNub pubnub;
  Subscription? _subscription;
  List<ChatCardModel> chatsCardsModels = [
    ChatCardModel(name: 'one', image: ''),
    ChatCardModel(name: 'two', image: ''),
    ChatCardModel(name: 'three', image: ''),
  ];

  List<MessageModel> messages = [
    MessageModel(
        type: MessageTypeEnum.text,
        content: 'Hi, how are you?',
        timestamp: '5/4/2022',
        iAmTheSender: true),
    MessageModel(
        type: MessageTypeEnum.image,
        content: 'https://example.com/image.jpg',
        timestamp: '5/5/2022',
        iAmTheSender: false),
    MessageModel(
        type: MessageTypeEnum.voice,
        content: 'https://example.com/voice.mp3',
        timestamp: '5/6/2022',
        iAmTheSender: true),
    MessageModel(
        type: MessageTypeEnum.text,
        content: 'This is another text message.',
        timestamp: '5/7/2022',
        iAmTheSender: true),
  ];

  String generateUserId() {
    var uuid = const Uuid();
    return uuid.v4();
  }

  ChatBloc() : super(ChatInitial()) {
    pubnub = PubNub(
      defaultKeyset: Keyset(
        subscribeKey: subscribeKey,
        publishKey: publishKey,
        userId: UserId(
          generateUserId(),
        ),
      ),
    );

    on<ReciveNewMessageEvent>((event, emit) async {
      _subscription!.messages.listen((message) {
        print('Received message: ${message.content}');

        MessageModel newRecivedMessage = MessageModel(
          type: MessageTypeEnum.text,
          content: message.content,
          timestamp: DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
          iAmTheSender: false,
        );
        messages.add(newRecivedMessage);
        emit(NewMessageReceivedState(messageModel: newRecivedMessage));
      });
    });
// Helper method to determine message type from envelope
    MessageTypeEnum getMessageTypeFromEnvelope(dynamic envelope) {
      // Implement logic based on envelope properties
      return MessageTypeEnum.text; // Example default return
    }

    on<SubscribeMessagesEvent>((event, emit) async {
      // Subscription to the channel
      _subscription = pubnub.subscribe(channels: {channelName});

      // Listen to new messages
      _subscription!.messages.listen((envelope) {
        print('Received message: ${envelope.content}');

        // Assuming 'content' is a field in the message envelope
        MessageModel newReceivedMessage = MessageModel(
            type: getMessageTypeFromEnvelope(
                envelope), // Ensure you have a method to determine the message type
            content:
                envelope.content['content'], // Access the correct content field
            timestamp: DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
            iAmTheSender: false // Determine if the sender is the user
            );

        messages.add(newReceivedMessage);
        emit(NewMessageReceivedState(messageModel: newReceivedMessage));
      });

      // add(ReciveNewMessageEvent()); // You might not need this if the listener is already set up
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
    if (_subscription == null) {
      print('Subscription is null, returning');
      return;
    } else {
      print('Subscription is not null');
    }
    try {
      print('Listening for messages');
      await for (final envelope in _subscription!.messages) {
        print('Received envelope: ');
        print('Received envelope: ${envelope.content}');
        final String timestamp =
            DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
        messages.add(MessageModel(
            type: MessageTypeEnum
                .text, // Make sure this is dynamically determined based on actual message
            content: envelope.content['content'], // Ensure this key is correct
            timestamp: timestamp,
            iAmTheSender: false));
        emit(NewMessageState(envelope.content));
      }
      print('evelope not enter');
    } catch (e) {
      print('Error while getting messages: $e');
      emit(ChatErrorState(e.toString()));
    }

    // Always emit a state to update the UI
    emit(GotAllMessagesState(messages: messages));
  }

  // @override
  // Future<void> close() {
  //   _subscription?.unsubscribe();
  //   return super.close();
  // }
}

    // on<UnsubscribeEvent>((event, emit) {
    //   _subscription?.unsubscribe();
    //   emit(UnsubscribedState());
    // });