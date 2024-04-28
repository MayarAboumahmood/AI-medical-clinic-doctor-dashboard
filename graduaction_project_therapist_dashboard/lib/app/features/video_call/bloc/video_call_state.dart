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
