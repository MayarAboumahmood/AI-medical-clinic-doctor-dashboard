part of 'register_cubit.dart';

@immutable
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

final class RegisterLoadingRequest extends RegisterState {
  @override
  List<Object?> get props => [];
}

final class RegisterPhoneNumberNotVerifiedState extends RegisterState {
  @override
  List<Object?> get props => [];
}

final class RegisterSuccessRequest extends RegisterState {
  @override
  List<Object?> get props => [];
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
