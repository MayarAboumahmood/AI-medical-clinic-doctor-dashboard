import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/buttons/button_with_options.dart';

import '../../../../main.dart';

Widget timeElementForBookinAndSearch(String index) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: responsiveUtil.scaleWidth(5)),
    child: GeneralButtonOptions(
        text: "22:$index",
        onPressed: () {},
        options: ButtonOptions(
          // height: 30,
          padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
          iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
          color: customColors.secondaryBackGround,
          textStyle: customTextStyle.titleSmall.copyWith(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w300,
          ),
          borderSide: const BorderSide(
            color: Colors.transparent,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(20),
        )),
  );
}
