import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/app/core/status_requests/staus_request.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInInitial());
  TextEditingController passwordtextgController = TextEditingController();

  String phoneNumber = '';
  String password = '';

  void setPhoneNumber(updatedPhoneNumber) {
    phoneNumber = updatedPhoneNumber;
  }


  void sendSignInRequest() {
    //TODO: send the register requiest and than change the state.
  }
}
