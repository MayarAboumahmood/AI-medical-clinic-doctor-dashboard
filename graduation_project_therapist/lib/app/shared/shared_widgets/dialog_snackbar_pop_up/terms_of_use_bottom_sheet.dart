import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/app/core/constants/app_string/app_string.dart';
import 'package:graduation_project_therapist_dashboard/app/features/profile/presentation/screens/profile/profile_screen.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_functions/show_bottom_sheet.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

Future<dynamic> termOfUseBottomSheet(BuildContext context) {
  return showBottomSheetWidget(
      context,
      Container(
          decoration: BoxDecoration(
              color: customColors.primaryBackGround,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15))),
          width: double.infinity,
          height: responsiveUtil.screenHeight * .8,
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'SMC" App Usage Policy'.tr(),
                  style: customTextStyle.bodyLarge.copyWith(
                    color: customColors.text2,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                middelTitle('1. Introduction'.tr()),
                normalDescription(AppString.introduction),
                const SizedBox(
                  height: 10,
                ),
                middelTitle('2. Acceptance of Terms'.tr()),
                normalDescription(AppString.acceptanceOfTerms),
                const SizedBox(
                  height: 10,
                ),
                middelTitle('3. Account Registration and Security'.tr()),
                normalDescription(AppString.accountRegistrationAndSecurity1),
                normalDescription(AppString.accountRegistrationAndSecurity2),
                const SizedBox(
                  height: 10,
                ),
                middelTitle('4. Use of the App'.tr()),
                normalDescription(AppString.useOfTheApp1),
                normalDescription(AppString.useOfTheApp2),
                const SizedBox(
                  height: 10,
                ),
                middelTitle('5. Intellectual Property'.tr()),
                normalDescription(AppString.intellectualPropertyRights),
                normalDescription(AppString.intellectualPropertyRights2),
                const SizedBox(
                  height: 10,
                ),
                middelTitle('6. Registration as a Service Provider'.tr()),
                normalDescription(AppString.registrationAsServiceProvider1),
                normalDescription(AppString.registrationAsServiceProvider2),
                const SizedBox(
                  height: 10,
                ),
                middelTitle('7. Cancellation and Refund'.tr()),
                normalDescription(AppString.cancellationAndRefund),
                const SizedBox(
                  height: 10,
                ),
                middelTitle('8. Disclaimer and Limitations'.tr()),
                normalDescription(AppString.disclaimerAndLimitations),
                const SizedBox(
                  height: 10,
                ),
                middelTitle('9. Contact and Support'.tr()),
                normalDescription(AppString.contactAndSupportPartOne),
                const SizedBox(
                  height: 10,
                ),
                normalDescription(AppString.contactAndSupportPartTwo),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
          ))));
}
