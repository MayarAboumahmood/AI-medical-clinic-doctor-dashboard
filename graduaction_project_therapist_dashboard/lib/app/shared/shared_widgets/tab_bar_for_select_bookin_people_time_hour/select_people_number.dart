import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

import 'single_element_for_people_number.dart';

Widget selectPeopleNumber() {
  return Wrap(
    spacing: responsiveUtil.scaleWidth(5),
    runSpacing: responsiveUtil.scaleWidth(5),
    children: [
      ...List.generate(
          9, (index) => singleElementForPeopleNumber((index + 1).toString())),
    ],
  );
}
