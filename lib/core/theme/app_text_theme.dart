import 'package:flutter/material.dart';

class AppTextTheme {
  static const TextStyle headlineLarge = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
  );


  ///Body text
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );


  static const TextStyle bodyMedium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle bodySmall= TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );


  static const TextStyle titleLarge = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle titleMedium = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle titleSmall = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle displayMedium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle displaySmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );


  ////Implement Here
  static TextTheme get textTheme => const TextTheme(
    headlineLarge: headlineLarge,
    bodyMedium: bodyMedium,
    bodyLarge: bodyLarge,
    bodySmall: bodySmall,
    titleSmall: titleSmall,
    titleMedium:titleMedium,
    titleLarge: titleLarge,
    displaySmall: displaySmall,
    displayMedium: displayMedium,

  );
}
