import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

Container notificationDote() {
  return Container(
    width: responsiveUtil.scaleWidth(12),
    height: responsiveUtil.scaleWidth(12),
    decoration: BoxDecoration(
      color: customColors.textSpam,
      shape: BoxShape.circle,
    ),
  );
}
