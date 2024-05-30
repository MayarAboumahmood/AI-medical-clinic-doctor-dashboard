import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:graduation_project_therapist_dashboard/app/features/auth/data_source/model/register_model.dart';
import 'package:graduation_project_therapist_dashboard/app/features/home_page/data_source/home_page_datasource.dart';

class HomePageRepositoryImp {
  final HomePageDataSource _homePageDataSource;

  HomePageRepositoryImp(this._homePageDataSource);
  Future<Either<String, UserInfo>> getUserProfileData() async {
    final response = await _homePageDataSource.getUserProfileData();
    final decodedResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      final UserInfo userInfo = UserInfo.fromJson(decodedResponse);
      return right(userInfo);
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
