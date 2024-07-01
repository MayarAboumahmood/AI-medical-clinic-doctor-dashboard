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
