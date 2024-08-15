import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/app/features/user_profile/data_source/models/bot_score.dart';
import 'package:graduation_project_therapist_dashboard/app/features/user_profile/data_source/models/patient_profile_model.dart';
import 'package:graduation_project_therapist_dashboard/app/features/user_profile/data_source/patient_profile_data_source.dart';

class PatientsProfileRepositoryImp {
  final PatientProfileDataSource _patientProfileDataSource;

  PatientsProfileRepositoryImp(this._patientProfileDataSource);
  Future<Either<String, PatientProfileModel>> getPatientsProfile(
      int patientID) async {
    try {
      final response =
          await _patientProfileDataSource.getPatientsProfile(patientID);
      final decodedResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final PatientProfileModel patientProfileModel =
            PatientProfileModel.fromJson(decodedResponse);
        return right(patientProfileModel);
      } else if (response.statusCode == 500) {
        if (decodedResponse['error'] == 'jwt expired') {
          return left('jwt expired');
        }
        return left('Server error');
      } else {
        return left(decodedResponse['error']);
      }
    } catch (e) {
      debugPrint('error in get patient profile repo: $e');
      return left('Server Error');
    }
  }

  Future<Either<String, String>> assignPatientToTherapist(
      int patientID, int therapistID) async {
    try {
      final response = await _patientProfileDataSource.assignPatientToTherapist(
          patientID, therapistID);
      final decodedResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return right('done');
      } else if (response.statusCode == 500) {
        if (decodedResponse['error'] == 'jwt expired') {
          return left('jwt expired');
        }
        return left('Server error');
      } else {
        return left(decodedResponse['error']);
      }
    } catch (e) {
      debugPrint('error in get patient profile repo: $e');
      return left('Server Error');
    }
  }

  Future<Either<String, String>> therapistRequestToPateint(
      String date, String time, int userId, String description) async {
    try {
      final response = await _patientProfileDataSource
          .therapistRequestToPateint(date, time, userId, description);
      final decodedResponse = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return right('done');
      } else if (response.statusCode == 500) {
        if (decodedResponse['error'] == 'jwt expired') {
          return left('jwt expired');
        }
        return left('Server error');
      } else {
        return left(decodedResponse['error']);
      }
    } catch (e) {
      debugPrint('error in therapist Request To Pateint repo: $e');
      return left('Server Error');
    }
  }

  Future<Either<String, BotScoreResponse>> getPatientsBotScore(
      int userId) async {
    try {
      final response =
          await _patientProfileDataSource.getPatientsBotScore(userId);
      final decodedResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        BotScoreResponse botScoreResponse =
            BotScoreResponse.fromJson(decodedResponse);
        return right(botScoreResponse);
      } else if (response.statusCode == 500) {
        if (decodedResponse['error'] == 'jwt expired') {
          return left('jwt expired');
        }
        return left('Server error');
      } else {
        return left(decodedResponse['error']);
      }
    } catch (e) {
      debugPrint('error in get patient bot score repo: $e');
      return left('Server Error');
    }
  }
}
