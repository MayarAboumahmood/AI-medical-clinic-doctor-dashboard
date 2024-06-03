import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:graduation_project_therapist_dashboard/app/core/status_requests/staus_request.dart';
import 'package:graduation_project_therapist_dashboard/app/features/profile/data/model/edit_profile_model.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}

final class ProfileEditedState extends ProfileState {
  final EditProfileModel editProfileModel;
  const ProfileEditedState(this.editProfileModel);
  @override
  List<Object> get props => [editProfileModel];
}

final class LoadingRequest extends ProfileState {
  @override
  List<Object> get props => [];
}

final class SuccessEditRequest extends ProfileState {
  final String name;
  const SuccessEditRequest({required this.name});
  @override
  List<Object> get props => [name];
}

final class ValidationErrorRequest extends ProfileState {
  final StatusRequest statusRequest;

  const ValidationErrorRequest(this.statusRequest);
  @override
  List<Object> get props => [statusRequest];
}

final class ServerErrorRequest extends ProfileState {
  final String errorMessage;
  const ServerErrorRequest({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

final class CanNotChangePassworState extends ProfileState {
  final String message;

  const CanNotChangePassworState({required this.message});
  @override
  List<Object> get props => [message];
}

final class ChangePasswordInitState extends ProfileState {
  const ChangePasswordInitState();
  @override
  List<Object> get props => [];
}

class FormValidationFailure extends ProfileState {
  final String? fullNameError;
  final String? emailError;
  final String? phoneNumberError;
  final String? genderError;
  final String? stateError;
  final String? dataOfbirthError;

  const FormValidationFailure({
    this.emailError,
    this.phoneNumberError,
    this.fullNameError,
    this.dataOfbirthError,
    this.genderError,
    this.stateError,
  });
}

final class PasswordEditedState extends ProfileState {
  @override
  List<Object> get props => [];

  const PasswordEditedState();
}

final class AccountDeletedState extends ProfileState {
  const AccountDeletedState();
  @override
  List<Object> get props => [];
}

final class FetchProfileDataFailur extends ProfileState {
  final StatusRequest statusRequest;
  const FetchProfileDataFailur(this.statusRequest);
  @override
  List<Object> get props => [statusRequest];
}

// class ProfilePictureSelected extends ProfileState {
//   final File picture;

//   const ProfilePictureSelected({required this.picture});
//   @override
//   List<Object> get props => [picture];
// }

final class SelectedProfileState extends ProfileState {
  final String selectedState;

  const SelectedProfileState(this.selectedState);
  @override
  List<Object> get props => [selectedState];
}

final class SelectEditProfilePicture extends ProfileState {
  final File picture;

  const SelectEditProfilePicture(this.picture);
  @override
  List<Object> get props => [picture];
}
