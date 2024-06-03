import 'package:equatable/equatable.dart';
import 'package:graduation_project_therapist_dashboard/app/features/profile/data/model/edit_profile_model.dart';
import 'package:image_picker/image_picker.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
}

class EditProfileEvent extends ProfileEvent {
  final EditProfileModel editedData;

  const EditProfileEvent({required this.editedData});

  @override
  List<Object?> get props => [editedData];
}

class ResetPasswordEvent extends ProfileEvent {
  final String oldPassword;
  final String newPassword;

  const ResetPasswordEvent({
    required this.oldPassword,
    required this.newPassword,
  });
  @override
  List<Object?> get props => [oldPassword, newPassword];
}

class CanNotChangePassworEvent extends ProfileEvent {
  final String message;

  const CanNotChangePassworEvent({
    required this.message,
  });
  @override
  List<Object?> get props => [message];
}

class ChangePasswordInitEvent extends ProfileEvent {
  const ChangePasswordInitEvent();

  @override
  List<Object?> get props => [];
}

class LoadingProfileEvent extends ProfileEvent {
  @override
  List<Object?> get props => [];
}

class DeleteAccountEvent extends ProfileEvent {
  const DeleteAccountEvent();
  @override
  List<Object?> get props => [];
}

// Define an event for selecting a profile picture

class SetPictureProfileEditeProfile extends ProfileEvent {
  final ImageSource imageSource;
  const SetPictureProfileEditeProfile({required this.imageSource});

  @override
  List<Object?> get props => [imageSource];
}

class SelectPictureProfileEditeProfile extends ProfileEvent {
  final dynamic selectedPicture;
  const SelectPictureProfileEditeProfile({required this.selectedPicture});

  @override
  List<Object?> get props => [selectedPicture];
}
// class SetUserDataEvet extends ProfileEvent {
//   final UserData userData;
//   const SetUserDataEvet({required this.userData});

//   @override
//   List<Object?> get props => [userData];
// }
