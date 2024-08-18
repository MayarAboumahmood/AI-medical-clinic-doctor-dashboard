import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/app/features/medical_description.dart/data_source/models/all_medical_records_model.dart';
import 'package:graduation_project_therapist_dashboard/app/features/medical_description.dart/data_source/models/medical_description_model.dart';
import 'package:graduation_project_therapist_dashboard/app/features/medical_description.dart/data_source/models/medical_details_model.dart';
import 'package:graduation_project_therapist_dashboard/app/features/medical_description.dart/repo/medical_description_repo.dart';

part 'medical_description_state.dart';

class MedicalDescriptionCubit extends Cubit<MedicalDescriptionState> {
  MedicalDescriptionCubit({required this.medicalDescriptionRepositoryImp})
      : super(MedicalDescriptionInitial());
  int cahcedPatientID = -1;
  MedicalDescriptionDetailsModel? cachedMedicalDescriptionModel;

  final MedicalDescriptionRepositoryImp medicalDescriptionRepositoryImp;
  late TextEditingController differentialDiagnosisController;
  late TextEditingController treatmentPlanController;
  late TextEditingController medicalPersonalHistoryTypeController;
  late TextEditingController medicalPersonalHistoryDescriptionController;
  late TextEditingController medicalFamilyHistoryTypeController;
  late TextEditingController medicalFamilyHistoryDescriptionController;
  late TextEditingController symptomsController;
  String startDate = '';
  late TextEditingController causesController;
  late TextEditingController mainComplaintController;
  void createNewMedicalDescription() async {
    emit(CreateMedicalDescriptionLoadingState());

    MedicalDescriptionModel medicalDescriptionModel = MedicalDescriptionModel(
        patientId: cahcedPatientID,
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

  void editMedicalDescription(int medicalDescriptionId) async {
    emit(EditMedicalDescriptionLoadingState());

    MedicalDescriptionModel medicalDescriptionModel = MedicalDescriptionModel(
        patientId: cahcedPatientID,
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
        .editMedicalDescription(medicalDescriptionModel, medicalDescriptionId);
    getData.fold(
      (errorMessage) =>
          emit(CreateMedicalDescriptionErrorState(errorMessage: errorMessage)),
      (done) {
        cachedMedicalDescriptionModel = null;
        emit(EditMedicalDescriptionSuccessState());
      },
    );
  }

  void getAllMedicalDescription(int patientID) async {
    cahcedPatientID = patientID;
    emit(GetAllMedicalDescriptionsLoadingState());

    final getData =
        await medicalDescriptionRepositoryImp.getAllMedicalRecords(patientID);
    getData.fold(
        (errorMessage) => emit(
            GetAllMedicalDescriptionsErrorState(errorMessage: errorMessage)),
        (done) => emit(GetAllMedicalDescriptionsSuccessState(
            allMedicalDescriptions: done)));
  }

  void getMedicalDescriptionDetails(int medicalDescriptionID) async {
    emit(GetAllMedicalDescriptionsLoadingState());

    final getData = await medicalDescriptionRepositoryImp
        .getMedicalDescriptionDetails(medicalDescriptionID);
    getData.fold(
        (errorMessage) => emit(
            GetAllMedicalDescriptionsErrorState(errorMessage: errorMessage)),
        (done) {
      cachedMedicalDescriptionModel = done;

      emit(
        GetMedicalDescriptionsDetailsSuccessState(
            medicalDescriptionModel: done),
      );
    });
  }
}
