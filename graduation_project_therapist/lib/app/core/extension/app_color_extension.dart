import 'package:flutter/material.dart';

/// for apply all propirties that exist in design
class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  final Color alternate;
  final Color accent4;
  final Color darkerShadow;
  final Color textSpam;
  final Color primaryBackGround;
  final Color secondaryBackGround;
  final Color couponBackGround;
  final Color primary;
  final Color secondary;
  final Color tertiary;
  final Color accent1;
  final Color accent2;
  final Color accent3;
  final Color success;
  final Color error;
  final Color warning;
  final Color info;
  final Color shadow;
  final Color primaryText;
  final Color secondaryText;
  final Color rejected; // Changed from darkRejected
  final Color delete; // Changed from darkDelete
  final Color revoke; // Changed from darkRevoke
  final Color cancelled; // Changed from darkCancelled
  final Color completeded; // Changed from darkCompleteded
  final Color pending; // Changed from darkPending
  final Color paid; // Changed from darkPaid
  final Color seeDetailes; // Changed from darkSeeDetailes
  final Color text1; // Changed from darkText1
  final Color text2; // Changed from darkText2
  final Color favourite; // Changed from darkFavourite
  final Color favouriteOutline;
  final Color? dropDownColor;

  AppColorsExtension(
      {required this.rejected,
      required this.delete,
      required this.textSpam,
      required this.dropDownColor,
      required this.darkerShadow,
      required this.revoke,
      required this.cancelled,
      required this.completeded,
      required this.pending,
      required this.paid,
      required this.seeDetailes,
      required this.text1,
      required this.text2,
      required this.favourite,
      required this.favouriteOutline,
      required this.alternate,
      required this.accent4,
      required this.primaryBackGround,
      required this.secondaryBackGround,
      required this.primary,
      required this.secondary,
      required this.tertiary,
      required this.accent1,
      required this.accent2,
      required this.accent3,
      required this.success,
      required this.error,
      required this.warning,
      required this.info,
      required this.primaryText,
      required this.secondaryText,
      required this.couponBackGround,
      required this.shadow});

  @override
  ThemeExtension<AppColorsExtension> copyWith({
    Color? alternate,
    Color? accent4,
    Color? primaryBackGround,
    Color? darkerShadow,
    Color? secondaryBackGround,
    Color? primary,
    Color? secondary,
    Color? tertiary,
    Color? accent1,
    Color? accent2,
    Color? accent3,
    Color? success,
    Color? error,
    Color? warning,
    Color? primaryText,
    Color? secondaryText,
    Color? info,
    Color? shadow,
    Color? rejected,
    Color? textSpam,
    Color? delete,
    Color? revoke,
    Color? cancelled,
    Color? completeded,
    Color? pending,
    Color? paid,
    Color? seeDetailes,
    Color? text1,
    Color? text2,
    Color? favourite,
    Color? favouriteOutline,
    Color? couponBackGround,
  }) {
    return AppColorsExtension(
      dropDownColor: dropDownColor ?? dropDownColor,
      accent4: accent4 ?? this.accent4,
      textSpam: textSpam ?? this.textSpam,
      darkerShadow: darkerShadow ?? this.darkerShadow,
      alternate: alternate ?? this.alternate,
      primaryBackGround: primaryBackGround ?? this.primaryBackGround,
      secondaryBackGround: secondaryBackGround ?? this.secondaryBackGround,
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      tertiary: tertiary ?? this.tertiary,
      accent1: accent1 ?? this.accent1,
      accent2: accent2 ?? this.accent2,
      accent3: accent3 ?? this.accent3,
      success: success ?? this.success,
      error: error ?? this.error,
      warning: warning ?? this.warning,
      primaryText: primaryText ?? this.primaryText,
      secondaryText: secondaryText ?? this.secondaryText,
      info: info ?? this.info,
      shadow: shadow ?? this.shadow,
      rejected: rejected ?? this.rejected,
      delete: delete ?? this.delete,
      revoke: revoke ?? this.revoke,
      cancelled: cancelled ?? this.cancelled,
      completeded: completeded ?? this.completeded,
      pending: pending ?? this.pending,
      paid: paid ?? this.paid,
      seeDetailes: seeDetailes ?? this.seeDetailes,
      text1: text1 ?? this.text1,
      text2: text2 ?? this.text2,
      favourite: favourite ?? this.favourite,
      favouriteOutline: favouriteOutline ?? this.favouriteOutline,
      couponBackGround: couponBackGround ?? this.couponBackGround,
    );
  }

  @override
  ThemeExtension<AppColorsExtension> lerp(
      covariant ThemeExtension<AppColorsExtension>? other, double t) {
    if (other is! AppColorsExtension) {
      return this;
    } // if other isn't AppColorsExtension, return current instance

    // Cast other to AppColorsExtension for easier access to its properties
    final otherColors = other;

    // Interpolate between the current and other theme colors based on t
    return AppColorsExtension(
      dropDownColor: Color.lerp(dropDownColor, otherColors.dropDownColor, t),
      alternate: Color.lerp(alternate, otherColors.alternate, t)!,
      accent4: Color.lerp(accent4, otherColors.accent4, t)!,
      primaryBackGround:
          Color.lerp(primaryBackGround, otherColors.primaryBackGround, t)!,
      secondaryBackGround:
          Color.lerp(secondaryBackGround, otherColors.secondaryBackGround, t)!,
      primary: Color.lerp(primary, otherColors.primary, t)!,
      textSpam: Color.lerp(textSpam, otherColors.textSpam, t)!,
      secondary: Color.lerp(secondary, otherColors.secondary, t)!,
      tertiary: Color.lerp(tertiary, otherColors.tertiary, t)!,
      darkerShadow: Color.lerp(darkerShadow, otherColors.darkerShadow, t)!,
      accent1: Color.lerp(accent1, otherColors.accent1, t)!,
      accent2: Color.lerp(accent2, otherColors.accent2, t)!,
      accent3: Color.lerp(accent3, otherColors.accent3, t)!,
      success: Color.lerp(success, otherColors.success, t)!,
      error: Color.lerp(error, otherColors.error, t)!,
      warning: Color.lerp(warning, otherColors.warning, t)!,
      primaryText: Color.lerp(primaryText, otherColors.primaryText, t)!,
      secondaryText: Color.lerp(secondaryText, otherColors.secondaryText, t)!,
      info: Color.lerp(info, otherColors.info, t)!,
      shadow: Color.lerp(shadow, otherColors.shadow, t)!,
      rejected: Color.lerp(rejected, otherColors.rejected, t)!,
      delete: Color.lerp(delete, otherColors.delete, t)!,
      revoke: Color.lerp(revoke, otherColors.revoke, t)!,
      cancelled: Color.lerp(cancelled, otherColors.cancelled, t)!,
      completeded: Color.lerp(completeded, otherColors.completeded, t)!,
      pending: Color.lerp(pending, otherColors.pending, t)!,
      paid: Color.lerp(paid, otherColors.paid, t)!,
      seeDetailes: Color.lerp(seeDetailes, otherColors.seeDetailes, t)!,
      text1: Color.lerp(text1, otherColors.text1, t)!,
      text2: Color.lerp(text2, otherColors.text2, t)!,
      favourite: Color.lerp(favourite, otherColors.favourite, t)!,
      couponBackGround:
          Color.lerp(couponBackGround, otherColors.couponBackGround, t)!,
      favouriteOutline:
          Color.lerp(favouriteOutline, otherColors.favouriteOutline, t)!,
    );
  }
}
