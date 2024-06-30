import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/app/features/get_all_therapists/data_source/data_source/get_all_therapist_datasource.dart';
import 'package:graduation_project_therapist_dashboard/app/features/get_all_therapists/data_source/models/get_therapists_model.dart';

class GetAllTherapistRepositoryImp {
  final GetAllTherapistDataSource _getAllTherapistDataSource;

  GetAllTherapistRepositoryImp(this._getAllTherapistDataSource);
  Future<Either<String, List<GetTherapistModel>>> getAllTherapist() async {
    try {
      final response = await _getAllTherapistDataSource.getAllTherapist();
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

  Future<Either<String, String>> assignTherapist(int therapistId) async {
    try {
      final response =
          await _getAllTherapistDataSource.assignTherapist(therapistId);
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

  Future<Either<String, List<GetTherapistModel>>> getMyTherapist(int patientID) async {
    try {
      final response = await _getAllTherapistDataSource.getMyTherapist(patientID);
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
          await _getAllTherapistDataSource.removeTherapist(therapistId);
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
