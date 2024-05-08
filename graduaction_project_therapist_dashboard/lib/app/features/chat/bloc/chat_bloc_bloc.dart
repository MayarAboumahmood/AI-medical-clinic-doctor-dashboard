import 'package:bloc/bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/features/chat/bloc/chat_bloc_event.dart';
import 'package:graduation_project_therapist_dashboard/app/features/chat/bloc/chat_bloc_state.dart';

import 'package:pubnub/pubnub.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  late PubNub pubnub;
  Subscription? _subscription;

  ChatBloc() : super(ChatBlocInitial()) {
    // Initialize PubNub
    pubnub = PubNub(
        defaultKeyset: Keyset(
            subscribeKey: 'your_subscribe_key',
            publishKey: 'your_publish_key',
            userId: const UserId('user_uuid')));

    on<SubscribeMessagesEvent>((event, emit) async {
      _subscription = pubnub.subscribe(channels: {'channel_name'});
      await for (final envelope in _subscription!.messages) {
        emit(NewMessageState(envelope.message));
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
