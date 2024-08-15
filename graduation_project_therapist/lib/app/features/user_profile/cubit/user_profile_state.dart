part of 'user_profile_cubit.dart';

@immutable
sealed class UserProfileState extends Equatable {}

final class UserProfileInitial extends UserProfileState {
  @override
  List<Object?> get props => [];
}

final class UserProfileGetData extends UserProfileState {
  final PatientProfileModel patientProfileModel;
  UserProfileGetData({required this.patientProfileModel});
  @override
  List<Object?> get props => [patientProfileModel];
}

final class UserProfileLoadingState extends UserProfileState {
  @override
  List<Object?> get props => [];
}

final class AssignPatientToTherapistLoadingState extends UserProfileState {
  @override
  List<Object?> get props => [];
}

final class GetPatientBotScoreLoadingState extends UserProfileState {
  @override
  List<Object?> get props => [];
}

final class GetPatientBotScoreErrorState extends UserProfileState {
  final String errorMessage;
  GetPatientBotScoreErrorState({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}

final class GetingPatientBotScoreDoneState extends UserProfileState {
  final String botScore;
  GetingPatientBotScoreDoneState({required this.botScore});
  @override
  List<Object?> get props => [];
}

final class PatientAssignedToTherapistState extends UserProfileState {
  final bool isRequest;
  PatientAssignedToTherapistState({required this.isRequest});
  @override
  List<Object?> get props => [isRequest];
}

final class AssignPatientToTherapistErrorState extends UserProfileState {
  final String errorMessage;
  AssignPatientToTherapistErrorState({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}

final class UserProfileErrorState extends UserProfileState {
  final String errorMessage;
  UserProfileErrorState({required this.errorMessage});
  @override
  List<Object?> get props => [];
}
