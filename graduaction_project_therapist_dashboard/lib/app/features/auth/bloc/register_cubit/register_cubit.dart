import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/core/status_requests/staus_request.dart';
import 'package:graduation_project_therapist_dashboard/app/features/auth/data_source/model/user_info_model.dart';
import 'package:meta/meta.dart';
part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  String otpCode = '';
  UserInfo userInfo = UserInfo(
    firstName: '',
    lastName: '',
    password: '',
    phoneNumber: '',
    userEmail: '',
    locationInfo: '',
    studieInfo: '',
    selectedSpecialization: null,
  );

  void updateUserInfo({
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? userEmail,
    String? password,
  }) {
    userInfo = userInfo.copyWith(
      firstName: firstName ?? userInfo.firstName,
      lastName: lastName ?? userInfo.lastName,
      phoneNumber: phoneNumber ?? userInfo.phoneNumber,
      userEmail: userEmail ?? userInfo.userEmail,
      password: password ?? userInfo.password,
    );
  }

  void sendRegisterRequest() {
    //TODO: send the register requiest and than change the state.
    emit(RegisterSuccessRequest());
  }

  void sendVerifyPinRequest() {
    emit(RegisterOTPSendSuccessRequest());
    //TODO: send the otp and than change the state.
  }
}
