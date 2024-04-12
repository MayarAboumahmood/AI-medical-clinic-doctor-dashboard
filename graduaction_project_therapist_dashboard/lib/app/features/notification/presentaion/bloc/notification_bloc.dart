import 'package:graduation_project_therapist_dashboard/app/features/notification/data/repository_imp/get_notification_data_repo_imp.dart';
import 'package:graduation_project_therapist_dashboard/app/features/notification/presentaion/bloc/notification_event.dart';
import 'package:graduation_project_therapist_dashboard/app/features/notification/presentaion/bloc/notification_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationRepositoryImplementation notificationRepository;

  NotificationBloc({required this.notificationRepository})
      : super(NotificationInitial()) {
    on<FetchAllNotifications>(_onFetchAllNotifications);
  }

  Future<void> _onFetchAllNotifications(
      FetchAllNotifications event, Emitter<NotificationState> emit) async {
    emit(NotificationLoading());
    final eitherResponse = await notificationRepository.getAllNotifications();

    eitherResponse.fold(
      (failure) => emit(NotificationError(statusRequest: failure)),
      (notifications) => emit(NotificationLoaded(notifications: notifications)),
    );
  }
}
