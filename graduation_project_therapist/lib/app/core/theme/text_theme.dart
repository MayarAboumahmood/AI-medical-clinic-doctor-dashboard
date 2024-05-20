// Define all sizes for texts
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_project_therapist_dashboard/app/core/constants/colors/app_colors.dart';
import '../extension/app_text_field_extension.dart';

class ThemeTypography {
  final bool isDarkTheme;
  ThemeTypography({required this.isDarkTheme});
  AppTextStylesExtension getTextStyles() {
    // Extract text styles from the textTheme
    final textTheme = this.textTheme;
   
    // Create an AppTextStylesExtension with the individual text styles
    return AppTextStylesExtension(
      displayLarge: textTheme.displayLarge!,
      displayMedium: textTheme.displayMedium!,
      displaySmall: textTheme.displaySmall!,
      headlineLarge: textTheme.headlineLarge!,
      headlineMedium: textTheme.headlineMedium!,
      headlineSmall: textTheme.headlineSmall!,
      titleLarge: textTheme.titleLarge!,
      titleMedium: textTheme.titleMedium!,
      titleSmall: textTheme.titleSmall!,
      labelLarge: textTheme.labelLarge!,
      labelMedium: textTheme.labelMedium!,
      labelSmall: textTheme.labelSmall!,
      bodyLarge: textTheme.bodyLarge!,
      bodyMedium: textTheme.bodyMedium!,
      bodySmall: textTheme.bodySmall!,
      // Add other styles as needed
    );
  }

  TextTheme get textTheme {
    // Define your text styles, possibly switching colors based on isDarkTheme
    final Color primaryColor = isDarkTheme
        ? AppColors.darkPrimaryText
        : AppColors.lightPrimaryText; // example
    // final Color info = isDarkTheme ? AppColors.info : AppColors.info; // example
    final Color secondaryColor = isDarkTheme
        ? AppColors.darkSecondaryText
        : AppColors.lightSecondaryText; // example

    return TextTheme(
      displayLarge: GoogleFonts.getFont(
        'Montserrat',
        color: primaryColor,
        fontWeight: FontWeight.normal,
        fontSize: 60,
      ),

      displayMedium: GoogleFonts.getFont(
        'Montserrat',
        color: primaryColor,
        fontWeight: FontWeight.normal,
        fontSize: 40,
      ),

      displaySmall: GoogleFonts.getFont(
        'Montserrat',
        color: primaryColor,
        fontWeight: FontWeight.w600,
        fontSize: 33,
      ),
      headlineLarge: GoogleFonts.getFont(
        'Montserrat',
        color: primaryColor,
        fontWeight: FontWeight.w600,
        fontSize: 29,
      ),
      headlineMedium: GoogleFonts.getFont(
        'Montserrat',
        color: primaryColor,
        fontWeight: FontWeight.normal,
        fontSize: 21,
      ),
      headlineSmall: GoogleFonts.getFont(
        'Montserrat',
        color: primaryColor,
        fontWeight: FontWeight.w500,
        fontSize: 21,
      ),
      titleLarge: GoogleFonts.getFont(
        'Montserrat',
        color: primaryColor,
        fontWeight: FontWeight.w500,
        fontSize: 20,
      ),
      titleMedium: GoogleFonts.getFont(
        'Montserrat',
        color: primaryColor,
        fontWeight: FontWeight.normal,
        fontSize: 16,
      ),
      titleSmall: GoogleFonts.getFont(
        'Montserrat',
        color: primaryColor,
        fontWeight: FontWeight.w500,
        fontSize: 14,
      ),
      labelLarge: GoogleFonts.getFont(
        'Montserrat',
        color: secondaryColor,
        fontWeight: FontWeight.w600,
        fontSize: 14,
      ),
      labelMedium: GoogleFonts.getFont(
        'Montserrat',
        color: secondaryColor,
        fontWeight: FontWeight.normal,
        fontSize: 13,
      ),
      labelSmall: GoogleFonts.getFont('Montserrat',
          color: secondaryColor, fontWeight: FontWeight.normal, fontSize: 11),
      bodyLarge: GoogleFonts.getFont(
        'Montserrat',
        color: primaryColor,
        fontWeight: FontWeight.w600,
        fontSize: 15.0,
      ),
      bodyMedium: GoogleFonts.getFont(
        'Montserrat',
        color: primaryColor,
        fontWeight: FontWeight.normal,
        fontSize: 13.0,
      ),
      bodySmall: GoogleFonts.getFont(
        'Montserrat',
        color: primaryColor,
        fontWeight: FontWeight.normal,
        fontSize: 11.0,
      ),

      // other text styles...
      // headline2, headline3, bodyText1, bodyText2, etc.
    );
  }
}
