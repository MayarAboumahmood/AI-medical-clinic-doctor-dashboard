import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../../../../main.dart';

Widget buildAppBar(double percent) {
  return Padding(
    padding: const EdgeInsetsDirectional.fromSTEB(24, 100, 24, 0),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          child: Icon(
            Icons.arrow_back_ios_rounded,
            color: customColors.primaryText,
            size: 24,
          ),
          onTap: () async {},
        ),
        const SizedBox(
          width: 100,
        ),
        LinearPercentIndicator(
          percent: percent,
          width: 120,
          lineHeight: 8,
          animation: true,
          animateFromLastPercent: true,
          progressColor: customColors.primary,
          backgroundColor: customColors.secondaryBackGround,
          barRadius: const Radius.circular(12),
          padding: EdgeInsets.zero,
        ),
      ],
    ),
  );
}

bool ifThereActionInAppBar(int pageNumber) {
      return false;
  // switch (pageNumber) {
  //   case 1 || 2 || 4:

  //   case 3 || 5 || 7:
  //     return true;
  //   default:
  //     return false;
  // }
}

AppBar buildAppBarWithLineIndicatorincenter(
    int pageNumber, BuildContext context) {
  double percent = (pageNumber / 4);
  return AppBar(
    surfaceTintColor: customColors.primaryBackGround,
    title: Center(
      child: LinearPercentIndicator(
        alignment: MainAxisAlignment.center,
        percent: percent,
        width: responsiveUtil.scaleWidth(150),
        lineHeight: 8,
        animation: true,
        animateFromLastPercent: true,
        progressColor: customColors.primary,
        backgroundColor: customColors.secondaryBackGround,
        barRadius: const Radius.circular(12),
        // padding: EdgeInsets  .zero,
      ),
    ),
    centerTitle: true,
    actions: [
      ifThereActionInAppBar(pageNumber)
          ? TextButton(
              onPressed: () {
                navigationService.navigateTo('/step${pageNumber + 1}');
              },
              child: Text("Skip".tr(), style: customTextStyle.bodyLarge))
          : TextButton(
              onPressed: () {},
              child: Text("Skip".tr(),
                  style: customTextStyle.bodyLarge
                      .copyWith(color: customColors.primaryBackGround)))
    ],
    backgroundColor: Colors.transparent,
    leading: InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(30)),
      child: Icon(
        Icons.arrow_back_ios_rounded,
        color: customColors.primaryText,
        size: 24,
      ),
      onTap: () {
        Navigator.pop(context);
      },
    ),
  );
}
