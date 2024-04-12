import 'package:graduation_project_therapist_dashboard/app/core/status_requests/staus_request.dart';
import 'package:equatable/equatable.dart';
import 'package:graduation_project_therapist_dashboard/app/features/notification/data/models/notification_model.dart';

sealed class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object> get props => [];
}

final class NotificationInitial extends NotificationState {}

final class NotificationLoading extends NotificationState {}

final class NotificationError extends NotificationState {
  final StatusRequest statusRequest;
  const NotificationError({required this.statusRequest});

  @override
  List<Object> get props => [statusRequest];
}

final class NotificationLoaded extends NotificationState {
  final List<NotificationModel> notifications;
  const NotificationLoaded({required this.notifications});

  @override
  List<Object> get props => [notifications];
}
