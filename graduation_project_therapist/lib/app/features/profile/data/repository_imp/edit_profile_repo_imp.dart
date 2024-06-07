import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:graduation_project_therapist_dashboard/app/features/profile/data/data_source/profile_data_source.dart';
import 'package:graduation_project_therapist_dashboard/app/features/profile/data/edite_profile_repo.dart';
import 'package:graduation_project_therapist_dashboard/app/features/profile/data/model/edit_profile_model.dart';
import 'package:http/http.dart';

class EditProfileRepositoryImpl implements EditProfileRepository {
  final ProfileDataSource profileDataSource;

  EditProfileRepositoryImpl(this.profileDataSource);
  @override
  Future<Either<String, String>> editProfile(
      EditProfileModel editProfileModel) async {
    try {
      final Response response =
          await profileDataSource.editProfile(editProfileModel);
      final decodedResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return const Right('profile edited');
      } else if (response.statusCode != 500) {
        return Left(decodedResponse['error']);
      } else {
        return const Left('Server Error');
      }
    } catch (e) {
      debugPrint('error in repo editing profile: ${e.toString()}');
      return const Left('Server Error');
    }
  }

  @override
  Future<Either<String, String>> resetPassword(
      String old, String newPassword) async {
    try {
      final Response response =
          await profileDataSource.resetPassword(old, newPassword);
      final decodedResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return const Right('your password has been updated');
      } else if (response.statusCode != 500) {
        return Left(decodedResponse['error']);
      }
      return const Left('Server Error');
    } catch (e) {
      return const Left('Server Error');
    }
  }

  @override
  Future<Either<String, String>> deleteAccount() async {
    try {
      final Response response = await profileDataSource.deleteAccount();
      final decodedResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return const Right('Done');
      } else if (response.statusCode != 500) {
        return left(decodedResponse['error']);
      }
      return const Left('Server error');
    } catch (e) {
      return const Left('Server error');
    }
  }
}
