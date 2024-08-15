part of 'registration_data_complete_cubit.dart';

@immutable
sealed class RegistrationDataCompleteState extends Equatable {}

final class RegistrationDataCompleteInitial
    extends RegistrationDataCompleteState {
  @override
  List<Object?> get props => [];
}

final class RegistrationDataCompleteLoadingState
    extends RegistrationDataCompleteState {
  @override
  List<Object?> get props => [];
}

final class GettingUserLocationState extends RegistrationDataCompleteState {
  @override
  List<Object?> get props => [];
}

final class RegistrationDataCompleteDoneSuccseflyState
    extends RegistrationDataCompleteState {
  @override
  List<Object?> get props => [];
}

final class RegistrationDataCompleteFailureState
    extends RegistrationDataCompleteState {
  final String errorMessage;
  RegistrationDataCompleteFailureState({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}

final class RegistrationDataCompleteImagesUpdated
    extends RegistrationDataCompleteState {
  final List<Uint8List> certificationImages;
  final DateTime dateTime;
  RegistrationDataCompleteImagesUpdated(
      {required this.certificationImages, required this.dateTime});
  @override
  List<Object?> get props => [certificationImages, dateTime];
}
final class GettingAllCategoriesFailureState
    extends RegistrationDataCompleteState {
  final String errorMessage;
  GettingAllCategoriesFailureState({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}

final class GetAllCategoriesSuccseflyState
    extends RegistrationDataCompleteState {
  @override
  List<Object?> get props => [];
}
final class GetCategoriesLoadingState
    extends RegistrationDataCompleteState {
  @override
  List<Object?> get props => [];
}
