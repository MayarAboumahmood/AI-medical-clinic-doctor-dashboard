part of 'medical_description_cubit.dart';

@immutable
sealed class MedicalDescriptionState extends Equatable {}

final class MedicalDescriptionInitial extends MedicalDescriptionState {
  @override
  List<Object?> get props => [];
}

final class CreateMedicalDescriptionLoadingState
    extends MedicalDescriptionState {
  @override
  List<Object?> get props => [];
}

final class CreateMedicalDescriptionErrorState extends MedicalDescriptionState {
  final String errorMessage;
  CreateMedicalDescriptionErrorState({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}
final class CreateMedicalDescriptionSuccessState extends MedicalDescriptionState {
  
  CreateMedicalDescriptionSuccessState();
  @override
  List<Object?> get props => [];
}
