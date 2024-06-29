part of 'patient_reservations_cubit.dart';

@immutable
sealed class PatientReservationsState extends Equatable {}

final class PatientReservationsInitial extends PatientReservationsState {
  @override
  List<Object?> get props => [];
}

final class PatientReservationsLoadingState extends PatientReservationsState {
  @override
  List<Object?> get props => [];
}
final class CancelOnPatientReservationLoadingState extends PatientReservationsState {
  @override
  List<Object?> get props => [];
}

final class PatientReservationApprovedSuccessfullyState
    extends PatientReservationsState {
  final List<PatientReservationModel> cachedPatientReservations;
  PatientReservationApprovedSuccessfullyState(
      {required this.cachedPatientReservations});
  @override
  List<Object?> get props => [cachedPatientReservations];
}

final class PatientReservationCanceledSuccessfullyState
    extends PatientReservationsState {
  @override
  List<Object?> get props => [];
}

final class PatientReservationErrorState extends PatientReservationsState {
  final String errorMessage;
  PatientReservationErrorState({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}
final class CancelPatientReservationErrorState extends PatientReservationsState {
  final String errorMessage;
  CancelPatientReservationErrorState({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}

final class PatientReservationDataLoadedState extends PatientReservationsState {
  final List<PatientReservationModel> patientReservationModels;
  PatientReservationDataLoadedState({required this.patientReservationModels});
  @override
  List<Object?> get props => [patientReservationModels];
}
