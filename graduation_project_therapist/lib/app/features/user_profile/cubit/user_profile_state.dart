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

final class UserProfileErrorState extends UserProfileState {
  final String errorMessage;
  UserProfileErrorState({required this.errorMessage});
  @override
  List<Object?> get props => [];
}
