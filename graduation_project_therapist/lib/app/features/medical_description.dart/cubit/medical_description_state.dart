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
final class EditMedicalDescriptionLoadingState
    extends MedicalDescriptionState {
  @override
  List<Object?> get props => [];
}

final class GetAllMedicalDescriptionsLoadingState
    extends MedicalDescriptionState {
  @override
  List<Object?> get props => [];
}

final class GetAllMedicalDescriptionsErrorState
    extends MedicalDescriptionState {
  final String errorMessage;
  GetAllMedicalDescriptionsErrorState({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}

final class GetAllMedicalDescriptionsSuccessState
    extends MedicalDescriptionState {
  final List<AllMedicalRecordsModel> allMedicalDescriptions;
  GetAllMedicalDescriptionsSuccessState({required this.allMedicalDescriptions});
  @override
  List<Object?> get props => [allMedicalDescriptions];
}

final class GetMedicalDescriptionsDetailsSuccessState
    extends MedicalDescriptionState {
  final MedicalDescriptionDetailsModel medicalDescriptionModel;
  GetMedicalDescriptionsDetailsSuccessState(
      {required this.medicalDescriptionModel});
  @override
  List<Object?> get props => [medicalDescriptionModel];
}

final class CreateMedicalDescriptionErrorState extends MedicalDescriptionState {
  final String errorMessage;
  CreateMedicalDescriptionErrorState({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}

final class CreateMedicalDescriptionSuccessState
    extends MedicalDescriptionState {
  CreateMedicalDescriptionSuccessState();
  @override
  List<Object?> get props => [];
}
final class EditMedicalDescriptionSuccessState
    extends MedicalDescriptionState {

  @override
  List<Object?> get props => [];
}
