import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:graduation_project_therapist_dashboard/app/features/patient_reservations/data_source/models/patient_reservation_model.dart';
import 'package:graduation_project_therapist_dashboard/app/features/patient_reservations/repo/patient_reservations_repo.dart';
import 'package:meta/meta.dart';

part 'patient_reservations_state.dart';

class PatientReservationsCubit extends Cubit<PatientReservationsState> {
  PatientReservationsCubit({required this.patientReservationsRepositoryImp})
      : super(PatientReservationsInitial());
  List<PatientReservationModel> cachedPatientReservations = fakeReservations;
  PatientReservationsRepositoryImp patientReservationsRepositoryImp;

  void getPatientReservations() async {
    emit(PatientReservationsLoadingState());
    final getData =
        await patientReservationsRepositoryImp.getPatientReservations();
    getData.fold(
        (errorMessage) =>
            emit(PatientReservationErrorState(errorMessage: errorMessage)),
        (data) {
      cachedPatientReservations = data;
      emit(PatientReservationDataLoadedState(
          patientReservationModels: cachedPatientReservations));
    });
  }

  bool checkIfSessionIsNear(int reservationID) {
    return Random().nextBool();
  }

  void cancelOnPatientReservation(int reservationID) {}
}
