import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/core/injection/app_injection.dart';
import 'package:graduation_project_therapist_dashboard/app/core/theme/app_theme.dart';
import 'package:graduation_project_therapist_dashboard/app/features/bottom_navigation_bar/bloc/bottom_navigation_widget_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_blocs/theme_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_functions/check_if_rtl.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

Widget accountAndThemeWidgetForEditProfile(BuildContext context) {
  BottomNavigationWidgetBloc bottomNavigationWidgetBloc =
      sl.get<BottomNavigationWidgetBloc>();

  return BlocBuilder<ThemeBloc, ThemeData>(builder: (context, themeData) {
    bool isDarkMode = themeData == AppTheme.dark;
    final controller = ValueNotifier<bool>(isDarkMode);

    controller.addListener(() {
      if (controller.value != isDarkMode) {
        BlocProvider.of<ThemeBloc>(context).add(ThemeChanged(
            themeMode: controller.value ? ThemeMode.dark : ThemeMode.light));
        jumpToIndexZero(bottomNavigationWidgetBloc);
      } else {
        BlocProvider.of<ThemeBloc>(context)
            .add(ThemeChanged(themeMode: ThemeMode.light));
        jumpToIndexZero(bottomNavigationWidgetBloc);
      }
    });
    return Container(
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: 70,
              color: const Color(0xFC000000),
              offset: Offset(0, responsiveUtil.screenHeight / 1.1),
              spreadRadius: 100,
            )
          ],
          color: customColors.primaryBackGround,
          border: Border.all(color: customColors.secondaryBackGround),
          borderRadius: BorderRadius.circular(12)),
      width: responsiveUtil.screenWidth,
      height: 50,
      padding: responsiveUtil.padding(0, 15, 0, 15),
      child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              width: responsiveUtil.scaleWidth(5),
            ),
            Icon(
              Icons.nightlight_outlined,
              color: customColors.secondaryText,
              size: 24,
            ),
            SizedBox(
              width: responsiveUtil.scaleWidth(5),
            ),
            Text("Theme".tr(), style: customTextStyle.bodySmall),
            const Spacer(),
            themeSwitcher(controller, isDarkMode, context),
            SizedBox(
              width: responsiveUtil.scaleWidth(5),
            ),
          ]),
    );
  });
}

Future<void> jumpToIndexZero(
    BottomNavigationWidgetBloc bottomNavigationWidgetBloc) {
  return Future.delayed(const Duration(milliseconds: 200), () {
    bottomNavigationWidgetBloc.add(const ChangeCurrentPage(nextIndex: 0));
  });
}

AdvancedSwitch themeSwitcher(
    ValueNotifier<bool> controller, bool isDarkMode, BuildContext context) {
  return AdvancedSwitch(
    borderRadius: const BorderRadius.vertical(
        top: Radius.elliptical(30, 30), bottom: Radius.elliptical(30, 30)),
    thumb: Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration:
          BoxDecoration(color: customColors.primary, shape: BoxShape.circle),
    ),
    height: 45,
    width: 70,
    controller: controller,
    activeChild: isDarkMode
        ? darkModeIcon(isDarkMode, context)
        : lightModeIcon(isDarkMode, context),
    inactiveChild: !isDarkMode
        ? lightModeIcon(isDarkMode, context)
        : darkModeIcon(isDarkMode, context),

    activeColor: customColors.secondaryBackGround,
    //the background color of the moon
    inactiveColor: customColors.secondaryBackGround,
    //the background color of the sun
  );
}

Widget lightModeIcon(bool isDarkMode, BuildContext context) {
  return !isDarkMode
      ? Padding(
          padding: isRTL(context)
              ? const EdgeInsets.only(left: 70)
              : const EdgeInsets.only(right: 15),
          child: Icon(
            color: customColors.secondaryText,
            Icons.wb_sunny_rounded,
            size: 20,
          ),
        )
      : const SizedBox();
}

Widget darkModeIcon(bool isDarkMode, BuildContext context) {
  return isDarkMode
      ? Padding(
          padding: isRTL(context)
              ? const EdgeInsets.only(right: 5)
              : const EdgeInsets.only(right: 5),
          child: Icon(
            color: customColors.secondaryText,
            Icons.nightlight_round_outlined,
            size: 20,
          ),
        )
      : const SizedBox();
}
