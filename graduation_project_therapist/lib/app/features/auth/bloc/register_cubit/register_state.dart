import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:graduation_project_therapist_dashboard/app/core/status_requests/staus_request.dart';

sealed class RegisterState extends Equatable {}

final class RegisterInitial extends RegisterState {
  @override
  List<Object?> get props => [];
}

final class RegisterValidationErrorRequest extends RegisterState {
  final StatusRequest statusRequest;
  RegisterValidationErrorRequest({required this.statusRequest});
  @override
  List<Object?> get props => [statusRequest];
}

final class RegisterProfilePictureUpdated extends RegisterState {
  final Uint8List imageBytes;
  RegisterProfilePictureUpdated({required this.imageBytes});

  @override
  List<Object?> get props => [imageBytes];
}

final class RegisterLoadingState extends RegisterState {
  @override
  List<Object?> get props => [];
}

final class RegisterPhoneNumberNotVerifiedState extends RegisterState {
  @override
  List<Object?> get props => [];
}

final class RegisterSuccessRequestWithoutOTP extends RegisterState {
  @override
  List<Object?> get props => [];
}

final class RegisterFailureState extends RegisterState {
  final StatusRequest statusRequest;
  final String errorMessage;
  RegisterFailureState(
      {required this.statusRequest, required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage, statusRequest];
}

final class RegisterOTPSendSuccessRequest extends RegisterState {
  @override
  List<Object?> get props => [];
}

final class RegisterServerErrorRequest extends RegisterState {
  final StatusRequest statusRequest;
  RegisterServerErrorRequest({required this.statusRequest});
  @override
  List<Object?> get props => [statusRequest];
}
