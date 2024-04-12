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

final class SignInLoadingState extends SignInState {
  @override
  List<Object?> get props => [];
}
