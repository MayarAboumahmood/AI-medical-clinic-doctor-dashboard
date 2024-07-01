import 'dart:convert';
import 'dart:typed_data';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/core/status_requests/staus_request.dart';
import 'package:graduation_project_therapist_dashboard/app/features/auth/bloc/register_cubit/register_state.dart';
import 'package:graduation_project_therapist_dashboard/app/features/auth/data_source/data_source/remot_data_source.dart';
import 'package:graduation_project_therapist_dashboard/app/features/auth/data_source/model/register_model.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit({required this.authRemoteDataSource})
      : super(RegisterInitial());

  final AuthRemoteDataSource authRemoteDataSource;
  TextEditingController passwordtextgController = TextEditingController();
  TextEditingController retypePasswordtextController = TextEditingController();
  TextEditingController otpCodeController = TextEditingController();

  DateTime selectedDay = DateTime(2001, 1, 1);
  String? imageName;
  Uint8List? selectedImage;

  void clearRegisterCubit() {
    //TODO: use this function.
    selectedDay = DateTime(2001, 1, 1);
    imageName = null;
    selectedImage = null;
    userInfo = UserInfo(
        dateOfBirth: '',
        firstName: '',
        lastName: '',
        password: '',
        phoneNumber: '',
        userEmail: '',
        gender: 1,
        photo: '',
        roleId: 1);
    Future.delayed(const Duration(seconds: 1), () {
      passwordtextgController.dispose();
      retypePasswordtextController.dispose();
      otpCodeController.dispose();
    });
  }

  UserInfo userInfo = UserInfo(
      dateOfBirth: '',
      firstName: '',
      lastName: '',
      password: '',
      phoneNumber: '',
      userEmail: '',
      gender: 1,
      photo: '',
      roleId: 1);

  void setGender(String gender) {
    if (gender == 'male'.tr() || gender == 'Male'.tr()) {
      userInfo.gender = 1;
    } else {
      userInfo.gender = 2;
    }
  }

  void setRoleID(String role) {
    if (role == 'Doctor'.tr() || role == 'doctor'.tr()) {
      userInfo.roleId = 1;
    } else {
      userInfo.roleId = 2;
    }
  }

  String getSelectedGender() {
    if (userInfo.gender == 1) {
      return 'male'.tr();
    } else {
      return 'female'.tr();
    }
  }

  String getRoleByID() {
    if (userInfo.roleId == 1) {
      return 'Doctor'.tr();
    } else {
      return 'Therapist'.tr();
    }
  }

  void updateUserInfo({
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? userEmail,
    String? password,
    String? dateOfBirth,
  }) {
    String selectedDayString = DateFormat('yyyy-MM-dd').format(selectedDay);

    userInfo = userInfo.copyWith(
      firstName: firstName ?? userInfo.firstName,
      lastName: lastName ?? userInfo.lastName,
      phoneNumber: phoneNumber ?? userInfo.phoneNumber,
      userEmail: userEmail ?? userInfo.userEmail,
      password: password ?? userInfo.password,
      dateOfBirth: dateOfBirth ?? userInfo.dateOfBirth ?? selectedDayString,
    );
  }

  void setImage(Uint8List imageBytes, String newImageName) {
    imageName = newImageName;
    selectedImage = imageBytes;
    emit(RegisterProfilePictureUpdated(imageBytes: imageBytes));
  }

  Future<void> sendRegisterRequest() async {
    emit(RegisterLoadingState());
    userInfo = userInfo.copyWith(password: passwordtextgController.text);
    try {
      final response = await authRemoteDataSource.register(
          userInfo, selectedImage, imageName);
      final responseBody = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(RegisterSuccessRequestWithoutOTP());
      } else {
        final error = responseBody['error'] ?? 'Server Error'.tr();
        emit(RegisterFailureState(
            statusRequest: StatusRequest.serverError, errorMessage: error));
      }
    } catch (error) {
      emit(RegisterFailureState(
          statusRequest: StatusRequest.serverError,
          errorMessage: 'Server Error'));
    }
  }

  void sendVerifyPinRequest() async {
    emit(RegisterLoadingState());
    try {
      final response = await authRemoteDataSource.sendOTPCode(
          userInfo.userEmail, otpCodeController.text);
      final responseBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        emit(RegisterOTPSendSuccessRequest());
      } else {
        final error = responseBody['error'] ?? 'Server Error'.tr();
        emit(RegisterFailureState(
            statusRequest: StatusRequest.serverError, errorMessage: error));
      }
    } catch (error) {
      emit(RegisterFailureState(
          statusRequest: StatusRequest.serverError,
          errorMessage: 'Server Error'));
    }
  }
}
