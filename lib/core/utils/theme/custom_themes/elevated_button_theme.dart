import 'package:dermaininstitute/core/utils/constants/colors.dart';
import 'package:dermaininstitute/core/utils/constants/sizer.dart';
import 'package:flutter/material.dart';

class AppElevatedButtonTheme {
  AppElevatedButtonTheme._();

  /// -- Light Theme
  static ElevatedButtonThemeData lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ButtonStyle(
      elevation: WidgetStateProperty.all(AppSizes.sz0),
      backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.disabled)) {
          return AppColors.btnDisable;
        }
        return AppColors.primary;
      }),
      foregroundColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.disabled)) {
          return AppColors.primary;
        }
        return Colors.white;
      }),
      side: WidgetStateProperty.all(const BorderSide(color: AppColors.primary)),
      padding: WidgetStateProperty.all(
        EdgeInsets.symmetric(horizontal: AppSizes.szW20, vertical: AppSizes.szH10),
      ),
      textStyle: WidgetStateProperty.resolveWith<TextStyle>((states) {
        return TextStyle(
          fontSize: AppSizes.font16,
          fontWeight: FontWeight.w900, // Always semi-bold
        );
      }),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.szR12)),
      ),
    ),
  );

  /// -- Dark Theme
  static ElevatedButtonThemeData darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ButtonStyle(
      elevation: WidgetStateProperty.all(AppSizes.sz0),
      backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.disabled)) {
          return Colors.grey; // disabled background
        }
        return Colors.blue; // enabled background
      }),
      foregroundColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.disabled)) {
          return AppColors.primary; // ✅ disabled text color
        }
        return Colors.white; // ✅ enabled text color
      }),
      side: WidgetStateProperty.all(const BorderSide(color: Colors.blue)),
      padding: WidgetStateProperty.all(
        EdgeInsets.symmetric(vertical: AppSizes.szH18),
      ),
      textStyle: WidgetStateProperty.all(
         TextStyle(fontSize: AppSizes.font16, fontWeight: FontWeight.w600),
      ),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.szR12)),
      ),
    ),
  );
}
