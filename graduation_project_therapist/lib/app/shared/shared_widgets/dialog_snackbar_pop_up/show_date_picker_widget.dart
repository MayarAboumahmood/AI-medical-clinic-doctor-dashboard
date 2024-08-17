import 'package:flutter/cupertino.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/buttons/button_with_options.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';
import 'package:easy_localization/easy_localization.dart';

Future buildChooseDate(BuildContext context, DateTime dateTime,
    dynamic Function(DateTime) onPressed) {
  DateTime localDateTime = dateTime;

  return showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
            padding: responsiveUtil.padding(10, 0, 20, 0),
            height: 300,
            decoration: BoxDecoration(
              color: customColors.secondaryBackGround,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0),
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
                            color: customColors.secondaryText, fontSize: 20),
                        pickerTextStyle:
                            TextStyle(color: customColors.secondaryText),
                      ),
                    ),
                    child: StatefulBuilder(
                      builder: (context, setState) {
                        int correctMonth = localDateTime.month;

                        return CupertinoDatePicker(
                          initialDateTime: localDateTime,
                          mode: CupertinoDatePickerMode.date,
                          onDateTimeChanged: (val) {
                            // Ensure the year remains unchanged
                            //   if (val.year != localDateTime.year) {
                            //     val = DateTime(
                            //         localDateTime.year, val.month, val.day);
                            //   }
                            //   int monthDifference =
                            //       val.month - localDateTime.month;

                            //   if (monthDifference == 1 ||
                            //       monthDifference == -1 ||
                            //       monthDifference == 0) {
                            //     setState(() {
                            //       localDateTime = val;
                            //     });
                            //   } else {
                            //     // Correct the month if it's out of bounds
                            //     if (monthDifference > 1) {
                            //       correctMonth += 1;
                            //     } else if (monthDifference < -1) {
                            //       correctMonth -= 1;
                            //     }
                            //     setState(() {
                            //       localDateTime = DateTime(
                            //           localDateTime.year, correctMonth, val.day);
                            //     });
                            //   }
                          },
                          minimumDate: DateTime(
                              dateTime.year - 1, dateTime.month, dateTime.day),
                          maximumDate: DateTime(
                              dateTime.year, dateTime.month + 1, dateTime.day),
// ,
//                           minimumYear: dateTime.year,
//                           maximumYear: correctMonth == 12
//                               ? dateTime.year + 1
//                               : dateTime.year,
                        );
                      },
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GeneralButtonOptions(
                      loading: false,
                      onPressed: () {
                        navigationService.goBack();
                      },
                      text: tr("Cancel"),
                      options: ButtonOptions(
                        width: 120,
                        height: 45,
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                        iconPadding:
                            const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        color: customColors.secondaryBackGround,
                        textStyle: customTextStyle.titleSmall.copyWith(
                          color: customColors.primaryText,
                          fontSize: 14,
                        ),
                        borderSide: BorderSide(
                          color: customColors.primary,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    GeneralButtonOptions(
                      onPressed: () => onPressed(localDateTime),
                      text: tr("Done"),
                      options: ButtonOptions(
                        width: 120,
                        height: 45,
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                        iconPadding:
                            const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        color: customColors.primary,
                        textStyle: customTextStyle.titleSmall.copyWith(
                          color: customColors.info,
                          fontSize: 14,
                        ),
                        borderSide: BorderSide(
                          color: customColors.primary,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    )
                  ],
                )
              ],
            ),
          ));
}
