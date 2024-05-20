import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/dialog_snackbar_pop_up/terms_of_use_bottom_sheet.dart';

import '../../../../../../main.dart';

Widget buildTermPrivacy(
    bool isChecked, VoidCallback toggleCheckbox, BuildContext context) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            GestureDetector(
              onTap: () {
                termOfUseBottomSheet(context);
              },
              child: Text(
                "Terms of Use".tr(),
                style: customTextStyle.bodyMedium
                    .copyWith(fontSize: 12, color: customColors.primaryText),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
              child: Icon(
                Icons.arrow_right_alt_outlined,
                color: customColors.secondaryText,
                size: 24,
              ),
            ),
            const Spacer(),
            Checkbox(
              value: isChecked, onChanged: (value) => toggleCheckbox(),
              activeColor: customColors.primary,
              side: BorderSide(
                  color: customColors.text2,
                  width:
                      2), // Custom border color and width for unchecked state
            ),
            const SizedBox(
              width: 15,
            )
          ],
        ),
      ),
    ],
  );
}
