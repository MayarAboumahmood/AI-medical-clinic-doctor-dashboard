import 'package:equatable/equatable.dart';
import 'package:graduation_project_therapist_dashboard/app/features/chat/models/chat_card_model.dart';

abstract class ChatState extends Equatable {}

class ChatBlocInitial extends ChatState {
  @override
  List<Object?> get props => [];
}

class MessageSentState extends ChatState {
  @override
  List<Object?> get props => [];
}
class GetAllChatsLoaidngState extends ChatState {
  @override
  List<Object?> get props => [];
}

class NewMessageState extends ChatState {
  final dynamic message;

  NewMessageState(this.message);
  @override
  List<Object?> get props => [message];
}

class ErrorState extends ChatState {
  final String errorMessage;

  ErrorState(this.errorMessage);
  @override
  List<Object?> get props => [errorMessage];
}

class GetingAllChatsState extends ChatState {
  final List<ChatCardModel> chatsCardsModels;

  GetingAllChatsState(this.chatsCardsModels);
  @override
  List<Object?> get props => [chatsCardsModels];
}
