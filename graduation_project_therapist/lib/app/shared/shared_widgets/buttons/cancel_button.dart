import 'package:graduation_project_therapist_dashboard/app/shared/shared_functions/check_if_rtl.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

Widget buildCancelButton(BuildContext context) {
  return Align(
    alignment: isRTL(context) ? Alignment.centerLeft : Alignment.centerRight,
    child: InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        navigationService.goBack();
      },
      child: Icon(
        Icons.cancel_outlined,
        color: customColors.secondaryText,
        size: 24,
      ),
    ),
  );
}
