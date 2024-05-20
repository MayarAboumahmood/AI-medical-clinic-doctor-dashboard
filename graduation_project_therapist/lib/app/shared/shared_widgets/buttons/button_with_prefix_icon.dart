import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

Widget buttonWithPrefixIcon(IconData icon, Color? iconColor, String title) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10), color: customColors.primary),
    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Icon(
        icon,
        color: iconColor ?? customColors.secondaryText,
      ),
      Text(
        title,
        style: customTextStyle.bodyLarge
            .copyWith(color: customColors.secondaryText),
      )
    ]),
  );
}
