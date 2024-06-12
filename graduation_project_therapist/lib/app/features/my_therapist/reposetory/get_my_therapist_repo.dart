import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import 'package:graduation_project_therapist_dashboard/app/features/get_all_therapists/data_source/models/get_therapists_model.dart';
import 'package:graduation_project_therapist_dashboard/app/features/my_therapist/data_source/data_source/get_my_therapist_datasource.dart';

class GetMyTherapistRepositoryImp {
  final GetMyTherapistDataSource _getMyTherapistDataSource;

  GetMyTherapistRepositoryImp(this._getMyTherapistDataSource);
  Future<Either<String, List<GetTherapistModel>>> getMyTherapist() async {
    try {
      final response = await _getMyTherapistDataSource.getMyTherapist();
      final decodedResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final List<dynamic> data = decodedResponse['data'];
        final List<GetTherapistModel> getTherapistModel =
            data.map((item) => GetTherapistModel.fromMap(item)).toList();
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
      debugPrint('error in get all therapist repo: $e');
      return left('Server Error');
    }
  }

  Future<Either<String, String>> removeTherapist(int therapistId) async {
    try {
      final response =
          await _getMyTherapistDataSource.removeTherapist(therapistId);
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
      debugPrint('error in get all therapist repo: $e');
      return left('Server Error');
    }
  }
}
