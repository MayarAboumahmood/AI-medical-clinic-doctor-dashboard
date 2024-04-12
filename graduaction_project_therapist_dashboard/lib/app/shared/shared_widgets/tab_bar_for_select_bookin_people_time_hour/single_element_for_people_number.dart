import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

Widget singleElementForPeopleNumber(String number) {
  return Container(
    width: responsiveUtil.scaleWidth(50),
    height: responsiveUtil.scaleWidth(50),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
        color: customColors.secondaryBackGround,
      ),
    ),
    child: Align(
      alignment: const AlignmentDirectional(0.00, 0.00),
      child: Text(
        number,
        style: customTextStyle.bodyMedium.copyWith(
          fontSize: 16,
        ),
      ),
    ),
  );
}
