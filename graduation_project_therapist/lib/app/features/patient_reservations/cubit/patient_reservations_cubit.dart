import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:graduation_project_therapist_dashboard/app/features/patient_reservations/data_source/models/patient_reservation_model.dart';
import 'package:graduation_project_therapist_dashboard/app/features/patient_reservations/repo/patient_reservations_repo.dart';
import 'package:meta/meta.dart';

part 'patient_reservations_state.dart';

class PatientReservationsCubit extends Cubit<PatientReservationsState> {
  PatientReservationsCubit({required this.patientReservationsRepositoryImp})
      : super(PatientReservationsInitial());
  List<PatientReservationModel>? cachedPatientReservations;
  PatientReservationsRepositoryImp patientReservationsRepositoryImp;
  int cahcedReservationID = -1;

  void getPatientReservations({bool fromRefreshIndicator = false}) async {
    if (cachedPatientReservations == null || fromRefreshIndicator) {
      emit(PatientReservationsLoadingState());
      final getData =
          await patientReservationsRepositoryImp.getPatientReservations();
      getData.fold(
          (errorMessage) =>
              emit(PatientReservationErrorState(errorMessage: errorMessage)),
          (data) {
        cachedPatientReservations = data;
        emit(PatientReservationDataLoadedState(patientReservationModels: data));
      });
    } else {
      emit(PatientReservationDataLoadedState(
          patientReservationModels: cachedPatientReservations!));
    }
  }

  bool checkIfSessionIsNear(int reservationID) {
    return true;

    // Random().nextBool();
  }

  void cancelOnPatientReservation(int reservationID, String description) async {
    cahcedReservationID = reservationID;
    emit(CancelOnPatientReservationLoadingState());
    final getData = await patientReservationsRepositoryImp
        .cancelPatientReservations(reservationID, description);
    getData.fold(
        (errorMessage) => emit(
            CancelPatientReservationErrorState(errorMessage: errorMessage)),
        (data) {
      emit(PatientReservationCanceledSuccessfullyState());
    });
  }
}
