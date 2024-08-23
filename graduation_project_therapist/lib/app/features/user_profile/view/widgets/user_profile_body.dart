import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/core/constants/app_routs/app_routs.dart';
import 'package:graduation_project_therapist_dashboard/app/features/user_profile/cubit/user_profile_cubit.dart';
import 'package:graduation_project_therapist_dashboard/app/features/user_profile/data_source/models/patient_profile_model.dart';
import 'package:graduation_project_therapist_dashboard/app/features/user_profile/view/widgets/send_therapist_request_topatient.dart';
import 'package:graduation_project_therapist_dashboard/app/features/user_profile/view/widgets/therapist_dialog.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/buttons/button_with_options.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

Widget userProfileBody(PatientProfileModel profile, BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      infoSection('Date of Birth', profile.data.dateOfBirth),
      profilePageDivider(),
      infoSection('Relationship Status', profile.data.maritalStatus),
      profilePageDivider(),
      infoSection('Number of Kids', profile.data.children.toString()),
      profilePageDivider(),
      infoSection('Current Work', profile.data.placeOfWork),
      infoSection('Work Hours per Day', profile.data.hoursOfWork.toString()),
      infoSection('Place of Work', profile.data.profession),
    ],
  );
}

Widget buildPatientProfileButtons(
    BuildContext context, PatientProfileModel profile) {
  return Padding(
    padding: EdgeInsets.only(bottom: responsiveUtil.screenHeight * .5),
    child: Align(
      alignment: Alignment.center,
      child: Wrap(
        children: [
          isDoctor
              ? assignTherapistbutton(context, profile.data.id)
              : sendRequestToPatientbutton(
                  context, profile.data.fullName, profile.data.id),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: goToMedicalRecordsButton(context),
          ),
        ],
      ),
    ),
  );
}

GeneralButtonOptions sendRequestToPatientbutton(
    BuildContext context, String patientName, int patientID) {
  return GeneralButtonOptions(
      text: 'Send request for $patientName'.tr(),
      onPressed: () {
        therapistRequestToPatientDialog(context, patientID);
      },
      options: ButtonOptions(
          color: customColors.primary, textStyle: customTextStyle.bodyMedium));
}

GeneralButtonOptions assignTherapistbutton(
    BuildContext context, int patientID) {
  return GeneralButtonOptions(
      text: 'Assign a Therapist for this patient'.tr(),
      onPressed: () {
        showTherapistsDialog(context, patientID);
      },
      options: ButtonOptions(
          color: customColors.primary, textStyle: customTextStyle.bodyMedium));
}

GeneralButtonOptions goToMedicalRecordsButton(BuildContext context) {
  int patientID = context.read<UserProfileCubit>().cachedPatientID;
  return GeneralButtonOptions(
      text: 'Go to User medical records'.tr(),
      onPressed: () {
        navigationService.navigateTo(medicalDescriptionsList,
            arguments: patientID);
      },
      options: ButtonOptions(
          color: customColors.primary, textStyle: customTextStyle.bodyMedium));
}

Divider profilePageDivider() {
  return Divider(
    thickness: 2,
    color: customColors.secondaryText,
  );
}

Widget infoSection(String title, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
    child: RichText(
      text: TextSpan(
        text: '${title.tr()}: ',
        style: customTextStyle.bodyLarge,
        children: [
          TextSpan(
            text: value,
            style: customTextStyle.bodyMedium
                .copyWith(color: customColors.secondaryText),
          ),
        ],
      ),
    ),
  );
}
