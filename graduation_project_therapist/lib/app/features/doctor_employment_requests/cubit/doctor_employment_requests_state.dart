part of 'doctor_employment_requests_cubit.dart';

@immutable
sealed class DoctorEmploymentRequestsState extends Equatable {}

final class DoctorEmploymentRequestsInitial
    extends DoctorEmploymentRequestsState {
  @override
  List<Object?> get props => [];
}

final class DoctorEmploymentRequestsErrorState
    extends DoctorEmploymentRequestsState {
  final String errorMessage;
  DoctorEmploymentRequestsErrorState({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}

final class DoctorEmploymentApproveRequestsState
    extends DoctorEmploymentRequestsState {
  @override
  List<Object?> get props => [];
}
final class DoctorEmploymentDeclinedRequestsState
    extends DoctorEmploymentRequestsState {
  @override
  List<Object?> get props => [];
}
final class AllRequestLoadedSuccessfullyState
    extends DoctorEmploymentRequestsState {
  @override
  List<Object?> get props => [];
}
final class DoctorEmploymentRequestsLoadingState
    extends DoctorEmploymentRequestsState {
  @override
  List<Object?> get props => [];
}
final class ApproveDoctorRequestsLoadingState
    extends DoctorEmploymentRequestsState {
  @override
  List<Object?> get props => [];
}
