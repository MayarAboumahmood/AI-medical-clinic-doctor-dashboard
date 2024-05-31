import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

Widget customTextField(
    {Widget? prefix,
    Color? borderSideColor,
    required BuildContext context,
    required String label,
    bool? isPassWordInVisible,
    String? hintText,
    TextInputType? textInputType,
    Widget? suffixIcon,
    String? errorText,
    TextEditingController? controller,
    double? borderRadius,
    String? Function(String?)? validator,
    Function(String?)? onChanged,
    Function(String?)? onSaved,
    bool enable = true}) {
  return TextFormField(
    enabled: enable,
    keyboardType: textInputType,
    cursorColor: customColors.primary,
    onSaved: onSaved,
    onChanged: onChanged,
    controller: controller,
    obscureText: isPassWordInVisible ?? false,
    decoration: InputDecoration(
      suffixIcon: suffixIcon,
      prefix: prefix,
      errorText: errorText,
      labelText: label.tr(),
      labelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: customColors.secondaryText,
            fontSize: 12,
          ),
      hintText: hintText,
      hintStyle: customTextStyle.bodyMedium.copyWith(
          color: customColors.secondaryText,
          fontWeight: FontWeight.w400,
          fontSize: 12),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: borderSideColor ?? customColors.secondaryBackGround,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(borderRadius ??
            10), //if you need to update this value just send it as a parameter.
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: customColors.secondaryBackGround,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(borderRadius ?? 10),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: customColors.error,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(borderRadius ?? 10),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: customColors.secondaryBackGround,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(borderRadius ?? 10),
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

Widget editeProfileTextField(
    {IconData? prefix,
    required BuildContext context,
    required String label,
    required TextEditingController controller,
    bool? isPassWordInVisible,
    GlobalKey? key,
    String? hintText,
    Widget? suffixIcon,
    String? errorText,
    TextInputType? textInputType,
    String? Function(String?)? validator,
    Function(String?)? onChanged,
    Function(String?)? onSaved}) {
  return TextFormField(
    key: key,
    keyboardType: textInputType,
    controller: controller,
    onSaved: onSaved,
    onChanged: onChanged,
    obscureText: isPassWordInVisible ?? false,
    decoration: InputDecoration(
      hoverColor: customColors.secondaryText,
      suffixIcon: suffixIcon,
      errorText: errorText,
      labelText: label.tr(),
      labelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: customColors.primary,
            fontSize: 12,
          ),
      hintText: hintText,
      hintStyle: customTextStyle.bodyMedium.copyWith(
          color: customColors.primaryText,
          fontWeight: FontWeight.w400,
          fontSize: 12),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: customColors.secondaryBackGround, // Rest state border color
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: customColors.primary, // Focus state border color
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: customColors.error,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: customColors.error,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      filled: true,
      fillColor: customColors.primaryBackGround,
    ),
    style: Theme.of(context).textTheme.bodySmall!.copyWith(
          color: customColors.primaryText,
        ),
    validator: validator,
  );
}
