import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';

Widget datePicker(){
  DateTime dateTime =DateTime.now();
return CalendarDatePicker2(
  config: CalendarDatePicker2Config(),
  value: [dateTime],
  onValueChanged: (dates) {},
);
}