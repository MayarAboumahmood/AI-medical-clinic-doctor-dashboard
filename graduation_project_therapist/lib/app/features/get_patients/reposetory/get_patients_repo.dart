import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/app/features/get_patients/data_source/data_source/get_patients_datasource.dart';
import 'package:graduation_project_therapist_dashboard/app/features/get_patients/data_source/models/get_patients_model.dart';

class GetPatientsRepositoryImp {
  final GetPatientsDataSource _getPatientsDataSource;

  GetPatientsRepositoryImp(this._getPatientsDataSource);
  Future<Either<String, List<GetPatientsModel>>> getPatients() async {
    try {
      final response = await _getPatientsDataSource.getPatients();
      final decodedResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final List<dynamic> data = decodedResponse['data'];
        final List<GetPatientsModel> getPatientsModel =
            data.map((item) => GetPatientsModel.fromMap(item)).toList();
        return right(getPatientsModel);
      } else if (response.statusCode == 500) {
        if (decodedResponse['error'] == 'jwt expired') {
          return left('jwt expired');
        }
        return left('Server error');
      } else {
        return left(decodedResponse['error']);
      }
    } catch (e) {
      debugPrint('error in get all therapist repo: $e');
      return left('Server Error');
    }
  }
}
