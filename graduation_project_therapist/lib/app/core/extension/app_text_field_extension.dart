import 'dart:ui';

import 'package:flutter/material.dart';

class AppTextStylesExtension extends ThemeExtension<AppTextStylesExtension> {
  // Define individual text styles as properties
  final TextStyle displayLarge;
  final TextStyle displayMedium;
  final TextStyle displaySmall;
  final TextStyle headlineLarge;
  final TextStyle headlineMedium;
  final TextStyle headlineSmall;
  final TextStyle titleLarge;
  final TextStyle titleMedium;
  final TextStyle titleSmall;
  final TextStyle labelLarge;
  final TextStyle labelMedium;
  final TextStyle labelSmall;
  final TextStyle bodyLarge;
  final TextStyle bodyMedium;
  final TextStyle bodySmall;
  // Add other styles as needed

  AppTextStylesExtension({
    required this.displayLarge,
    required this.displayMedium,
    required this.displaySmall,
    required this.headlineLarge,
    required this.headlineMedium,
    required this.headlineSmall,
    required this.titleLarge,
    required this.titleMedium,
    required this.titleSmall,
    required this.labelLarge,
    required this.labelMedium,
    required this.labelSmall,
    required this.bodyLarge,
    required this.bodyMedium,
    required this.bodySmall,
    // Other styles in the constructor as needed
  });

  @override
  ThemeExtension<AppTextStylesExtension> copyWith({
    TextStyle? displayLarge,
    TextStyle? displayMedium,
    TextStyle? displaySmall,
    TextStyle? headlineLarge,
    TextStyle? headlineMedium,
    TextStyle? headlineSmall,
    TextStyle? titleLarge,
    TextStyle? titleMedium,
    TextStyle? titleSmall,
    TextStyle? labelLarge,
    TextStyle? labelMedium,
    TextStyle? labelSmall,
    TextStyle? bodyLarge,
    TextStyle? bodyMedium,
    TextStyle? bodySmall,
    // Other styles in the copyWith method as needed
  }) {
    return AppTextStylesExtension(
      displayLarge: displayLarge ?? this.displayLarge,
      displayMedium: displayMedium ?? this.displayMedium,
      displaySmall: displaySmall ?? this.displaySmall,
      headlineLarge: headlineLarge ?? this.headlineLarge,
      headlineMedium: headlineMedium ?? this.headlineMedium,
      headlineSmall: headlineSmall ?? this.headlineSmall,
      titleLarge: titleLarge ?? this.titleLarge,
      titleMedium: titleMedium ?? this.titleMedium,
      titleSmall: titleSmall ?? this.titleSmall,
      labelLarge: labelLarge ?? this.labelLarge,
      labelMedium: labelMedium ?? this.labelMedium,
      labelSmall: labelSmall ?? this.labelSmall,
      bodyLarge: bodyLarge ?? this.bodyLarge,
      bodyMedium: bodyMedium ?? this.bodyMedium,
      bodySmall: bodySmall ?? this.bodySmall,
      // Other styles in the return statement as needed
    );
  }

  @override
  ThemeExtension<AppTextStylesExtension> lerp(
      covariant ThemeExtension<AppTextStylesExtension>? other, double t) {
    if (other is! AppTextStylesExtension) {
      return this; // if other isn't AppTextStylesExtension, return current instance
    }

    // Cast other to AppTextStylesExtension for easier access to its properties
    final otherStyles = other;

    // Helper method to interpolate TextStyles
    TextStyle lerpTextStyle(TextStyle style1, TextStyle style2, double t) {
      return TextStyle(
        fontSize: lerpDouble(style1.fontSize, style2.fontSize, t),
        color: Color.lerp(style1.color, style2.color, t),
        // Add other TextStyle properties to interpolate as needed
      );
    }

    // Interpolate between the current and other text styles based on t
    return AppTextStylesExtension(
      displayLarge: lerpTextStyle(displayLarge, otherStyles.displayLarge, t),
      displayMedium: lerpTextStyle(displayMedium, otherStyles.displayMedium, t),
      displaySmall: lerpTextStyle(displaySmall, otherStyles.displaySmall, t),
      headlineLarge: lerpTextStyle(headlineLarge, otherStyles.headlineLarge, t),
      headlineMedium:
          lerpTextStyle(headlineMedium, otherStyles.headlineMedium, t),
      headlineSmall: lerpTextStyle(headlineSmall, otherStyles.headlineSmall, t),
      titleLarge: lerpTextStyle(titleLarge, otherStyles.titleLarge, t),
      titleMedium: lerpTextStyle(titleMedium, otherStyles.titleMedium, t),
      titleSmall: lerpTextStyle(titleSmall, otherStyles.titleSmall, t),
      labelLarge: lerpTextStyle(labelLarge, otherStyles.labelLarge, t),
      labelMedium: lerpTextStyle(labelMedium, otherStyles.labelMedium, t),
      labelSmall: lerpTextStyle(labelSmall, otherStyles.labelSmall, t),
      bodyLarge: lerpTextStyle(bodyLarge, otherStyles.bodyLarge, t),
      bodyMedium: lerpTextStyle(bodyMedium, otherStyles.bodyMedium, t),
      bodySmall: lerpTextStyle(bodySmall, otherStyles.bodySmall, t),
      // Other styles in the return statement as needed
    );
  }
}
