import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:graduation_project_therapist_dashboard/app/features/home_page/data_source/data_sources/home_page_datasource.dart';
import 'package:graduation_project_therapist_dashboard/app/features/user_profile/data_source/models/user_profile_model.dart';

class HomePageRepositoryImp {
  final HomePageDataSource _homePageDataSource;

  HomePageRepositoryImp(this._homePageDataSource);
  Future<Either<String, UserProfileModel>> getUserProfileData() async {
    final response = await _homePageDataSource.getUserProfileData();
    final decodedResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      final UserProfileModel userProfileModel = UserProfileModel.fromJson(decodedResponse);
      return right(userProfileModel);
    } else if (response.statusCode == 500) {
      return left('Server error');
    } else {
      return left(decodedResponse['error']);
    }
  }

  Future<Either<String, int>> getUserStatusData() async {
    final response = await _homePageDataSource.getUserStatusData();
    final decodedResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return right(
          decodedResponse['user_status']); //TODO: check the response data.
    } else if (response.statusCode == 500) {
      return left('Server error');
    } else {
      return left(decodedResponse['error']);
    }
  }
}
