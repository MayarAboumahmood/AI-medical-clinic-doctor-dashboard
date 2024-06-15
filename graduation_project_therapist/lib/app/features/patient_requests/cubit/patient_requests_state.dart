part of 'patient_requests_cubit.dart';

@immutable
sealed class PatientRequestsState extends Equatable {}

final class PatientRequestsInitial extends PatientRequestsState {
  @override
  List<Object?> get props => [];
}

final class PatientRequestLoadingState extends PatientRequestsState {
  @override
  List<Object?> get props => [];
}
final class PatientRequestRejectLoadingState extends PatientRequestsState {
  @override
  List<Object?> get props => [];
}
final class PatientRequestAcceptLoadingState extends PatientRequestsState {
  @override
  List<Object?> get props => [];
}

final class PatientRequestApprovedSuccessfullyState
    extends PatientRequestsState {
  @override
  List<Object?> get props => [];
}

final class PatientRequestRejectedSuccessfullyState
    extends PatientRequestsState {
  final DateTime dateTime;
  PatientRequestRejectedSuccessfullyState({required this.dateTime});
  @override
  List<Object?> get props => [];
}

final class PatientRequestErrorState extends PatientRequestsState {
  final String errorMessage;
  PatientRequestErrorState({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}

final class PatientRequestDataLoadedState extends PatientRequestsState {
  final List<PatientRequestModel> patientRequestModels;
  PatientRequestDataLoadedState({required this.patientRequestModels});
  @override
  List<Object?> get props => [patientRequestModels];
}
