import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:graduation_project_therapist_dashboard/app/core/status_requests/staus_request.dart';
import 'package:meta/meta.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInInitial());

  String phoneNumber = '';
  String password = '';

  void setPhoneNumber(updatedPhoneNumber) {
    phoneNumber = updatedPhoneNumber;
  }

  void setPassword(updatedPassword) {
    password = updatedPassword;
  }

  void sendSignInRequest() {
    //TODO: send the register requiest and than change the state.
  }
}
