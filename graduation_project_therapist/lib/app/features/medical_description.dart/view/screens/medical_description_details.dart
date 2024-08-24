import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/core/constants/app_routs/app_routs.dart';
import 'package:graduation_project_therapist_dashboard/app/features/block_and_report/view/widgets/patient_card_option__munie.dart';
import 'package:graduation_project_therapist_dashboard/app/features/medical_description.dart/cubit/medical_description_cubit.dart';
import 'package:graduation_project_therapist_dashboard/app/features/medical_description.dart/data_source/models/medical_description_arguments.dart';
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
  late String patientName;
  late int patientID;
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
      final args =
          ModalRoute.of(context)!.settings.arguments as MedicalDetailsArgs;

      medicalDescriptionId = args.medicalDescriptionId;
      patientName = args.patientName;
      patientID = args.patientID;

      medicalDescriptionCubit
          .getMedicalDescriptionDetails(medicalDescriptionId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (_) {
        medicalDescriptionCubit.getAllMedicalDescription(patientID);
      },
      child: Scaffold(
        floatingActionButton: isDoctor
            ? BlocBuilder<MedicalDescriptionCubit, MedicalDescriptionState>(
                builder: (context, state) {
                  if (state is GetMedicalDescriptionsDetailsSuccessState) {
                    return floatinActionButtonUpdate(
                        state.medicalDescriptionModel);
                  } else if (medicalDescriptionCubit
                          .cachedMedicalDescriptionModel !=
                      null) {
                    return floatinActionButtonUpdate(
                        medicalDescriptionCubit.cachedMedicalDescriptionModel!);
                  }
                  return const SizedBox();
                },
              )
            : const SizedBox(),
        backgroundColor: customColors.primaryBackGround,
        appBar: appBarPushingScreens(
          'Medical descriptions details',
          isFromScaffold: true,
          optionMenu: buildAppbarOptionsMenu(
              context, patientID, patientName, medicalDescriptionId),
        ),
        body: BlocConsumer<MedicalDescriptionCubit, MedicalDescriptionState>(
          listener: (context, state) {
            if (state is GetAllMedicalDescriptionsErrorState) {
              customSnackBar(state.errorMessage, context, isFloating: true);
            } else if (medicalDescriptionCubit.cachedMedicalDescriptionModel ==
                null) {
              medicalDescriptionCubit
                  .getMedicalDescriptionDetails(medicalDescriptionId);
            }
          },
          builder: (context, state) {
            if (state is GetMedicalDescriptionsDetailsSuccessState) {
              return medicalDescriptiondDataColumn(
                  state.medicalDescriptionModel);
            } else if (state is GetAllMedicalDescriptionsErrorState ||
                state is GetAllMedicalDescriptionsLoadingState) {
              return buildListOfShimmerForProfilePage();
            } else {
              if (medicalDescriptionCubit.cachedMedicalDescriptionModel !=
                  null) {
                return medicalDescriptiondDataColumn(
                    medicalDescriptionCubit.cachedMedicalDescriptionModel!);
              } else {
                return buildListOfShimmerForProfilePage();
              }
            }
          },
        ),
      ),
    );
  }

  FloatingActionButton floatinActionButtonUpdate(
      MedicalDescriptionDetailsModel medicalDescriptionDetailsModel) {
    return FloatingActionButton.extended(
        backgroundColor: customColors.primary,
        onPressed: () {
          navigationService.navigateTo(medicalDescriptionPage,
              arguments: medicalDescriptionDetailsModel);
        },
        label: Text(
          'update'.tr(),
          style: customTextStyle.bodyMedium,
        ));
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
                '${'differential Diagnosis:'.tr()} ${medicalRecordData.medicalDiagnosis.first.differentialDiagnosis}',
                '${'treatment Plan:'.tr()} ${medicalRecordData.medicalDiagnosis.first.treatmentPlan}')
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
        const SizedBox(height: 25)
      ]),
    );
  }
}
