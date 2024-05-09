import 'package:bloc/bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/features/chat/bloc/chat_bloc_event.dart';
import 'package:graduation_project_therapist_dashboard/app/features/chat/bloc/chat_bloc_state.dart';
import 'package:graduation_project_therapist_dashboard/app/features/chat/models/chat_card_model.dart';
import 'package:uuid/uuid.dart';
import 'package:pubnub/pubnub.dart';

String publishKey = 'pub-c-720243bc-7287-40bc-8607-378fe73e2447';
String subscribeKey = 'sub-c-8fbae32e-cb72-4994-b3db-0ddbdf57f043';
String secretKey = 'sec-c-MDdiNWFiYzAtY2I1ZS00MTYxLTk4MGEtMGE5YjA2Y2Y5ZWMw';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  late PubNub pubnub;
  Subscription? _subscription;
  List<ChatCardModel> chatsCardsModels = [
    ChatCardModel(name: 'one', image: ''),
    ChatCardModel(name: 'two', image: ''),
    ChatCardModel(name: 'three', image: ''),
  ];
  String generateUserId() {
    var uuid = const Uuid();
    return uuid.v4(); // Generates a version 4 UUID.
  }

  ChatBloc() : super(ChatBlocInitial()) {
    // Initialize PubNub
    pubnub = PubNub(
        defaultKeyset: Keyset(
            subscribeKey: 'subscribeKey',
            publishKey: 'publishKey',
            userId: UserId(generateUserId())));

    on<SubscribeMessagesEvent>((event, emit) async {
      _subscription = pubnub.subscribe(channels: {'channel_name'});
      await for (final envelope in _subscription!.messages) {
        emit(NewMessageState(envelope.content));
      }
    });

    on<SendMessageEvent>((event, emit) async {
      try {
        // var result =
        await pubnub.publish('channel_name', event.message);
        emit(MessageSentState());
      } catch (e) {
        emit(ErrorState(e.toString()));
      }
    });
    on<GetAllChatsEvent>((event, emit) async {
      emit(GetAllChatsLoaidngState());
      Future.delayed(const Duration(seconds: 1), () {
        emit(GetingAllChatsState(chatsCardsModels));
      });
    });

    // on<UnsubscribeEvent>((event, emit) {
    //   _subscription?.unsubscribe();
    //   emit(UnsubscribedState());
    // });
  }

  @override
  Future<void> close() {
    _subscription?.unsubscribe();
    return super.close();
  }
}
