import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/core/status_requests/staus_request.dart';
part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  String firstName = '';
  String lastName = '';
  String phoneNumber = '';
  void setFirstName(String updatedFirstName) {
    firstName = updatedFirstName;
  }

  void setLastName(updatedLastName) {
    lastName = updatedLastName;
  }

  void setPhoneNumber(updatedPhoneNumber) {
    phoneNumber = updatedPhoneNumber;
  }
  void sendRegisterRequest(){
   //TODO: send the register requiest and than change the state.
  }
}
