part of 'video_call_bloc.dart';

@immutable
sealed class VideoCallState extends Equatable {}

final class VideoCallInitial extends VideoCallState {
  @override
  List<Object?> get props => [];
}

final class DoneGettingUserToken extends VideoCallState {
  final String userToken;
  DoneGettingUserToken({required this.userToken});
  @override
  List<Object?> get props => [userToken];
}

final class VideoCallErrorState extends VideoCallState {
  final String error;
  VideoCallErrorState({required this.error});
  @override
  List<Object?> get props => [error];
}

final class GotVideoInfoState extends VideoCallState {
  @override
  List<Object?> get props => [];
}
