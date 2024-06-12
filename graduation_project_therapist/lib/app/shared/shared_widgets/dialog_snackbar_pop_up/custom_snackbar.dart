import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/app/core/constants/app_routs/app_routs.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

ScaffoldFeatureController customSnackBar(String title, BuildContext context,
    {bool isFloating = false}) {
  title = endUserSession(context, title);
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    behavior: isFloating ? SnackBarBehavior.floating : null,
    backgroundColor: customColors.secondaryBackGround,
    content: Text(
      title.tr(),
      style:
          customTextStyle.bodyMedium.copyWith(color: customColors.primaryText),
    ),
  ));
}

String endUserSession(BuildContext context, String title) {
  if (title == 'jwt expired' || title == 'User not found') {
    navigationService.navigationOfAllPagesToName(context, welcomeScreen);
    sharedPreferences!.remove('token');
    sharedPreferences!.remove('user_profile');
    sharedPreferences!.remove('isRegisterCompleted');
    title =
        "Your session has expired. Please log in again to continue using the app."
            .tr();
  }
  return title;
}
