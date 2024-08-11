import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:graduation_project_therapist_dashboard/app/features/block/data_source/data_sources/block_datasource.dart';
import 'package:graduation_project_therapist_dashboard/app/features/block/data_source/models/all_blocked_patient_model.dart';

class BlockRepositoryImp {
  final BlockDataSource _blockDataSource;

  BlockRepositoryImp(this._blockDataSource);

  Future<Either<String, String>> blockPatient(int patientId) async {
    print('block user body repo: ${patientId}');

    try {
      final response = await _blockDataSource.blockPatient(patientId);
      final decodedResponse = jsonDecode(response.body);
      if (response.statusCode == 201 || response.statusCode == 200) {
        return right('Done');
      } else if (response.statusCode == 500) {
        if (decodedResponse['error'] == 'jwt expired') {
          return left('jwt expired');
        }
        return left('Server error');
      } else {
        return left(decodedResponse['error']);
      }
    } catch (e) {
      print('error wile block user: $e');
      return left('Server error');
    }
  }

  Future<Either<String, String>> unBlockPatient(int patientId) async {
    try {
      final response = await _blockDataSource.unBlockPatient(patientId);
      final decodedResponse = jsonDecode(response.body);
      if (response.statusCode == 201 || response.statusCode == 200) {
        return right('Done');
      } else if (response.statusCode == 500) {
        if (decodedResponse['error'] == 'jwt expired') {
          return left('jwt expired');
        }
        return left('Server error');
      } else {
        return left(decodedResponse['error']);
      }
    } catch (e) {
      print('error wile unblock user: $e');
      return left('Server error');
    }
  }

  Future<Either<String, AllBlockedPatientModel>>
      getAllBlocedPatientEvent() async {
    final response = await _blockDataSource.getAllBlocedPatientEvent();

    final decodedResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      AllBlockedPatientModel allBlockedPatientModel =
          AllBlockedPatientModel.fromJson(decodedResponse);
      return right(allBlockedPatientModel);
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
