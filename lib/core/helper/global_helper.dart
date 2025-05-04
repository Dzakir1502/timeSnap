import 'package:flutter/material.dart';

enum AppTextStyle {
  DISPLAY_LARGE,
  DISPLAY_MEDIUM,
  DISPLAY_SMALL,
  HEADLINE_LARGE,
  HEADLINE_MEDIUM,
  HEADLINE_SMALL,
  TITLE_LARGE,
  TITLE_MEDIUM,
  TITLE_SMALL,
  LABEL_LARGE,
  LABEL_MEDIUM,
  LABEL_SMALL,
  BODY_LARGE,
  BODY_MEDIUM,
  BODY_SMALL,
}

class GlobalHelper {
  static TextStyle? getTextStyle(
    BuildContext context, {
    AppTextStyle appTextStyle = AppTextStyle.BODY_MEDIUM,
  }) {
    final textTheme = Theme.of(context).textTheme;
    final appTextStyleMap = {
      AppTextStyle.DISPLAY_LARGE: textTheme.displayLarge?.copyWith(fontFamily: 'Poppins'),
      AppTextStyle.DISPLAY_MEDIUM: textTheme.displayMedium?.copyWith(fontFamily: 'Poppins'),
      AppTextStyle.DISPLAY_SMALL: textTheme.displaySmall?.copyWith(fontFamily: 'Poppins'),
      AppTextStyle.HEADLINE_LARGE: textTheme.headlineLarge?.copyWith(fontFamily: 'Poppins'),
      AppTextStyle.HEADLINE_MEDIUM: textTheme.headlineMedium?.copyWith(fontFamily: 'Poppins'),
      AppTextStyle.HEADLINE_SMALL: textTheme.headlineSmall?.copyWith(fontFamily: 'Poppins'),
      AppTextStyle.TITLE_LARGE: textTheme.titleLarge?.copyWith(fontFamily: 'Poppins'),
      AppTextStyle.TITLE_MEDIUM: textTheme.titleMedium?.copyWith(fontFamily: 'Poppins'),
      AppTextStyle.TITLE_SMALL: textTheme.titleSmall?.copyWith(fontFamily: 'Poppins'),
      AppTextStyle.LABEL_LARGE: textTheme.labelLarge?.copyWith(fontFamily: 'Poppins'),
      AppTextStyle.LABEL_MEDIUM: textTheme.labelMedium?.copyWith(fontFamily: 'Poppins'),
      AppTextStyle.LABEL_SMALL: textTheme.labelSmall?.copyWith(fontFamily: 'Poppins'),
      AppTextStyle.BODY_LARGE: textTheme.bodyLarge?.copyWith(fontFamily: 'Poppins'),
      AppTextStyle.BODY_MEDIUM: textTheme.bodyMedium?.copyWith(fontFamily: 'Poppins'),
      AppTextStyle.BODY_SMALL: textTheme.bodySmall?.copyWith(fontFamily: 'Poppins'),
    };

    return appTextStyleMap[appTextStyle];
  }

  static ColorScheme getColorScheme(BuildContext context) {
    return Theme.of(context).colorScheme;
  }
}