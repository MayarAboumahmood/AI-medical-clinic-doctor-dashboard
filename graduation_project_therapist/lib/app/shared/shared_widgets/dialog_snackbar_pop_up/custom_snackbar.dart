import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/app/features/profile/presentation/screens/profile/profile_screen.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

bool isThereIsSnackBar = false;
bool isEndUserSession = false;

ScaffoldFeatureController? customSnackBar(String title, BuildContext context,
    {bool isFloating = false}) {
  title = endUserSession(context, title);
  if (!isThereIsSnackBar) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: isFloating ? SnackBarBehavior.floating : null,
        backgroundColor: customColors.secondaryBackGround,
        onVisible: () {
          isThereIsSnackBar = true;
          makeIsThereIsSnackBarVarFalseAfterTheSnackBarClosed();
        },
        duration: const Duration(seconds: 2),
        content: Text(
          title.tr(),
          style: customTextStyle.bodyMedium
              .copyWith(color: customColors.primaryText),
        ),
      ),
    );
  }
  return null;
}

makeIsThereIsSnackBarVarFalseAfterTheSnackBarClosed() {
  return Future.delayed(const Duration(seconds: 2), () {
    isThereIsSnackBar = false;
  });
}

makeIsisEndUserSessionVarFalseAfterTheSnackBarClosed() {
  return Future.delayed(const Duration(seconds: 2), () {
    isEndUserSession = false;
  });
}

String endUserSession(BuildContext context, String title) {
  if (!isEndUserSession) {
    if (title == 'jwt expired.' ||
        title == 'User not found.' ||
        title == 'Not allowed.' ||
        title == 'jwt expired' ||
        title == 'User not found' ||
        title == 'Not allowed' ||
        title == 'No Token Provided.' ||
        title == 'No Token Provided' ||
        title == 'There is another session open , please login again') {
      logOut();
      logOutClearBloc(context);
      if (title != 'There is another session open , please login again') {
        title =
            "Your session has expired. Please log in again to continue using the app."
                .tr();
      }
      isEndUserSession = true;
      makeIsisEndUserSessionVarFalseAfterTheSnackBarClosed();
    }
  }
  return title;
}
