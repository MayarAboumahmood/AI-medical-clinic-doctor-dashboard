import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/app/features/doctor_employment_requests/data_source/data_source/d_e_r_datasource.dart';
import 'package:graduation_project_therapist_dashboard/app/features/doctor_employment_requests/data_source/models/doctor_employment_request_model.dart';

class DoctoreEmploymentRequestRepositoryImp {
  final DoctorEmploymentDataSource _doctorEmploymentDataSource;

  DoctoreEmploymentRequestRepositoryImp(this._doctorEmploymentDataSource);
  Future<Either<String, List<DoctorEmploymentRequestModel>>>
      getAllDoctorEmploymentRequests() async {
    try {
      final response =
          await _doctorEmploymentDataSource.getAllDoctorEmploymentRequests();
      final decodedResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final List<dynamic> data = decodedResponse['data'];

        final List<DoctorEmploymentRequestModel> doctorEmploymentRequestModels =
            data
                .map((item) => DoctorEmploymentRequestModel.fromMap(item))
                .toList();
        return right(doctorEmploymentRequestModels);
      } else if (response.statusCode == 500) {
        if (decodedResponse['error'] == 'jwt expired') {
          return left('jwt expired');
        }
        return left('Server error');
      } else {
        return left(decodedResponse['error']);
      }
    } catch (e) {
      debugPrint('error in get all doctor employment request repo: $e');
      return left('Server Error');
    }
  }

  Future<Either<String, String>> approveDoctorEmploymentRequest(
      int requestId, bool status) async {
    try {
      final response = await _doctorEmploymentDataSource
          .approveDoctorEmploymentRequest(requestId, status);
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
      debugPrint('error in get all doctor employment request repo: $e');
      return left('Server Error');
    }
  }
}
