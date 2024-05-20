import 'dart:convert';

import 'package:graduation_project_therapist_dashboard/app/core/injection/app_injection.dart';
import 'package:graduation_project_therapist_dashboard/app/core/server/server_config.dart';
import 'package:graduation_project_therapist_dashboard/app/core/service/shared_preferences.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

abstract class NotificationDataSource {
  Future<Either<int, List<dynamic>>> getAllNotification();
}

class NotificationDataSourceImp implements NotificationDataSource {
  http.Client client;

  NotificationDataSourceImp({
    required this.client,
  });

  @override
  Future<Either<int, List<dynamic>>> getAllNotification() async {
    String token = await sl<PrefService>().readString('token');
    final headers = {'Authorization': 'Bearer $token'};
    final response = await client.get(
        Uri.parse(ServerConfig.baseURL + ServerConfig.getAllNotificationURL),
        headers: headers);
    if (response.statusCode == 200) {
      try {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['status'] == true &&
            jsonResponse['Notification'] != null) {
          List<dynamic> dataJsonList = jsonResponse['Notification'];
          return Right(dataJsonList);
        } else {
          return const Left(500);
        }
      } catch (e) {
        return const Left(500);
      }
    } else {
      return Left(response.statusCode);
    }
  }
}
