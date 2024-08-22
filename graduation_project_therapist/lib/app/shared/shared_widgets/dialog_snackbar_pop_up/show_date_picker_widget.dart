import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/buttons/button_with_options.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/dialog_snackbar_pop_up/custom_snackbar.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

Future buildChooseDate(BuildContext context, DateTime dateTime,
    dynamic Function(DateTime) onPressed, DatePickType datePickType) {
  DateTime localDateTime = dateTime;
  bool canPickDate = true;
  late DateTime minDate;
  late DateTime maxDate;
  int snackBarCounter = 0;
  if (datePickType == DatePickType.reservationDay) {
    minDate = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );

    maxDate = DateTime(
      DateTime.now().month == 12
          ? DateTime.now().year + 1
          : DateTime.now().year,
      DateTime.now().month + 1,
      DateTime.now().day,
    );
  } else if (datePickType == DatePickType.birthDay) {
    minDate = DateTime(
      DateTime.now().year - 70,
      DateTime.now().month,
      DateTime.now().day,
    );

    maxDate = DateTime(
      DateTime.now().year - 18,
      DateTime.now().month,
      DateTime.now().day,
    );
  } else {
    minDate = DateTime(
      DateTime.now().year - 70,
      DateTime.now().month,
      DateTime.now().day,
    );

    maxDate = DateTime(
      DateTime.now().month + 70,
      DateTime.now().month,
      DateTime.now().day,
    );
  }
  return showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
            padding: responsiveUtil.padding(10, 0, 20, 0),
            height: 350,
            decoration: BoxDecoration(
              color: customColors.secondaryBackGround,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0),
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Scaffold(
              backgroundColor: customColors.secondaryBackGround,
              body: Container(
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
                                color: customColors.secondaryText,
                                fontSize: 20),
                            pickerTextStyle:
                                TextStyle(color: customColors.secondaryText),
                          ),
                        ),
                        child: CupertinoDatePicker(
                          initialDateTime: DateTime.now(),
                          mode: CupertinoDatePickerMode.date,
                          dateOrder: DatePickerDateOrder.dmy,
                          onDateTimeChanged: (val) {
                            if (val.isBefore(minDate)) {
                              canPickDate = false;
                              snackBarCounter++;
                              if (snackBarCounter == 0 ||
                                  snackBarCounter % 3 == 0) {
                                customSnackBar(
                                    'Please select a date after ${minDate.toLocal().toString().split(' ')[0]}',
                                    context,
                                    isFloating: true);
                              }
                              val = DateTime.now();
                            } else if (val.isAfter(maxDate)) {
                              canPickDate = false;
                              snackBarCounter++;
                              if (snackBarCounter == 0 ||
                                  snackBarCounter % 3 == 0) {
                                customSnackBar(
                                    'Please select a date before ${maxDate.toLocal().toString().split(' ')[0]}',
                                    context,
                                    isFloating: true);
                              }
                              val = DateTime.now();
                            } else {
                              canPickDate = true;
                              localDateTime = val;
                            }
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
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                20, 0, 20, 0),
                            iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                0, 0, 0, 0),
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
                          onPressed: () {
                            if (canPickDate) {
                              onPressed(localDateTime);
                            } else {
                              customSnackBar("can't pick this date", context,
                                  isFloating: true);
                            }
                          },
                          text: tr("Done"),
                          options: ButtonOptions(
                            width: 120,
                            height: 45,
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                20, 0, 20, 0),
                            iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                0, 0, 0, 0),
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
              ),
            ),
          ));
}

enum DatePickType {
  birthDay,
  reservationDay,
  nothing,
}
