import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/app/features/patient_reservations/data_source/data_source/patient_reservations_datasource.dart';
import 'package:graduation_project_therapist_dashboard/app/features/patient_reservations/data_source/models/patient_reservation_model.dart';

class PatientReservationsRepositoryImp {
  final PatientReservationsDataSource _patientReservationsDataSource;

  PatientReservationsRepositoryImp(this._patientReservationsDataSource);
  Future<Either<String, List<PatientReservationModel>>>
      getPatientReservations() async {
    try {
      final response =
          await _patientReservationsDataSource.getPatientReservations();
      final decodedResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final List<dynamic> data = decodedResponse['data'];
        final List<PatientReservationModel> getPatientReservationModel =
            data.map((item) => PatientReservationModel.fromMap(item)).toList();
        return right(getPatientReservationModel);
      } else if (response.statusCode == 500) {
        if (decodedResponse['error'] == 'jwt expired') {
          return left('jwt expired');
        }
        return left('Server error');
      } else {
        return left(decodedResponse['error']);
      }
    } catch (e) {
      debugPrint('error in get Patient reservations repo: $e');
      return left('Server Error');
    }
  }

  Future<Either<String, String>> cancelPatientReservations(
      int reservationID, String description) async {
    try {
      final response = await _patientReservationsDataSource
          .cancelPatientReservations(reservationID, description);
      final decodedResponse = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return right('done');
      } else if (response.statusCode == 500) {
        if (decodedResponse['error'] == 'jwt expired') {
          return left('jwt expired');
        }
        return left('Server error');
      } else {
        return left(decodedResponse['error'] ?? decodedResponse['message']);
      }
    } catch (e) {
      debugPrint('error in cancel Patient reservations repo: $e');
      return left('Server Error');
    }
  }
}
