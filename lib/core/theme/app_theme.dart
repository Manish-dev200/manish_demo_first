import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import 'app_text_theme.dart';

class AppTheme {
  static ThemeData get light => ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.colorPrimary,
    scaffoldBackgroundColor: AppColors.colorBackgroundLight,
    colorScheme: ColorScheme.light(
      primary: AppColors.colorPrimary,
      secondary: AppColors.colorSecondary,
      error: AppColors.colorError,
    ),
    textTheme: AppTextTheme.textTheme,
    cardColor: AppColors.colorWhite,
    appBarTheme: AppBarTheme(color: AppColors.colorPrimary),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: AppTextTheme.titleSmall,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: AppColors.colorPrimary,
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
  );

  static ThemeData get dark => ThemeData.dark().copyWith(
    colorScheme: ColorScheme.dark(
      primary: AppColors.colorPrimary,
      secondary: AppColors.colorSecondary,
      error: AppColors.colorError,
    ),
    appBarTheme: AppBarTheme(color: AppColors.colorPrimary),

    textTheme: AppTextTheme.textTheme,
    cardColor: AppColors.colorBlack,
    scaffoldBackgroundColor: AppColors.colorBackgroundDark,
  );
}
