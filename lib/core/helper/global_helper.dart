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

// Tema warna sederhana dengan primary color #0E3C53
class AppColors {
  // Main color #0E3C53
  static const Color primaryColor = Color(0xFF0E3C53);
  
  // Variasi warna primary yang mungkin dibutuhkan
  static const Color primaryLight = Color(0xFF1A5B80);
  static const Color primaryDark = Color(0xFF092A3A);
  
  // Beberapa warna pendukung yang umum digunakan
  static const Color accentColor = Color(0xFFF0A500);   // Gold accent
  static const Color errorColor = Color(0xFFD32F2F);    // Red
  static const Color successColor = Color(0xFF388E3C);  // Green
  static const Color warningColor = Color(0xFFF57C00);  // Orange
  
  // Warna background dan text
  static const Color backgroundColor = Color(0xFFF5F5F5);
  static const Color textColor = Color(0xFF212121);
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

// Contoh penggunaan di main.dart:
/*
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primaryColor: AppColors.primaryColor,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryColor,
          primary: AppColors.primaryColor,
        ),
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: AppColors.backgroundColor,
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}
*/