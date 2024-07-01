import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/app/features/patient_requests/data_source/data_source/patient_requests_datasource.dart';
import 'package:graduation_project_therapist_dashboard/app/features/patient_requests/data_source/models/user_request_model.dart';

class PatientRequestsRepositoryImp {
  final PatientRequestsDataSource _patientRequestsDataSource;

  PatientRequestsRepositoryImp(this._patientRequestsDataSource);
  Future<Either<String, List<PatientRequestModel>>> getPatientRequests() async {
    try {
      final response = await _patientRequestsDataSource.getPatientRequests();
      final decodedResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final List<dynamic> data = decodedResponse['data'];
        final List<PatientRequestModel> getTherapistModel =
            data.map((item) => PatientRequestModel.fromMap(item)).toList();
        return right(getTherapistModel);
      } else if (response.statusCode == 500) {
        if (decodedResponse['error'] == 'jwt expired') {
          return left('jwt expired');
        }
        return left('Server error');
      } else {
        return left(decodedResponse['error']);
      }
    } catch (e) {
      debugPrint('error in get Patient Requests repo: $e');
      return left('Server Error');
    }
  }

  Future<Either<String, String>> acceptPatientRequest(
      int requestID, String date, String time) async {
    try {
      final response = await _patientRequestsDataSource.acceptPatientRequest(
          requestID, date, time);
      final decodedResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return right('done');
      } else if (response.statusCode == 500) {
        if (decodedResponse['message'] == 'jwt expired') {
          return left('jwt expired');
        }
        return left('Server error');
      } else {
        return left(decodedResponse['message']);
      }
    } catch (e) {
      debugPrint('error in accept Patient Request repo: $e');
      return left('Server Error');
    }
  }

  Future<Either<String, String>> rejectPatientRequest(int requestId) async {
    try {
      final response =
          await _patientRequestsDataSource.rejectPatientRequest(requestId);
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
      debugPrint('error in reject Patient Request repo: $e');
      return left('Server Error');
    }
  }
}
