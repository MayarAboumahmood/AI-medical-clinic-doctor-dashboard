import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

import '../../../../../core/constants/app_string/app_string.dart';

Widget richedTextSteps(BuildContext context, int stepNumber) {
  return RichText(
    text: TextSpan(
      children: [
        TextSpan(
          text: AppString.step.tr(),
          style: GoogleFonts.getFont(
            'Rubik',
            color: customColors.primary,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
        TextSpan(
          text: stepNumber.toString(),
          style: TextStyle(
            color: customColors.primary,
          ),
        ),
        TextSpan(
          text: "/",
          style: TextStyle(
            color: customColors.primary,
          ),
        ),
        TextSpan(
          text: "4",
          style: TextStyle(
            color: customColors.primary,
          ),
        )
      ],
      style: customTextStyle.bodyMedium.copyWith(
        color: customColors.secondaryText,
        letterSpacing: 1,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}
