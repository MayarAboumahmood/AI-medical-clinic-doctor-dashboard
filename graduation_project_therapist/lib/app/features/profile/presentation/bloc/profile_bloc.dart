import 'dart:io';
import 'package:graduation_project_therapist_dashboard/app/features/home_page/data_source/models/user_profile_model.dart';
import 'package:graduation_project_therapist_dashboard/app/features/profile/data/edite_profile_repo.dart';
import 'package:graduation_project_therapist_dashboard/app/features/profile/presentation/bloc/profile_event.dart';
import 'package:graduation_project_therapist_dashboard/app/features/profile/presentation/bloc/profile_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final EditProfileRepository editProfileRepositoryImpl;
  late File image = File('');
  final imagePicker = ImagePicker();
  late Uint8List imageInBytes;
  UserProfileModel? userData;
  String? imageName;

  ProfileBloc({
    required this.editProfileRepositoryImpl,
  }) : super(ProfileInitial()) {
    on<EditProfileEvent>((event, emit) async {
      print('save button is clicked in the bloc');
      emit(LoadingRequest());
      final getData =
          await editProfileRepositoryImpl.editProfile(event.editedData);
      getData.fold((onError) => emit(ServerErrorRequest(errorMessage: onError)),
          (data) => emit(SuccessEditRequest(name: event.editedData.fullName)));
    });

    on<ResetPasswordEvent>((event, emit) async {
      emit(LoadingRequest());
      final getData = await editProfileRepositoryImpl.resetPassword(
          event.oldPassword, event.newPassword);
      getData.fold((onError) => emit(ServerErrorRequest(errorMessage: onError)),
          (data) => emit(const PasswordEditedState()));
    });
    on<CanNotChangePassworEvent>((event, emit) async {
      emit(CanNotChangePassworState(message: event.message));
    });
    on<ChangePasswordInitEvent>((event, emit) {
      emit(const ChangePasswordInitState());
    });

    on<DeleteAccountEvent>((event, emit) async {
      emit(LoadingRequest());
      final deleteAccountResponse =
          await editProfileRepositoryImpl.deleteAccount();
      deleteAccountResponse.fold(
          (error) => emit(ServerErrorRequest(errorMessage: error)),
          (r) => emit(const AccountDeletedState()));
    });
    on<SetPictureProfileEditeProfile>((event, emit) async {
      final pickedImage =
          await imagePicker.pickImage(source: event.imageSource);
      if (pickedImage != null) {
        image = File(pickedImage.path);
        imageInBytes = await pickedImage.readAsBytes();
        imageName = pickedImage.name;
        emit(SelectEditProfilePicture(image));
      }
    });

    on<SelectPictureProfileEditeProfile>((event, emit) async {
      if (event.selectedPicture is FileImage) {
        // If the image is a file, read the file as bytes.
        imageInBytes = await image.readAsBytes();
      } else if (event.selectedPicture is String) {
        try {
          final directory = await getApplicationDocumentsDirectory();
          final File file = File("${directory.path}/${event.selectedPicture}");
          imageInBytes = await file.readAsBytes();
        } catch (e) {
          if (kDebugMode) {
            print('error in selecting pic in Auth bloc bloc: $e');
          }
        }
      } else {
        emit(const SelectedProfileState("Unexpected error Please try again"));
        return;
      }
    });
  }
}
