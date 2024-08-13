import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/core/constants/app_string/app_string.dart';
import 'package:graduation_project_therapist_dashboard/app/features/medical_description.dart/cubit/medical_description_cubit.dart';
import 'package:graduation_project_therapist_dashboard/app/features/medical_description.dart/data_source/models/medical_details_model.dart';
import 'package:graduation_project_therapist_dashboard/app/features/medical_description.dart/view/widgets/medical_description_text_fields_widgets.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/app_bar_pushing_screens.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/buttons/button_with_options.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/dialog_snackbar_pop_up/custom_snackbar.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

class MedicalDescriptionPage extends StatefulWidget {
  const MedicalDescriptionPage({super.key});

  @override
  State<MedicalDescriptionPage> createState() => _MedicalDescriptionPageState();
}

class _MedicalDescriptionPageState extends State<MedicalDescriptionPage> {
  late MedicalDescriptionCubit medicalDescriptionCubit;
  @override
  void initState() {
    super.initState();
    medicalDescriptionCubit = context.read<MedicalDescriptionCubit>();
    initTextEditingContollers();
  }

  bool firstTime = true;

  late MedicalDescriptionDetailsModel? medicalDescriptionDetailsModel;
  bool isModelAvailable = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (firstTime) {
      firstTime = false;
      final args = ModalRoute.of(context)!.settings.arguments
          as MedicalDescriptionDetailsModel?;

      // Check if the argument is null and set the boolean accordingly
      if (args == null) {
        print('sssssssssssssssssssssssssss nulllllllllllllllllll');
        isModelAvailable = false;
      } else {
        print('sssssssssssssssssssssssssss elssssssssssssssssss');
        medicalDescriptionDetailsModel = args;
        isModelAvailable = true;
        fullTextControllersInUpdate();
      }
    }
  }

  void fullTextControllersInUpdate() {
    if (isModelAvailable) {
      if (medicalDescriptionDetailsModel!.data.medicalDiagnosis.isNotEmpty) {
        medicalDescriptionCubit.differentialDiagnosisController.text =
            medicalDescriptionDetailsModel!
                .data.medicalDiagnosis[0].differentialDiagnosis;
        medicalDescriptionCubit.treatmentPlanController.text =
            medicalDescriptionDetailsModel!
                .data.medicalDiagnosis[0].treatmentPlan;
      }
      if (medicalDescriptionDetailsModel!
          .data.medicalPersonalHistories.isNotEmpty) {
        medicalDescriptionCubit.medicalPersonalHistoryTypeController.text =
            medicalDescriptionDetailsModel!
                .data.medicalPersonalHistories[0].type;
        medicalDescriptionCubit
                .medicalPersonalHistoryDescriptionController.text =
            medicalDescriptionDetailsModel!
                .data.medicalPersonalHistories[0].description;
      }
      if (medicalDescriptionDetailsModel!
          .data.medicalFamilyHistories.isNotEmpty) {
        medicalDescriptionCubit.medicalFamilyHistoryDescriptionController.text =
            medicalDescriptionDetailsModel!
                .data.medicalFamilyHistories[0].description;
        medicalDescriptionCubit.medicalFamilyHistoryTypeController.text =
            medicalDescriptionDetailsModel!.data.medicalFamilyHistories[0].type;
      }

      if (medicalDescriptionDetailsModel!.data.medicalConditions.isNotEmpty) {
        medicalDescriptionCubit.symptomsController.text =
            medicalDescriptionDetailsModel!.data.medicalConditions[0].symptoms;
        medicalDescriptionCubit.causesController.text =
            medicalDescriptionDetailsModel!.data.medicalConditions[0].causes;
      }
      medicalDescriptionCubit.mainComplaintController.text =
          medicalDescriptionDetailsModel!.data.mainComplaint;
    }
  }

  void initTextEditingContollers() {
    medicalDescriptionCubit.differentialDiagnosisController =
        TextEditingController();
    medicalDescriptionCubit.treatmentPlanController = TextEditingController();
    medicalDescriptionCubit.medicalPersonalHistoryTypeController =
        TextEditingController();
    medicalDescriptionCubit.medicalPersonalHistoryDescriptionController =
        TextEditingController();
    medicalDescriptionCubit.medicalFamilyHistoryTypeController =
        TextEditingController();
    medicalDescriptionCubit.medicalFamilyHistoryDescriptionController =
        TextEditingController();
    medicalDescriptionCubit.symptomsController = TextEditingController();
    medicalDescriptionCubit.causesController = TextEditingController();
    medicalDescriptionCubit.mainComplaintController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    disposeTextEditingControllers();
  }

  void disposeTextEditingControllers() {
    medicalDescriptionCubit.differentialDiagnosisController.dispose();
    medicalDescriptionCubit.treatmentPlanController.dispose();
    medicalDescriptionCubit.medicalPersonalHistoryTypeController.dispose();
    medicalDescriptionCubit.medicalPersonalHistoryDescriptionController
        .dispose();
    medicalDescriptionCubit.medicalFamilyHistoryTypeController.dispose();
    medicalDescriptionCubit.medicalFamilyHistoryDescriptionController.dispose();
    medicalDescriptionCubit.symptomsController.dispose();
    medicalDescriptionCubit.causesController.dispose();
    medicalDescriptionCubit.mainComplaintController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MedicalDescriptionCubit, MedicalDescriptionState>(
      listener: (context, state) {
        if (state is CreateMedicalDescriptionErrorState) {
          customSnackBar(state.errorMessage, context);
          medicalDescriptionCubit.getAllMedicalDescription(
              medicalDescriptionCubit.cahcedPatientID);
          navigationService.goBack();
        } else if (state is CreateMedicalDescriptionSuccessState) {
          customSnackBar('the Description created successfully', context);
          medicalDescriptionCubit.getAllMedicalDescription(
              medicalDescriptionCubit.cahcedPatientID);
          navigationService.goBack();
        }
      },
      child: PopScope(
        onPopInvokedWithResult: (_, result) {
          if (isModelAvailable) {
            navigationService.goBack();
          }
        },
        child: Scaffold(
          backgroundColor: customColors.primaryBackGround,
          appBar:
              appBarPushingScreens('Medical Description', isFromScaffold: true),
          body: SingleChildScrollView(
            child: Column(children: [
              const SizedBox(
                height: 10,
              ),
              medicalDescriptionNote(AppString.medicalDescriptionForUser1),
              const SizedBox(
                height: 4,
              ),
              medicalDescriptionNote(AppString.medicalDescriptionForUser2),
              const SizedBox(
                height: 4,
              ),
              medicalDescriptionNote(AppString.medicalDescriptionForUser3),
              const SizedBox(
                height: 10,
              ),
              dividersWithSectionName('medical diagnosis'),
              const SizedBox(height: 10),
              medicalDiagnosisColumn(context),
              const SizedBox(
                height: 10,
              ),
              dividersWithSectionName('medical personal history'),
              const SizedBox(height: 10),
              medicalPersonalHistoryColumn(context),
              const SizedBox(
                height: 10,
              ),
              dividersWithSectionName('medical family history'),
              const SizedBox(height: 10),
              medicalFamilyHistoryColumn(context),
              const SizedBox(
                height: 10,
              ),
              dividersWithSectionName('medical condition'),
              const SizedBox(height: 10),
              medicalConditionColumn(context),
              const SizedBox(
                height: 10,
              ),
              dividersWithSectionName('medical record'),
              const SizedBox(height: 10),
              medicalRecordColumn(context),
              const SizedBox(height: 5),
              Container(
                height: 1,
                color: customColors.primary,
              ),
              const SizedBox(height: 15),
              BlocBuilder<MedicalDescriptionCubit, MedicalDescriptionState>(
                builder: (context, state) {
                  bool isLoading =
                      state is CreateMedicalDescriptionLoadingState;
                  return GeneralButtonOptions(
                      text: 'Submit',
                      onPressed: () {
                        medicalDescriptionCubit.createNewMedicalDescription();
                      },
                      loading: isLoading,
                      options: ButtonOptions(
                          width: responsiveUtil.screenWidth * .2,
                          color: customColors.primary,
                          textStyle: customTextStyle.bodyMedium));
                },
              ),
              const SizedBox(height: 10),
            ]),
          ),
        ),
      ),
    );
  }

  Padding medicalDescriptionNote(String note) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        note,
        style: customTextStyle.bodySmall
            .copyWith(color: customColors.secondaryText),
      ),
    );
  }
}
