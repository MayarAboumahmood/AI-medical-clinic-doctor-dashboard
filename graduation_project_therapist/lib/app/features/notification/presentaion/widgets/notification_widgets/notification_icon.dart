import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

Align notificationIcon(IconData icon) {
  return Align(
    alignment: const AlignmentDirectional(-1.00, -1.00),
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeInOut,
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: customColors.primary,
          width: 2,
        ),
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(2, 2, 2, 2),
        child: Icon(
          icon,
          color: customColors.primary,
          size: 20,
        ),
      ),
    ),
  );
}
