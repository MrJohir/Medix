import 'package:dermaininstitute/core/utils/constants/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dermaininstitute/core/utils/constants/colors.dart';

class CustomAppBarTheme {
  CustomAppBarTheme._();

  static final AppBarTheme lightAppBarTheme = AppBarTheme(
    foregroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    elevation: AppSizes.sz0,
    backgroundColor: Colors.transparent,
    iconTheme: const IconThemeData(color: AppColors.text),
    titleTextStyle: TextStyle(
      color: AppColors.text,
      fontSize: AppSizes.font24,
      fontWeight: FontWeight.bold,
    ),
    actionsIconTheme: const IconThemeData(color: AppColors.text),
    centerTitle: false,
    systemOverlayStyle:
        SystemUiOverlayStyle.dark, // Control status bar color and icons
    scrolledUnderElevation: AppSizes.sz0,
  );

  /// -- Dark Theme
  static final AppBarTheme darkAppBarTheme = AppBarTheme(
    foregroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    elevation: AppSizes.sz0,
    backgroundColor: Colors.grey[900],
    iconTheme: const IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: AppSizes.font24,
      fontWeight: FontWeight.bold,
    ),
    actionsIconTheme: const IconThemeData(color: Colors.white),
    centerTitle: false,
    systemOverlayStyle:
        SystemUiOverlayStyle.light, // Control status bar color and icons
    scrolledUnderElevation: AppSizes.sz0,
  );
}
