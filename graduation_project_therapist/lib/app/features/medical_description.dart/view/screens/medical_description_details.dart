import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/features/medical_description.dart/cubit/medical_description_cubit.dart';
import 'package:graduation_project_therapist_dashboard/app/features/medical_description.dart/data_source/models/medical_details_model.dart';
import 'package:graduation_project_therapist_dashboard/app/features/medical_description.dart/view/widgets/medical_description_text_fields_widgets.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/app_bar_pushing_screens.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/dialog_snackbar_pop_up/custom_snackbar.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/text_related_widget/text_fields/loadin_widget.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

class MedicalDescriptionDetails extends StatefulWidget {
  const MedicalDescriptionDetails({super.key});

  @override
  State<MedicalDescriptionDetails> createState() =>
      _MedicalDescriptionDetailsState();
}

class _MedicalDescriptionDetailsState extends State<MedicalDescriptionDetails> {
  late int medicalDescriptionId;
  bool firstTimeDidChange = true;
  late MedicalDescriptionCubit medicalDescriptionCubit;
  @override
  void initState() {
    super.initState();
    medicalDescriptionCubit = context.read<MedicalDescriptionCubit>();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (firstTimeDidChange) {
      firstTimeDidChange = false;
      final int argument =
          ModalRoute.of(context)!.settings.arguments as int? ?? -1;
      medicalDescriptionId = argument;
      medicalDescriptionCubit
          .getMedicalDescriptionDetails(medicalDescriptionId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: customColors.primary,
          onPressed: () {
            // navigationService.navigateTo(medicalDescriptionPage);
          },
          label: Text(
            'update',
            style: customTextStyle.bodyMedium,
          )),
      backgroundColor: customColors.primaryBackGround,
      appBar: appBarPushingScreens('Medical descriptions details',
          isFromScaffold: true),
      body: BlocConsumer<MedicalDescriptionCubit, MedicalDescriptionState>(
        listener: (context, state) {
          if (state is GetAllMedicalDescriptionsErrorState) {
            customSnackBar(state.errorMessage, context, isFloating: true);
          }
        },
        builder: (context, state) {
          if (state is GetMedicalDescriptionsDetailsSuccessState) {
            return medicalDescriptiondDataColumn(state.medicalDescriptionModel);
          } else {
            return buildListOfShimmerForProfilePage();
          }
        },
      ),
    );
  }

  SingleChildScrollView medicalDescriptiondDataColumn(
      MedicalDescriptionDetailsModel medicalDescriptionModel) {
    MedicalRecordData medicalRecordData = medicalDescriptionModel.data;
    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
              "${'Created at:'.tr()} ${DateFormat('yyyy-MM-dd').format(DateTime.parse(medicalRecordData.createdAt))}",
              style: customTextStyle.bodyLarge),
        ),
        const SizedBox(
          height: 10,
        ),
        medicalInfoTextColumn(medicalRecordData.mainComplaint, ''),

        const SizedBox(
          height: 10,
        ),

        dividersWithSectionName('medical diagnosis'),
        const SizedBox(height: 10),
        medicalRecordData.medicalDiagnosis.isNotEmpty
            ? medicalInfoTextColumn(
                'differential Diagnosis: ${medicalRecordData.medicalDiagnosis.first.differentialDiagnosis}',
                'treatment Plan: ${medicalRecordData.medicalDiagnosis.first.treatmentPlan}')
            : const SizedBox(),
        const SizedBox(
          height: 10,
        ),
        dividersWithSectionName('medical personal history'),
        const SizedBox(height: 10),
        medicalRecordData.medicalPersonalHistories.isNotEmpty
            ? medicalInfoTextColumn(
                'type: ${medicalRecordData.medicalPersonalHistories.first.type}',
                'description: ${medicalRecordData.medicalPersonalHistories.first.description}')
            : const SizedBox(),
        const SizedBox(
          height: 10,
        ),
        dividersWithSectionName('medical family history'),
        const SizedBox(height: 10),
        // medicalFamilyHistoryColumn(context),
        medicalRecordData.medicalFamilyHistories.isNotEmpty
            ? medicalInfoTextColumn(
                'type: ${medicalRecordData.medicalFamilyHistories.first.type}',
                'description: ${medicalRecordData.medicalFamilyHistories.first.description}')
            : const SizedBox(),
        const SizedBox(
          height: 10,
        ),
        dividersWithSectionName('medical condition'),
        const SizedBox(height: 10),
        medicalRecordData.medicalConditions.isNotEmpty
            ? medicalInfoTextColumn(
                'causes: ${medicalRecordData.medicalConditions.first.causes}',
                'Start date: ${medicalRecordData.medicalConditions.first.startDate}')
            : const SizedBox(),
        medicalRecordData.medicalConditions.isNotEmpty
            ? medicalInfoTextColumn(
                'symptoms: ${medicalRecordData.medicalConditions.first.symptoms}',
                '')
            : const SizedBox(),
        // medicalConditionColumn(context),
        const SizedBox(
          height: 10,
        ),
        Container(
          height: 1,
          color: customColors.primary,
        ),
        const SizedBox(height: 15),

        // GeneralButtonOptions(
        //     text: 'Submit',
        //     onPressed: () {
        //       // medicalDescriptionCubit.createNewMedicalDescription();
        //     },
        //     options: ButtonOptions(
        //         width: responsiveUtil.screenWidth * .2,
        //         color: customColors.primary,
        //         textStyle: customTextStyle.bodyMedium)),

        const SizedBox(height: 10)
      ]),
    );
  }
}
