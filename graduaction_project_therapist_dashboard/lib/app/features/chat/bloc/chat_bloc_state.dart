import 'package:equatable/equatable.dart';

abstract class ChatState extends Equatable {}

class ChatBlocInitial extends ChatState {
  @override
  List<Object?> get props => [];
}

class MessageSentState extends ChatState {
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
