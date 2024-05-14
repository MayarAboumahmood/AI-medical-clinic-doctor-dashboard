import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:graduation_project_therapist_dashboard/app/features/chat/models/message_model.dart';

sealed class ChatEvent extends Equatable {}

class SendMessageEvent extends ChatEvent {
  final String message;
  final MessageTypeEnum messageType;
  final String timestamp =
      DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

  SendMessageEvent({required this.message, required this.messageType});

  @override
  List<Object?> get props => [message, messageType, timestamp];
}

class SubscribeMessagesEvent extends ChatEvent {
  @override
  List<Object?> get props => [];
}
class ReciveNewMessageEvent extends ChatEvent {
  @override
  List<Object?> get props => [];
}

class GetAllChatsEvent extends ChatEvent {
  @override
  List<Object?> get props => [];
}

class GetAllMessagesEvent extends ChatEvent {
  @override
  List<Object?> get props => [];
}

class UnsubscribeEvent extends ChatEvent {
  @override
  List<Object?> get props => [];
}
