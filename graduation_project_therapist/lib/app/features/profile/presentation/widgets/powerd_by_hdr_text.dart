import 'package:graduation_project_therapist_dashboard/main.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

Padding poweredByMayar() {
  return Padding(
    padding: const EdgeInsets.only(top: 10, bottom: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Powered by'.tr(),
          style: customTextStyle.bodyLarge,
        ),
        Text(
          '  ',
          style: customTextStyle.bodyLarge,
        ),
        Text(
          'Mayar ab',
          style:
              customTextStyle.bodyLarge.copyWith(color: customColors.primary),
        ),
      ],
    ),
  );
}
