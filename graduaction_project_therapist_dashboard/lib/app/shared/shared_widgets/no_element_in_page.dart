import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

Padding buildNoElementInPage(String title, IconData? icon,
    {bool noIcon = false}) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        noIcon
            ? const SizedBox()
            : Icon(
                icon,
                size: 60,
                color: customColors.primary,
              ),
        const SizedBox(height: 10),
        Text(
          title.tr(),
          textAlign: TextAlign.center,
          style: customTextStyle.bodyLarge.copyWith(
              color: customColors.primary, fontWeight: FontWeight.normal),
        ),
      ],
    ),
  );
}
