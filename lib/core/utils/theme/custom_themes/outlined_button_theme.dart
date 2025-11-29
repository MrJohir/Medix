import 'package:dermaininstitute/core/utils/constants/sizer.dart';
import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class AppOutlinedButtonTheme {
  AppOutlinedButtonTheme._();

  /// -- Light Theme
  static final lightOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: AppSizes.sz0,
      foregroundColor: Colors.black,
      side: const BorderSide(color: AppColors.primary),
      textStyle: TextStyle(fontSize: AppSizes.font16, color: Colors.black, fontWeight: FontWeight.w600),
      padding: EdgeInsets.symmetric(horizontal: AppSizes.szW20, vertical: AppSizes.szH10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.szR12)),
    ),
  );

  /// -- Dark Theme
  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: Colors.white,
      side: const BorderSide(color: AppColors.primary),
      textStyle: TextStyle(fontSize: AppSizes.font16, color: Colors.white, fontWeight: FontWeight.w600),
      padding: EdgeInsets.symmetric(horizontal: AppSizes.szW20, vertical: AppSizes.szH10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.szR12)),
    ),
  );
}