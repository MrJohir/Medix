import 'package:dermaininstitute/core/utils/constants/sizer.dart';
import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class AppTextTheme {
  AppTextTheme._();

  /// -- Light Theme
  static TextTheme lightTextTheme = TextTheme(
    displayLarge: const TextStyle().copyWith(
      fontSize: 57.0,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    displayMedium: const TextStyle().copyWith(
      fontSize: 45.0,
      fontWeight: FontWeight.w600,
      color: Colors.black87,
    ),
    displaySmall: const TextStyle().copyWith(
      fontSize: 36.0,
      fontWeight: FontWeight.w500,
      color: Colors.black87,
    ),

    headlineLarge: const TextStyle().copyWith(
      fontSize: 32.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ), // Converted FW bold to w600
    headlineMedium: const TextStyle().copyWith(
      fontSize: AppSizes.font24,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),

    headlineSmall: const TextStyle().copyWith(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),

    titleLarge: const TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),

    titleMedium: TextStyle(
      fontSize: AppSizes.font18,
      fontWeight: FontWeight.w500,
      color: Colors.black,
      height: AppSizes.lineHeight1_3,
    ),

    titleSmall: TextStyle(
      fontSize: AppSizes.font14,
      fontWeight: FontWeight.w500,
      color: AppColors.secondary,
      height: 1.3,
    ),

    bodyLarge: TextStyle(
      fontSize: AppSizes.font16,
      fontWeight: FontWeight.normal,
      color: Colors.black,
    ),
    // bodyMedium: const TextStyle(
    //     fontSize: 14.0, fontWeight: FontWeight.w400, color: AppColors.text,  height: 1.6),
    bodyMedium: TextStyle(
      color: AppColors.textPrimary,
      fontSize: AppSizes.font16,
      fontWeight: FontWeight.w500,
      height: AppSizes.lineHeight1_6,
    ),
    bodySmall: TextStyle(
      fontSize: AppSizes.font12,
      fontWeight: FontWeight.normal,
      color: Colors.black,
    ),

    /// -- Label Text Styles
    labelLarge: TextStyle(
      color: AppColors.textHeading,
      fontSize: AppSizes.font16,
      fontWeight: FontWeight.w400,
      height: AppSizes.lineHeight1_6,
    ),

    labelMedium: const TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.w500,
      color: Colors.black54,
    ),
    labelSmall: const TextStyle(
      fontSize: 11.0,
      fontWeight: FontWeight.w500,
      color: Colors.black45,
    ),
  );

  /// -- Dark Theme
  static TextTheme darkTextTheme = TextTheme(
    displayLarge: const TextStyle().copyWith(
      fontSize: 57.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    displayMedium: const TextStyle().copyWith(
      fontSize: 45.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    displaySmall: const TextStyle().copyWith(
      fontSize: 36.0,
      fontWeight: FontWeight.w500,
      color: Colors.white70,
    ),

    headlineLarge: const TextStyle().copyWith(
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    headlineMedium: const TextStyle().copyWith(
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    headlineSmall: const TextStyle().copyWith(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),

    titleLarge: const TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    titleMedium: TextStyle(
      fontSize: AppSizes.font16,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    titleSmall: const TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),

    bodyLarge: TextStyle(
      fontSize: AppSizes.font16,
      fontWeight: FontWeight.normal,
      color: Colors.white,
    ),
    bodyMedium: const TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.normal,
      color: Colors.white,
    ),
    bodySmall: const TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.normal,
      color: Colors.white,
    ),

    labelLarge: const TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
    labelMedium: const TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
    labelSmall: const TextStyle(
      fontSize: 11.0,
      fontWeight: FontWeight.w500,
      color: Colors.white54,
    ),
  );
}
