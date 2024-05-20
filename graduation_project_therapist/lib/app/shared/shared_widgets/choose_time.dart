import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/buttons/button_with_options.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

Future buildChooseTime(
  BuildContext context,
  String time,
  void Function(String time) onPressed,
) {
  DateTime initialDateTime;
  try {
    // Fallback to 12-hour format if the first parse fails
    initialDateTime = DateFormat('hh:mm a').parse(time,true);
  } catch (e) {
    print('first error assigning the time: $e');
    try {
      // Try parsing assuming a 24-hour format first
      initialDateTime = DateFormat('HH:mm').parse(time);
    } catch (e) {
      // If both fail, log an error or handle gracefully
      print("Error parsing time: $e");
      // Fallback to current time or handle as needed
      initialDateTime = DateTime.now();
    }
  }

  return showCupertinoModalPopup(
    context: context,
    builder: (_) => Container(
      padding: const EdgeInsets.fromLTRB(10, 0, 20, 0),
      height: 300,
      decoration: BoxDecoration(
        color: customColors.secondaryBackGround,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 200,
            child: CupertinoTheme(
              data: CupertinoThemeData(
                textTheme: CupertinoTextThemeData(
                  dateTimePickerTextStyle: TextStyle(
                    color: customColors.primary,
                    fontSize: 20,
                  ),
                  pickerTextStyle: TextStyle(
                    color: customColors.secondaryBackGround,
                  ),
                ),
              ),
              child: CupertinoDatePicker(
                initialDateTime: initialDateTime,
                mode: CupertinoDatePickerMode.time,
                onDateTimeChanged: (val) {
                  initialDateTime = val;
                },
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GeneralButtonOptions(
                options: ButtonOptions(
                  padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                  color: customColors.secondaryBackGround,
                  textStyle: customTextStyle.titleSmall.copyWith(
                    fontFamily: 'BeerSerif',
                    color: customColors.primaryText,
                    fontSize: 14,
                  ),
                  borderSide: BorderSide(
                    color: customColors.primary,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                text: 'Cancel'.tr(),
              ),
              GeneralButtonOptions(
                options: ButtonOptions(
                  // width: 120,
                  // height: 45,
                  padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),

                  color: customColors.primary,
                  textStyle: customTextStyle.titleSmall.copyWith(
                    fontFamily: 'BeerSerif',
                    color: customColors.info,
                    fontSize: 14,
                  ),
                  borderSide: BorderSide(
                    color: customColors.primary,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                text: 'Done'.tr(),
                onPressed: () =>
                    onPressed(DateFormat('hh:mm a').format(initialDateTime)),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    ),
  );
}
