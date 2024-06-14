import 'package:graduation_project_therapist_dashboard/app/core/status_requests/staus_request.dart';
import 'package:graduation_project_therapist_dashboard/app/features/notification/data/data_source/notification_data_source.dart';
import 'package:graduation_project_therapist_dashboard/app/features/notification/data/models/notification_model.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_functions/get_status_request_from_status_code.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

abstract class NotificationRepository {
  Future<Either<StatusRequest, List<NotificationModel>>> getAllNotifications();
}

class NotificationRepositoryImplementation implements NotificationRepository {
  final NotificationDataSource _notificationDataSource;

  NotificationRepositoryImplementation(this._notificationDataSource);

  @override
  Future<Either<StatusRequest, List<NotificationModel>>>
      getAllNotifications() async {
    try {
      final getData = await _notificationDataSource.getAllNotification();
      return getData.fold(
        (statusRequest) => Left(getStatusFromCode(statusRequest)),
        (allNotificationsAsJson) {
          List<NotificationModel> allNotifications = allNotificationsAsJson
              .map<NotificationModel>((json) => NotificationModel.fromMap(json))
              .toList();
          return Right(allNotifications);
        },
      );
    } catch (e) {
      if (kDebugMode) {
        print('The error in getting all notifications: $e');
      }
      return const Left(StatusRequest.serverError);
    }
  }
}
