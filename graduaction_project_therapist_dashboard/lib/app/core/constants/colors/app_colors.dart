// lib/app/core/constants/colors.dart
import 'package:flutter/material.dart';

abstract class AppColors {
  // Light Mode

  // static const lightMoonSunTheme = Color(0xff4b644a);
  static const lightPrimary = Color.fromARGB(255, 25, 93, 219);
  static const lightSecondary = Color(0xffd8334a);
  static const lightTertiary = Color(0xfff3e9dc);
  static const lightAlternate = Color(0xffff8c42);
  // static const lightPrimaryText = Color(0xff4b644a);
  static const lightPrimaryText = Color.fromARGB(255, 11, 12, 12);
  static const lightSecondaryText = Color(0xff333333); //for the sun
  static const lightPrimaryBackGround = Color(0xffFFFFFF);
  static const lightCouponBackGround = Color.fromARGB(255, 129, 133, 138);
  static const lightSecondaryBackGround = Color(0xfff1f4f8);
  static const lightAccent1 = Color(0xffffc045);
  static const lightAccent2 = Color(0xff36B4FF);
  static const lightAccent3 = Color(0xffa280ad);
  static const lightAccent4 = Color(0xffFF6F61);
  static const lightSuccess = Color(0xff4C8A64);
  static const lightError = Color(0xffc0392b);
  static const lightWarning = Color(0xffffc107);
  static const lightRejected = Color(0xff9D303A);
  static const lightDelete = Color(0xffA33A50);
  static const lightRevoke = Color(0xff696072);
  static const lightCancelled = Color(0xff56567B);
  static const lightdropDownColor = Color.fromARGB(255, 209, 211, 211);
  static const lightCompleteded = Color.fromARGB(75, 63, 102, 138);
  static const lightPending = Color(0xffB3A06E);
  static const lightPaid = Color.fromARGB(255, 60, 82, 122);
  static const lightSeeDetailes = Color(0xff7A7B83);
  static const lightText1 = Color(0xffB5F5E8);
  static const lightText2 = Color.fromARGB(255, 11, 12, 12);
  static const lightFavourite = Color(0xffb22222);
  static const lightFavouriteOutline = Color(0xffffc0cb);

  // Dark Mode
  static const darkPrimary = Color.fromARGB(255, 25, 93, 219); //0xff5f7760
  static const darkSecondary = Color(0xffb83030);
  static const darkTertiary = Color(0xff5d2e46);
  static const darkAlternate = Color(0xffff9747);
  // static const darkPrimaryText = Color(0xff5f7760); //#4b644a
  static const darkPrimaryText = Color(0xffE8E8E8); //#4b644a
  static const darkSecondaryText =
      Color.fromARGB(255, 139, 138, 138); //for the moon
  static const darkPrimaryBackGround = Color(0xff1d2429);
  static const darkCouponBackGround = Color.fromARGB(255, 27, 27, 27);
  static const darkSecondaryBackGround = Color(0xff14181b);
  static const darkdropDownColor = Color.fromARGB(255, 209, 211, 211);

  static const darkAccent1 = Color(0x4C4B39EF);
  static const darkAccent2 = Color(0xff36B4FF);
  static const darkAccent3 = Color(0x4DEE8B60);
  static const darkAccent4 = Color.fromRGBO(38, 45, 52, 0.698);
  static const darkSuccess = Color(0xff3C7A54);
  static const darkError = Color(0xffFF5963);
  static const darkWarning = Color(0xffFFC045);
  static const darkRejected = Color(0xff9D303A);
  static const darkDelete = Color(0xffA33A50);
  static const darkRevoke = Color(0xff696072);
  static const darkCancelled = Color(0xff56567B);
  static const darkCompleteded = Color.fromARGB(64, 101, 100, 104);
  static const darkPending = Color(0xffB3A06E);
  static const darkPaid = Color.fromARGB(255, 64, 60, 122);
  static const darkSeeDetailes = Color.fromARGB(43, 122, 123, 131);
  static const darkText1 = Color(0xffB5F5E8);
  static const darkText2 = Color.fromARGB(255, 243, 243, 243);
  static const darkFavourite = Color(0xffFF6347);
  static const darkFavouriteOutline = Color(0xff800000);

  // Shared colors (common for both themes)
  static const info = Color(0xffFFFFFF);
  // shdow colors
  static const shadow = Color.fromARGB(48, 0, 0, 0);
  static const darkerShadow = Color.fromARGB(155, 0, 0, 0);
  // text span
  static const textSpam = Color(0xFF36B4FF);
}
