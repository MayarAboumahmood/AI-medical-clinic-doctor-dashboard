import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/app/features/medical_description.dart/data_source/data_source/m_d_data_source.dart';
import 'package:graduation_project_therapist_dashboard/app/features/medical_description.dart/data_source/models/medical_description_model.dart';

class MedicalDescriptionRepositoryImp {
  final MedicalDescriptionSource _medicalDescriptionSource;

  MedicalDescriptionRepositoryImp(this._medicalDescriptionSource);

  Future<Either<String, String>> createMedicalDescription(
      MedicalDescriptionModel medicalDescriptionModel) async {
    try {
      final response = await _medicalDescriptionSource
          .createMedicalDescription(medicalDescriptionModel);
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
      debugPrint('error in get all therapist repo: $e');
      return left('Server Error');
    }
  }
  Future<Either<String, String>> getAllMedicalRecords(
      int patientId) async {
    try {
      final response = await _medicalDescriptionSource
          .getAllMedicalRecords(patientId);
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
      debugPrint('error in get all therapist repo: $e');
      return left('Server Error');
    }
  }
}
