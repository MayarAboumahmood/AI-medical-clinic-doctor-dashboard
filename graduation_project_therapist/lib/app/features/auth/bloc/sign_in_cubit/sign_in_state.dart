part of 'sign_in_cubit.dart';

@immutable
sealed class SignInState extends Equatable {}

final class SignInInitial extends SignInState {
  @override
  List<Object?> get props => [];
}

final class SuccessRequest extends SignInState {
  @override
  List<Object?> get props => [];
}

final class SignInErrorRequeistState extends SignInState {
  final StatusRequest statusRequest;

  SignInErrorRequeistState({required this.statusRequest});
  @override
  List<Object?> get props => [statusRequest];
}

final class SignInFailureState extends SignInState {
  final String errorMessage;

  SignInFailureState({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}

final class SignInaccountNotverifiedState extends SignInState {
  @override
  List<Object?> get props => [];
}

final class SignInLoadingState extends SignInState {
  @override
  List<Object?> get props => [];
}

final class SignInSendingOtpCodeLoadingState extends SignInState {
  @override
  List<Object?> get props => [];
}

final class ForgetPasswordSendingEmailSuccessState extends SignInState {
  @override
  List<Object?> get props => [];
}
