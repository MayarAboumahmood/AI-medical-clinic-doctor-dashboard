import 'package:bloc/bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/features/chat/bloc/chat_event.dart';
import 'package:graduation_project_therapist_dashboard/app/features/chat/bloc/chat_state.dart';
import 'package:graduation_project_therapist_dashboard/app/features/chat/models/chat_card_model.dart';
import 'package:graduation_project_therapist_dashboard/app/features/chat/models/message_model.dart';
import 'package:uuid/uuid.dart';
import 'package:pubnub/pubnub.dart';

String publishKey = 'pub-c-720243bc-7287-40bc-8607-378fe73e2447';
String subscribeKey = 'sub-c-8fbae32e-cb72-4994-b3db-0ddbdf57f043';
String channelName = 'graduationProject...';
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
    // Add more fake messages as needed
  ];

  String generateUserId() {
    var uuid = const Uuid();
    return uuid.v4(); // Generates a version 4 UUID.
  }

  ChatBloc() : super(ChatInitial()) {
    // Initialize PubNub
    pubnub = PubNub(
        defaultKeyset: Keyset(
            subscribeKey: subscribeKey,
            publishKey: publishKey,
            userId: UserId(generateUserId())));

    on<SubscribeMessagesEvent>((event, emit) async {
      _subscription = pubnub.subscribe(channels: {channelName});
      await for (final envelope in _subscription!.messages) {
        emit(NewMessageState(envelope.content));
      }
    });
 
    on<SendMessageEvent>((event, emit) async {
      try {
        await pubnub.publish(channelName, event.message);

        final MessageModel newMessage = MessageModel(
            type: event.messageType,
            content: event.message,
            timestamp: event.timestamp,
            iAmTheSender: true);
        messages.add(newMessage);
        emit(MessageSentState(
            dateTime: DateTime.now(), messageModel: newMessage));
      } catch (e) {
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
      // emit(ChatsLoadingState());
      // Future.delayed(const Duration(milliseconds: 200), () {
      emit(GotAllMessagesState(messages: messages));
      // });
    });

    on<UnsubscribeEvent>((event, emit) {
      _subscription?.unsubscribe();
      emit(UnsubscribedState());
    });
  }

  @override
  Future<void> close() {
    _subscription?.unsubscribe();
    return super.close();
  }
}
