import 'package:dermaininstitute/core/utils/constants/colors.dart';
import 'package:dermaininstitute/core/utils/constants/sizer.dart';
import 'package:flutter/material.dart';

class AppCheckboxTheme {
  AppCheckboxTheme._();

  /// -- Light Theme
  static CheckboxThemeData lightCheckboxTheme = CheckboxThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSizes.szR6),
    ),
    side: WidgetStateBorderSide.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return const BorderSide(color: Colors.transparent, width: AppSizes.sz0); // No border when checked
      }
      return BorderSide(color: AppColors.primary, width: AppSizes.szW2); // Border when unchecked
    }),
    checkColor: WidgetStateProperty.resolveWith((states) {
      return Colors.white; // Always white check mark
    }),
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return AppColors.primary; // Fill when checked
      }
      return Colors.transparent; // Transparent when unchecked
    }),
  );

  /// -- Dark Theme
  static CheckboxThemeData darkCheckboxTheme = CheckboxThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSizes.szR6),
    ),
    side: WidgetStateBorderSide.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return const BorderSide(color: Colors.transparent, width: AppSizes.sz0); // No border when checked
      }
      return BorderSide(color: AppColors.primary, width: AppSizes.szW2); // Border when unchecked
    }),
    checkColor: WidgetStateProperty.resolveWith((states) {
      return Colors.white; // Always white check mark
    }),
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return AppColors.primary; // Fill when checked
      }
      return Colors.transparent; // Transparent when unchecked
    }),
  );
}