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

  bool checkIfSessionIsNear(DateTime dateOfSession) {
    DateTime now = DateTime
        .now(); // Get the current time in UTC to match the format of the input
    print('now time: $now');

    DateTime fiveMinutesBefore = dateOfSession.subtract(Duration(minutes: 5));
    DateTime thirtyMinutesAfter = dateOfSession.add(Duration(minutes: 30));

    // Check if the current time is within 5 minutes before or 30 minutes after the session time
    return now.isAfter(fiveMinutesBefore) && now.isBefore(thirtyMinutesAfter);
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
      if (cachedPatientReservations != null) {
        cachedPatientReservations!
            .removeWhere((request) => request.id == reservationID);
      }
      emit(PatientReservationCanceledSuccessfullyState());
    });
  }
}
