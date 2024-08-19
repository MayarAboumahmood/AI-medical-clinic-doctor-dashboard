part of 'video_call_bloc.dart';

@immutable
sealed class VideoCallEvent extends Equatable {}

class GetUserTokenEvent extends VideoCallEvent {
  @override
  List<Object?> get props => [];
}

class VideoInitEvent extends VideoCallEvent {
  @override
  List<Object?> get props => [];
}

class GetChatInformation extends VideoCallEvent {
  final int patientID;
  GetChatInformation({required this.patientID});
  @override
  List<Object?> get props => [];
}
class SendCompleteSessionEvent extends VideoCallEvent {
  final int appointmentId;
  SendCompleteSessionEvent({required this.appointmentId});
  @override
  List<Object?> get props => [];
}
class CheckIfSessionCompletedEvent extends VideoCallEvent {
  final int appointmentId;
  CheckIfSessionCompletedEvent({required this.appointmentId});
  @override
  List<Object?> get props => [];
}
