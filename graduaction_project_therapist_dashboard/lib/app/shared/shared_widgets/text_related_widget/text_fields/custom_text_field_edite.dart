import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

Widget customTextFieldEdite(
    {Widget? prefix,
    required BuildContext context,
    required String label,
    bool? isPassWordInVisible,
    Widget? suffixIcon,
    String? errorText,
    required String? Function(String?) validator,
    required Function(String?)? onChanged}) {
  return TextFormField(
    onChanged: onChanged,
    obscureText: isPassWordInVisible ?? false,
    decoration: InputDecoration(
      hoverColor: customColors.secondaryBackGround,
      suffixIcon: suffixIcon,
      prefix: prefix,
      errorText: errorText,
      labelText: label.tr(),
      labelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: customColors.secondaryText,
            fontSize: 12,
          ),
      hintStyle: customTextStyle.bodyMedium.copyWith(
          color: customColors.secondaryText,
          fontWeight: FontWeight.w400,
          fontSize: 12),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.transparent, // Normal state: Silver color
          width: 2,
        ),
        borderRadius: BorderRadius.circular(40),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: customColors.primary, // Focused state: Green color
          width: 2,
        ),
        borderRadius: BorderRadius.circular(40),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: customColors.error,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(40),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: customColors.error,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(40),
      ),
      filled: true,
      fillColor: customColors.secondaryBackGround,
      contentPadding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
    ),
    style: Theme.of(context).textTheme.bodySmall!.copyWith(
          color: customColors.secondaryText,
        ),
    validator: validator,
  );
}
