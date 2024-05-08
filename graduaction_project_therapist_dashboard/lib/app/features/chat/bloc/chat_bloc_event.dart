import 'package:equatable/equatable.dart';

sealed class ChatEvent extends Equatable {}

class SendMessageEvent extends ChatEvent {
  final String message;

  SendMessageEvent(this.message);

  @override
  List<Object?> get props => [message];
}

class SubscribeMessagesEvent extends ChatEvent {
  @override
  List<Object?> get props => [];
}
