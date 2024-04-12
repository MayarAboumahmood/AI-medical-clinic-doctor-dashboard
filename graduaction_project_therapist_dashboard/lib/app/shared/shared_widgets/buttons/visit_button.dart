import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/buttons/button_with_options.dart';

import '../../../../main.dart';

Row visitButton({required Function()? onpressed}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      GeneralButtonOptions(
          text: "Visit".tr(),
          onPressed: onpressed,
          options: ButtonOptions(
            height: 40,
            width: 180,
            padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
            iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
            color: customColors.primary,
            textStyle: customTextStyle.titleSmall.copyWith(
              color: Colors.white,
            ),
            borderSide: const BorderSide(
              color: Colors.transparent,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8),
          )),
    ],
  );
}
