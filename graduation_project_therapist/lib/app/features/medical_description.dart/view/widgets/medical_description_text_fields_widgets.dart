import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/features/medical_description.dart/cubit/medical_description_cubit.dart';
import 'package:graduation_project_therapist_dashboard/app/features/patient_requests/view/widgets/pick_day_conainer.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/dialog_snackbar_pop_up/show_date_picker_widget.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/text_related_widget/text_fields/text_field.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

Padding textFieldsColumn(
    BuildContext context, Widget firstTextField, Widget secondTextField,
    {Widget? thirdTextField}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: Column(
      children: [
        firstTextField,
        const SizedBox(height: 10),
        secondTextField,
        Visibility(
            visible: thirdTextField != null,
            child: const SizedBox(
              height: 10,
            )),
        thirdTextField ?? const SizedBox(),
      ],
    ),
  );
}

Row dividersWithSectionName(String sectionName) {
  return Row(
    children: [
      dividerSection(1),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Text(
          sectionName.tr(),
          style: customTextStyle.bodySmall,
        ),
      ),
      dividerSection(3),
    ],
  );
}

Flexible dividerSection(int flex) {
  return Flexible(
    flex: flex,
    child: Container(
      height: 1,
      color: customColors.primary,
    ),
  );
}

Padding medicalPersonalHistoryColumn(BuildContext context) {
  MedicalDescriptionCubit medicalDescriptionCubit =
      context.read<MedicalDescriptionCubit>();
  return textFieldsColumn(
    context,
    customTextField(
      controller: medicalDescriptionCubit.medicalPersonalHistoryTypeController,
      context: context,
      label: 'type',
    ),
    customTextField(
      controller:
          medicalDescriptionCubit.medicalPersonalHistoryDescriptionController,
      context: context,
      label: 'description',
    ),
  );
}

Padding medicalFamilyHistoryColumn(BuildContext context) {
  MedicalDescriptionCubit medicalDescriptionCubit =
      context.read<MedicalDescriptionCubit>();

  return textFieldsColumn(
    context,
    customTextField(
      controller: medicalDescriptionCubit.medicalFamilyHistoryTypeController,
      context: context,
      label: 'type',
    ),
    customTextField(
      controller:
          medicalDescriptionCubit.medicalFamilyHistoryDescriptionController,
      context: context,
      label: 'description',
    ),
  );
}

Padding medicalConditionColumn(BuildContext context) {
  MedicalDescriptionCubit medicalDescriptionCubit =
      context.read<MedicalDescriptionCubit>();

  return textFieldsColumn(
    context,
    customTextField(
      controller: medicalDescriptionCubit.symptomsController,
      context: context,
      label: 'symptoms',
    ),
    PickDayContainer(
      paddingInHorizontal: 0,
      paddingInVertical: 0,
      whatBlocShouldDoOnTap: (selectedDate) {
        medicalDescriptionCubit.startDate = selectedDate;
      },
      datePickType: DatePickType.nothing,
    ),
    thirdTextField: customTextField(
        context: context,
        label: 'causes',
        controller: medicalDescriptionCubit.causesController),
  );
}

Padding medicalRecordColumn(BuildContext context) {
  MedicalDescriptionCubit medicalDescriptionCubit =
      context.read<MedicalDescriptionCubit>();

  return textFieldsColumn(
    context,
    customTextField(
      context: context,
      controller: medicalDescriptionCubit.mainComplaintController,
      label: 'main complaint',
    ),
    const SizedBox(),
  );
}

Padding medicalDiagnosisColumn(BuildContext context) {
  MedicalDescriptionCubit medicalDescriptionCubit =
      context.read<MedicalDescriptionCubit>();

  return textFieldsColumn(
    context,
    customTextField(
        context: context,
        label: 'differential diagnosis',
        controller: medicalDescriptionCubit.differentialDiagnosisController),
    customTextField(
        context: context,
        label: 'treatment plan',
        controller: medicalDescriptionCubit.treatmentPlanController),
  );
}

Widget medicalInfoTextColumn(String firstText, String secondText) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        firstText,
        style: customTextStyle.bodyMedium,
      ),
      Text(
        secondText,
        style: customTextStyle.bodyMedium,
      ),
    ]),
  );
}
