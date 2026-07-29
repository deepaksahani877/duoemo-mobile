import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';
import 'app_typography.dart';

/// App theme builder for light and dark modes per instruction.md standards.
class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.backgroundLight,
      colorScheme: const ColorScheme.light(
        surface: AppColors.surfaceLight,
        primary: AppColors.buttonPrimaryBg,
        onPrimary: AppColors.buttonPrimaryText,
        onSurface: AppColors.textPrimary,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      textTheme: TextTheme(
        displayLarge: AppTypography.logoStyle(),
        bodyMedium: AppTypography.quoteStyle(),
        labelLarge: AppTypography.buttonPrimaryStyle(),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.backgroundDark,
      colorScheme: const ColorScheme.dark(
        surface: AppColors.surfaceDark,
        primary: AppColors.buttonPrimaryBgDark,
        onPrimary: AppColors.buttonPrimaryText,
        onSurface: AppColors.textWhite,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
    );
  }
}
