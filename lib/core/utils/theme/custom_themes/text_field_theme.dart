import 'package:dermaininstitute/core/utils/constants/colors.dart';
import 'package:dermaininstitute/core/utils/constants/sizer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextFormFieldTheme {
  AppTextFormFieldTheme._();

  /// -- Light Theme
  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: Colors.grey,
    suffixIconColor: AppColors.primary,
    hintStyle: GoogleFonts.inter(
      fontSize: AppSizes.font16,
      fontWeight: FontWeight.w400,
      color: AppColors.placeholder,
      height: AppSizes.lineHeight1_6,
    ),
    floatingLabelBehavior: FloatingLabelBehavior.never,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.szR12),
      borderSide: BorderSide(color: AppColors.border, width: AppSizes.szW1),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.szR12),
      borderSide: BorderSide(color: AppColors.border, width: AppSizes.szW1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.szR12),
      borderSide: BorderSide(color: AppColors.border, width: AppSizes.szW1),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.szR12),
      borderSide: BorderSide(color: AppColors.error, width: AppSizes.szW1),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.szR12),
      borderSide: BorderSide(color: Colors.orange, width: AppSizes.szW1),
    ),
    isDense: true,
    //contentPadding: EdgeInsets.zero, // Remove all padding
    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
  );

  /// -- Dark Theme
  static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: Colors.grey,
    suffixIconColor: AppColors.primary, // ✅ suffix icon color
    hintStyle: GoogleFonts.inter(
      fontSize: AppSizes.font16,
      height: AppSizes.lineHeight1_6,
      fontWeight: FontWeight.w500,
      color: Colors.white70,
    ),
    floatingLabelBehavior: FloatingLabelBehavior.never, // ✅ Prevent label floating
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.szR12),
      borderSide: BorderSide(color: Colors.white70, width: AppSizes.szW1),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.szR12),
      borderSide: BorderSide(color: Colors.white70, width: AppSizes.szW1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.szR12),
      borderSide: BorderSide(color: AppColors.primary, width: AppSizes.szW1),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.szR12),
      borderSide: BorderSide(color: AppColors.error, width: AppSizes.szW1),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.szR12),
      borderSide: BorderSide(color: Colors.orange, width: AppSizes.szW1),
    ),
  );
}
