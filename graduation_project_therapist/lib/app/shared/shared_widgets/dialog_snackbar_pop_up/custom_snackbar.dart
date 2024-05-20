import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

ScaffoldFeatureController customSnackBar(String title, BuildContext context,
    {bool isFloating = false}) {
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
