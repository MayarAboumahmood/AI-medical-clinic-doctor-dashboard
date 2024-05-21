import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/app/core/status_requests/staus_request.dart';
import 'package:graduation_project_therapist_dashboard/app/features/auth/data_source/data_source/remot_data_source.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final AuthRemoteDataSource authRemoteDataSource;
  SignInCubit({required this.authRemoteDataSource}) : super(SignInInitial());

  TextEditingController passwordtextgController = TextEditingController();
  String userEmail = '';

  void setUserEmail(updatedUserEmail) {
    userEmail = updatedUserEmail;
  }

  void sendSignInRequest() async {
    emit(SignInLoadingState());

    try {
      final response = await authRemoteDataSource.login(
          userEmail, passwordtextgController.text);
      final responseBody = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(SuccessRequest());
      } else {
        final error = responseBody['error'] ?? 'Server Error'.tr();
        emit(SignInFailureState(errorMessage: error));
      }
    } catch (error) {
      debugPrint('error in sign in: $error');
      emit(SignInFailureState(errorMessage: 'Server Error'));
    }
  }
}
