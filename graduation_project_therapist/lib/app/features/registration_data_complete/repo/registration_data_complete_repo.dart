import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:graduation_project_therapist_dashboard/app/features/registration_data_complete/data_sorce/models/categories_model.dart';
import 'package:graduation_project_therapist_dashboard/app/features/registration_data_complete/data_sorce/models/complete_register_model.dart';
import 'package:graduation_project_therapist_dashboard/app/features/registration_data_complete/data_sorce/r_d_c_data_sorce.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';
import 'package:http/http.dart';

class RegistrationDataCompleteRepoIpm {
  final RegistrationDataCompleteRemoteDataSource
      registrationDataCompleteRemoteDataSource;

  RegistrationDataCompleteRepoIpm(
      this.registrationDataCompleteRemoteDataSource);

  Future<Either<String, String>> completeRegister(
      CompleteRegisterModel completeRegisterModel) async {
    try {
      final Response response = await registrationDataCompleteRemoteDataSource
          .completeRegister(completeRegisterModel);
      final decodedResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        sharedPreferences!.remove('user_status');
        return const Right('register completed');
      } else if (response.statusCode != 500) {
        return Left(decodedResponse['error']);
      } else {
        return const Left('Server Error');
      }
    } catch (e) {
      debugPrint('error in repo data complete: ${e.toString()}');
      return const Left('Server Error');
    }
  }

  Future<Either<String, List<SpeCategory>>> getAllCategories() async {
    try {
      final Response response =
          await registrationDataCompleteRemoteDataSource.getAllCategories();
      final decodedResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final List<SpeCategory> categories = (decodedResponse['data'] as List)
            .map((item) => SpeCategory.fromJson(item))
            .toList();

        return Right(categories);
      } else if (response.statusCode != 500) {
        return Left(decodedResponse['error']);
      } else {
        return const Left('Server Error');
      }
    } catch (e) {
      debugPrint('error in repo geting categories: ${e.toString()}');
      return const Left('Server Error');
    }
  }
}
