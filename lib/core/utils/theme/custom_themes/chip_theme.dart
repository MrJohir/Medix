import 'package:dermaininstitute/core/utils/constants/colors.dart';
import 'package:dermaininstitute/core/utils/constants/sizer.dart';
import 'package:flutter/material.dart';

class AppChipTheme {
  AppChipTheme._();

  // -- Light Theme
  static ChipThemeData lightChipTheme = ChipThemeData(
    disabledColor: Colors.grey.withValues(alpha: 0.4),
    labelStyle: const TextStyle(color: Colors.black),
    selectedColor: AppColors.primary,
    padding: EdgeInsets.symmetric(horizontal: AppSizes.szW12, vertical: AppSizes.szH12),
    checkmarkColor: Colors.white,
  );

  /// -- Dark Theme
  static ChipThemeData darkChipTheme = ChipThemeData(
    disabledColor: Colors.grey.withValues(alpha: 0.4),
    labelStyle: const TextStyle(color: Colors.white),
    selectedColor: AppColors.primary,
    padding: EdgeInsets.symmetric(horizontal: AppSizes.szW12, vertical: AppSizes.szH12),
    checkmarkColor: Colors.white,
  );
}