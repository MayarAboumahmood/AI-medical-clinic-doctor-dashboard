import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:graduation_project_therapist_dashboard/app/features/block/data_source/data_sources/block_datasource.dart';
import 'package:graduation_project_therapist_dashboard/app/features/home_page/data_source/models/user_profile_model.dart';
import 'package:graduation_project_therapist_dashboard/app/features/home_page/data_source/models/user_status_enum.dart';

class BlockRepositoryImp {
  final BlockDataSource _blockDataSource;

  BlockRepositoryImp(this._blockDataSource);
  Future<Either<String, UserProfileModel>> getUserProfileData() async {
    final response = await _blockDataSource.getUserProfileData();

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

  Future<Either<String, UserStatusEnum>> blockPatient(int patientId) async {
    final response = await _blockDataSource.blockPatient(patientId);
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
}
