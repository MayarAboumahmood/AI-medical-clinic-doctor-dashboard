import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:graduation_project_therapist_dashboard/app/core/status_requests/staus_request.dart';
import 'package:graduation_project_therapist_dashboard/app/features/patient_reservations/data_source/models/patient_reservation_model.dart';
import 'package:meta/meta.dart';

part 'patient_reservations_state.dart';

class PatientReservationsCubit extends Cubit<PatientReservationsState> {
  PatientReservationsCubit() : super(PatientReservationsInitial());
  List<PatientReservationModel> cachedPatientReservations = fakeReservations;
  void getPatientReservations() {
    emit(PatientReservationsLoadingState());
    Future.delayed(const Duration(seconds: 1), () {
      emit(PatientReservationDataLoadedState(
          patientReservationModels: cachedPatientReservations));
    });
  }

  bool checkIfSessionIsNear(int reservationID) {
    return Random().nextBool();
  }

  void cancelOnPatientReservation(int reservationID) {}
}