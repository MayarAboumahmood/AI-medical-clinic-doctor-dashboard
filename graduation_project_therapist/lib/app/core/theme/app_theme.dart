import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/app/core/theme/text_theme.dart';
import '../constants/colors/app_colors.dart';
import '../extension/app_color_extension.dart';

class AppTheme {
  static final light = ThemeData.light().copyWith(
    extensions: [
      _lightAppColors,
      _lightTextStyles,
    ],
  );
  static final _lightTextStyles = ThemeTypography(isDarkTheme: false)
      .getTextStyles(); // Use light text styles

  static final _lightAppColors = AppColorsExtension(
      alternate: AppColors.lightAlternate,
      darkerShadow: AppColors.darkerShadow,
      textSpam: AppColors.textSpam,
      dropDownColor: AppColors.lightdropDownColor,
      accent4: AppColors.lightAccent4,
      primaryBackGround: AppColors.lightPrimaryBackGround,
      secondaryBackGround: AppColors.lightSecondaryBackGround,
      primary: AppColors.lightPrimary,
      secondary: AppColors.lightSecondary,
      tertiary: AppColors.lightTertiary,
      accent1: AppColors.lightAccent1,
      accent2: AppColors.lightAccent2,
      accent3: AppColors.lightAccent3,
      success: AppColors.lightSuccess,
      error: AppColors.lightError,
      warning: AppColors.lightWarning,
      primaryText: AppColors.lightPrimaryText,
      secondaryText: AppColors.lightSecondaryText,
      info: AppColors.info,
      shadow: AppColors.shadow,
      rejected: AppColors.lightRejected,
      delete: AppColors.lightDelete,
      revoke: AppColors.lightRevoke,
      cancelled: AppColors.lightCancelled,
      completeded: AppColors.lightCompleteded,
      pending: AppColors.lightPending,
      paid: AppColors.lightPaid,
      seeDetailes: AppColors.lightSeeDetailes,
      text1: AppColors.lightText1,
      text2: AppColors.lightText2,
      favourite: AppColors.lightFavourite,
      favouriteOutline: AppColors.lightFavouriteOutline,
      couponBackGround: AppColors.lightCouponBackGround);

  static final dark = ThemeData.light().copyWith(
    extensions: [
      _darkAppColors,
      _darkTextStyles, // Add your text styles here
    ],
  );
  static final _darkTextStyles = ThemeTypography(isDarkTheme: true)
      .getTextStyles(); // Use light text styles

  static final _darkAppColors = AppColorsExtension(
      dropDownColor: AppColors.darkdropDownColor,
      accent4: AppColors.darkAccent4,
      alternate: AppColors.darkAlternate,
      textSpam: AppColors.textSpam,
      darkerShadow: AppColors.darkerShadow,
      primaryBackGround: AppColors.darkPrimaryBackGround,
      secondaryBackGround: AppColors.darkSecondaryBackGround,
      primary: AppColors.darkPrimary,
      secondary: AppColors.darkSecondary,
      tertiary: AppColors.darkTertiary,
      accent1: AppColors.darkAccent1,
      accent2: AppColors.darkAccent2,
      accent3: AppColors.darkAccent3,
      success: AppColors.darkSuccess,
      error: AppColors.darkError,
      warning: AppColors.darkWarning,
      primaryText: AppColors.darkPrimaryText,
      secondaryText: AppColors.darkSecondaryText,
      info: AppColors.info,
      shadow: AppColors.shadow,
      rejected: AppColors.darkRejected,
      delete: AppColors.darkDelete,
      revoke: AppColors.darkRevoke,
      cancelled: AppColors.darkCancelled,
      completeded: AppColors.darkCompleteded,
      pending: AppColors.darkPending,
      paid: AppColors.darkPaid,
      seeDetailes: AppColors.darkSeeDetailes,
      text1: AppColors.darkText1,
      text2: AppColors.darkText2,
      favourite: AppColors.darkFavourite,
      favouriteOutline: AppColors.darkFavouriteOutline,
      couponBackGround: AppColors.darkCouponBackGround);
}
