import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:graduation_project_therapist_dashboard/app/features/home_page/data_source/data_sources/home_page_datasource.dart';
import 'package:graduation_project_therapist_dashboard/app/features/home_page/data_source/models/user_profile_model.dart';
import 'package:graduation_project_therapist_dashboard/app/features/home_page/data_source/models/user_status_enum.dart';

class HomePageRepositoryImp {
  final HomePageDataSource _homePageDataSource;

  HomePageRepositoryImp(this._homePageDataSource);
  Future<Either<String, UserProfileModel>> getUserProfileData() async {
    final response = await _homePageDataSource.getUserProfileData();

    final decodedResponse = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final UserProfileModel userProfileModel =
          UserProfileModel.fromMap(decodedResponse['data']);

      return right(userProfileModel);
    } else if (response.statusCode == 500) {
      if (decodedResponse['error'] == 'jwt expired') {
        return left('jwt expired');
      }
      return left('Server error');
    } else {
      return left(decodedResponse['error']);
    }
  }

  Future<Either<String, UserStatusEnum>> getUserStatusData() async {
    final response = await _homePageDataSource.getUserStatusData();
    final decodedResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return right(userStatusFromString(decodedResponse['data']['status']));
    } else if (response.statusCode == 500) {
      if (decodedResponse['error'] == 'jwt expired') {
        return left('jwt expired');
      }
      return left('Server error');
    } else {
      return left(decodedResponse['error']);
    }
  }

  getRoleID() {}
}
