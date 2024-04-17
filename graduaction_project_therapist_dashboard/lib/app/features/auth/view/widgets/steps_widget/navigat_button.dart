import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/buttons/button_with_options.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

Widget navigateButton(Function() onPressed, text, loading) {
  return Align(
    alignment: const AlignmentDirectional(0.00, 1.00),
    child: Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 127, 0, 0),
      child: GeneralButtonOptions(
        onPressed: onPressed,
        loading: loading,
        text: text,
        options: ButtonOptions(
          width: 329,
          height: 45,
          padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
          iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
          color: customColors.primary,
          textStyle: customTextStyle.titleSmall.copyWith(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
          borderSide: const BorderSide(
            color: Colors.transparent,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
  );
}
