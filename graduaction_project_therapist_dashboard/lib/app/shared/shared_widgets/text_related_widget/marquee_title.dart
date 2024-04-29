import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';
import 'package:marquee/marquee.dart';

Widget marqueeTitle(
  // BuildContext context,
  String? title, {
  String? fontFamily = 'Readex Pro',
  int titleMaxLength = 60,
  double? widthFromTheScreen,
  double? heigthFromTheScreen,
  double? fontSize,
  FontWeight fontWeight = FontWeight.w700,
}) {
  if (title == null) {
    return const SizedBox();
  }
  // widthFromTheScreen=title.length*10;
  return SizedBox(
    width: widthFromTheScreen ??
        (responsiveUtil.screenWidth < 290
            ? responsiveUtil.screenWidth * 0.05
            : responsiveUtil.screenWidth < 330
                ? responsiveUtil.screenWidth * 0.3
                : responsiveUtil.screenWidth < 380
                    ? responsiveUtil.screenWidth * 0.35
                    : responsiveUtil.screenWidth * 0.39),
    height: heigthFromTheScreen ?? 26,
    child: title.length > titleMaxLength
        ? Center(
            child: Marquee(
              text: title.tr(),
              // textDirection:
              //     isRTL(context) ? TextDirection.rtl : TextDirection.ltr,
              scrollAxis: Axis.horizontal,
              blankSpace: 20.0,
              velocity: 70.0,
              pauseAfterRound: const Duration(seconds: 3),
              style: customTextStyle.titleMedium.copyWith(
                  color: customColors.text2,
                  fontFamily: fontFamily,
                  fontSize: fontSize,
                  fontWeight: fontWeight),
            ),
          )
        : Text(
            title.tr(),
            maxLines: 1,
            style: customTextStyle.titleMedium.copyWith(
                color: customColors.text2,
                fontSize: fontSize,
                fontFamily: fontFamily,
                overflow: TextOverflow.ellipsis,
                fontWeight: fontWeight),
          ),
  );
}

Widget marqueeNormalText(String title, Color? textColor,
    {String? fontFamily = 'Readex Pro',
    int titleMaxLength = 60,
    double heigthFromTheScreen = 24,
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.w400,
    double widthFromTheScreen = 0.3}) {
  return title.length > titleMaxLength
      ? SizedBox(
          width: responsiveUtil.screenWidth * widthFromTheScreen,
          height: heigthFromTheScreen,
          child: Marquee(
            text: title.tr(),
            scrollAxis: Axis.horizontal,
            blankSpace: 20.0,
            velocity: 70.0,
            pauseAfterRound: const Duration(seconds: 3),
            style: customTextStyle.bodyMedium.copyWith(
                color: textColor ?? customColors.secondaryText,
                fontFamily: fontFamily,
                fontSize: fontSize,
                fontWeight: fontWeight),
          ),
        )
      : SizedBox(
          width: responsiveUtil.screenWidth * widthFromTheScreen,
          child: Text(
            title.tr(),
            maxLines: 1,
            // overflow: TextOverflow.ellipsis,
            style: customTextStyle.bodyMedium.copyWith(
                color: textColor ?? customColors.secondaryText,
                fontSize: fontSize,
                fontFamily: fontFamily,
                fontWeight: fontWeight),
          ),
        );
}

Widget marqueefixedWidthText(String title,
    {String? fontFamily = 'Readex Pro',
    Color? textColor,
    int titleMaxLength = 7,
    double heigthFromTheScreen = 22,
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.w400,
    double widthFromTheScreen = 50}) {
  return SizedBox(
    width: widthFromTheScreen,
    height: heigthFromTheScreen,
    child: title.length > titleMaxLength
        ? Marquee(
            text: title.tr(),
            scrollAxis: Axis.horizontal,
            blankSpace: 20.0,
            velocity: 70.0,
            pauseAfterRound: const Duration(seconds: 3),
            style: customTextStyle.bodyMedium.copyWith(
                color: textColor ?? customColors.secondaryText,
                fontFamily: fontFamily,
                fontSize: fontSize,
                fontWeight: fontWeight),
          )
        : Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Text(
                title.tr(),
                maxLines: 1,
                overflow: TextOverflow.visible,
                style: customTextStyle.bodyMedium.copyWith(
                    color: textColor ?? customColors.secondaryText,
                    fontSize: fontSize,
                    fontFamily: fontFamily,
                    fontWeight: fontWeight),
              ),
            ),
          ),
  );
}
