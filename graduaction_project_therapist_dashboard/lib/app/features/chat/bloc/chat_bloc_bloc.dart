import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'chat_bloc_event.dart';
part 'chat_bloc_state.dart';

class ChatBlocBloc extends Bloc<ChatBlocEvent, ChatBlocState> {
  ChatBlocBloc() : super(ChatBlocInitial()) {
    on<ChatBlocEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
