import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/app/core/constants/app_images/app_images.dart';
import 'package:graduation_project_therapist_dashboard/app/core/constants/app_string/app_string.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

import 'build_image_text_in_bahground.dart';

Widget buildPageView(BuildContext context, PageController controller) {
  return SingleChildScrollView(
    child: SizedBox(
      width: double.infinity,
      height: responsiveUtil.screenHeight,
      child: PageView(
        controller: controller,
        children: [
          buildTextAndImageInBackGround(
              context: context,
              title: AppString.weAreHere.tr(),
              smallTitle: AppString.providingASecure.tr(),
              imagePath: AppImages.pageView1),
          buildTextAndImageInBackGround(
              context: context,
              title: AppString.privacyIsPriority.tr(),
              smallTitle: AppString.allDataEncrypted.tr(),
              imagePath: AppImages.pageView2),
          buildTextAndImageInBackGround(
              context: context,
              title: AppString.feelSafeSharing.tr(),
              smallTitle: AppString.protectYourPersonalInformation.tr(),
              imagePath: AppImages.pageView3),
        ],
      ),
    ),
  );
}
