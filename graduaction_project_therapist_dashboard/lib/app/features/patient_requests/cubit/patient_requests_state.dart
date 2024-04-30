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

final class PatientRequestApprovedSuccessfullyState
    extends PatientRequestsState {
  @override
  List<Object?> get props => [];
}

final class PatientRequestErrorState extends PatientRequestsState {
  final StatusRequest statusRequest;
  PatientRequestErrorState({required this.statusRequest});
  @override
  List<Object?> get props => [statusRequest];
}

final class PatientRequestDataLoadedState extends PatientRequestsState {
  final List<PatientRequestModel> patientRequestModels;
  PatientRequestDataLoadedState({required this.patientRequestModels});
  @override
  List<Object?> get props => [patientRequestModels];
}
