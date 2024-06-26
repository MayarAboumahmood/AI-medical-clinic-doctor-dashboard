import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/app/features/medical_description.dart/data_source/models/medical_description_model.dart';
import 'package:graduation_project_therapist_dashboard/app/features/medical_description.dart/repo/medical_description_repo.dart';

part 'medical_description_state.dart';

class MedicalDescriptionCubit extends Cubit<MedicalDescriptionState> {
  MedicalDescriptionCubit({required this.medicalDescriptionRepositoryImp})
      : super(MedicalDescriptionInitial());

  final MedicalDescriptionRepositoryImp medicalDescriptionRepositoryImp;
  late TextEditingController differentialDiagnosisController;
  late TextEditingController treatmentPlanController;
  late TextEditingController medicalPersonalHistoryTypeController;
  late TextEditingController medicalPersonalHistoryDescriptionController;
  late TextEditingController medicalFamilyHistoryTypeController;
  late TextEditingController medicalFamilyHistoryDescriptionController;
  late TextEditingController symptomsController;
  String startDate='';
  late TextEditingController causesController;
  late TextEditingController mainComplaintController;
  void createNewMedicalDescription() async {
    emit(CreateMedicalDescriptionLoadingState());
    //Todo: fix the patientID.
    MedicalDescriptionModel medicalDescriptionModel = MedicalDescriptionModel(
        patientId: 2,
        mainComplaint: mainComplaintController.text,
        symptoms: symptomsController.text,
        causes: causesController.text,
        startDate: startDate,
        fType: medicalFamilyHistoryTypeController.text,
        fDescription: medicalFamilyHistoryDescriptionController.text,
        pType: medicalPersonalHistoryTypeController.text,
        pDescription: medicalPersonalHistoryDescriptionController.text,
        differentialDiagnosis: differentialDiagnosisController.text,
        treatmentPlan: treatmentPlanController.text);

    final getData = await medicalDescriptionRepositoryImp
        .createMedicalDescription(medicalDescriptionModel);
    getData.fold(
        (errorMessage) => emit(
            CreateMedicalDescriptionErrorState(errorMessage: errorMessage)),
        (done) => emit(CreateMedicalDescriptionSuccessState()));
  }
}
