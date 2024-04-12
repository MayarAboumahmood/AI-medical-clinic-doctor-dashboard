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

final class RegisterLoadingRequest extends RegisterState {
  @override
  List<Object?> get props => [];
}
final class RegisterPhoneNumberNotVerifiedState extends RegisterState {
  @override
  List<Object?> get props => [];
}
