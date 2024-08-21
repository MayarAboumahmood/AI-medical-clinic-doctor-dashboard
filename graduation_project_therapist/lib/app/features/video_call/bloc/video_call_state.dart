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

final class SessionCompletedFromOneSideDoneState extends VideoCallState {
  @override
  List<Object?> get props => [];
}

final class SessionIsCompletedState extends VideoCallState {
  final bool status;
  SessionIsCompletedState({required this.status});
  @override
  List<Object?> get props => [status];
}

final class SessionCompletedLoadingState extends VideoCallState {
  @override
  List<Object?> get props => [];
}

final class CheckIfSessionCompletedLoadingtState extends VideoCallState {
  @override
  List<Object?> get props => [];
}

final class ReportingVideoCallLoadingtState extends VideoCallState {
  @override
  List<Object?> get props => [];
}

final class VideoCallReportingErrorState extends VideoCallState {
  final String errorMessage;
  VideoCallReportingErrorState({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}

final class ReportingVideoCallCompletedState extends VideoCallState {
  ReportingVideoCallCompletedState();
  @override
  List<Object?> get props => [];
}
