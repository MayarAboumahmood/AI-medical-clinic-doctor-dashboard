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

final class RegistrationDataCompleteDoneSuccseflyState
    extends RegistrationDataCompleteState {
  @override
  List<Object?> get props => [];
}

final class RegistrationDataCompleteImagesUpdated
    extends RegistrationDataCompleteState {
  final List<String> certificationImages;
  final DateTime dateTime ;
  RegistrationDataCompleteImagesUpdated({required this.certificationImages,required this.dateTime});
  @override
  List<Object?> get props => [certificationImages, dateTime];
}
