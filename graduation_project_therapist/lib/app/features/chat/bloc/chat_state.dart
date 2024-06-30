import 'package:equatable/equatable.dart';
import 'package:graduation_project_therapist_dashboard/app/features/chat/models/chat_card_model.dart';
import 'package:graduation_project_therapist_dashboard/app/features/chat/models/message_model.dart';

abstract class ChatState extends Equatable {}

class ChatInitial extends ChatState {
  @override
  List<Object?> get props => [];
}

class MessageSentState extends ChatState {
  final MessageModel messageModel;

  MessageSentState({required this.messageModel});
  @override
  List<Object?> get props => [messageModel];
}

class NewMessageReceivedState extends ChatState {
  final MessageModel messageModel;
  final DateTime dateTime;

  NewMessageReceivedState({required this.messageModel, required this.dateTime});
  @override
  List<Object?> get props => [messageModel, dateTime];
}

class ChatsLoadingState extends ChatState {
  @override
  List<Object?> get props => [];
}

class UnsubscribedState extends ChatState {
  @override
  List<Object?> get props => [];
}

class NewMessageState extends ChatState {
  final dynamic message;

  NewMessageState(this.message);
  @override
  List<Object?> get props => [message];
}

class ChatErrorState extends ChatState {
  final String errorMessage;

  ChatErrorState(this.errorMessage);
  @override
  List<Object?> get props => [errorMessage];
}

class GotChatInfoState extends ChatState {
  GotChatInfoState();
  @override
  List<Object?> get props => [];
}
class GotAllChatsState extends ChatState {
  final List<ChatCardModel> chatsCardsModels;

  GotAllChatsState(this.chatsCardsModels);
  @override
  List<Object?> get props => [chatsCardsModels];
}

class GotAllMessagesState extends ChatState {
  final List<MessageModel> messages;

  GotAllMessagesState({required this.messages});
  @override
  List<Object?> get props => [messages];
}

class LoadingEarlierMessagesState extends ChatState {
  @override
  List<Object?> get props => [];
}

class EarlierMessagesLoadedState extends ChatState {
  final List<MessageModel> earlierMessages;
  final bool noMoreMessages;
  EarlierMessagesLoadedState(
      {required this.earlierMessages, required this.noMoreMessages});

  @override
  List<Object?> get props => [earlierMessages, noMoreMessages];
}
