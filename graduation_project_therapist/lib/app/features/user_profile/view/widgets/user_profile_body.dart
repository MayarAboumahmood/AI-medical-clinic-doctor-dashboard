import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/app/features/user_profile/data_source/models/patient_profile_model.dart';
import 'package:graduation_project_therapist_dashboard/app/features/user_profile/view/widgets/therapist_dialog.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/buttons/button_with_options.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/dialog_snackbar_pop_up/custom_snackbar.dart';
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
      profilePageDivider(),
      SizedBox(height: responsiveUtil.screenHeight * .1),
      Align(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            isDoctor
                ? assignTherapistbutton(context)
                : sendRequestToPatientbutton(context),
            goToMedicalRecordsButton(context),
          ],
        ),
      )
    ],
  );
}

GeneralButtonOptions sendRequestToPatientbutton(BuildContext context) {
  return GeneralButtonOptions(
      text: 'Assign a Therapist for this patient'.tr(),
      onPressed: () {
        showTherapistDialog(
            context); //Todo: show a dialog with all the data the therapist should send to set an appontmint.
      },
      options: ButtonOptions(
          color: customColors.primary, textStyle: customTextStyle.bodyMedium));
}

GeneralButtonOptions assignTherapistbutton(BuildContext context) {
  return GeneralButtonOptions(
      text: 'Assign a Therapist for this patient'.tr(),
      onPressed: () {
        showTherapistDialog(context);
      },
      options: ButtonOptions(
          color: customColors.primary, textStyle: customTextStyle.bodyMedium));
}

GeneralButtonOptions goToMedicalRecordsButton(BuildContext context) {
  return GeneralButtonOptions(
      text: 'Go to User medical records'.tr(),
      onPressed: () {
        customSnackBar('TODO', context, isFloating: true);
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
