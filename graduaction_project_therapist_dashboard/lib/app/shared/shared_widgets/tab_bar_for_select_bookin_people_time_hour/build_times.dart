import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

import 'times_for_booking_and_search.dart';

Widget selectTimes() {
  return Wrap(
    spacing: responsiveUtil.scaleWidth(5),
    runSpacing: responsiveUtil.scaleWidth(5),
    children: [
      ...List.generate(
          9, (index) => timeElementForBookinAndSearch((index + 1).toString())),
    ],
  );
}
