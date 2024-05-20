
import 'package:equatable/equatable.dart';

sealed class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object> get props => [];
}
 class FetchAllNotifications extends NotificationEvent {
  const FetchAllNotifications();

  @override
  List<Object> get props => [];
}
