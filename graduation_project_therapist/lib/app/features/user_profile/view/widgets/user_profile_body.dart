import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/app/features/user_profile/data_source/models/user_profile_model.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/buttons/button_with_options.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/dialog_snackbar_pop_up/custom_snackbar.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

Widget userProfileBody(UserProfileModel profile,BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      infoSection(
          'Date of Birth', profile.dateOfBirth.toIso8601String().split('T')[0]),
      profilePageDivider(),
      infoSection('Relationship Status', profile.relationshipState),
      profilePageDivider(),
      infoSection('Number of Kids', profile.numberOfKids.toString()),
      profilePageDivider(),
      infoSection('Current Work', profile.currentWork),
      profile.workHoursPerDay != null ? profilePageDivider() : const SizedBox(),
      profile.workHoursPerDay != null
          ? infoSection(
              'Work Hours per Day', profile.workHoursPerDay.toString())
          : const SizedBox(),
      profile.placeOfWork != null ? profilePageDivider() : const SizedBox(),
      profile.placeOfWork != null
          ? infoSection('Place of Work', profile.currentWork)
          : const SizedBox(),
      profilePageDivider(),
      SizedBox(height: responsiveUtil.screenHeight * .1),
      Align(
        alignment: Alignment.center,
        child: GeneralButtonOptions(
            text: 'Go to User medical record'.tr(),
            onPressed: () {
              customSnackBar('TODO', context, isFloating: true);
            },
            options: ButtonOptions(
                color: customColors.primary,
                textStyle: customTextStyle.bodyMedium)),
      )
    ],
  );
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
