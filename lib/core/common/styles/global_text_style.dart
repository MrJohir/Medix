import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

/// -- App Bar Title Text Style ------------------------------------------------
TextStyle getTsAppBarTitle({
  double fontSize = 20.0,
  FontWeight fontWeight = FontWeight.w600,
  double lineHeight = 1.50,
  Color color = const Color(0xFF050505),
}) {
  return GoogleFonts.montserrat(
    fontSize: fontSize.sp,
    fontWeight: fontWeight,
    height: lineHeight.h,
    color: color,
  );
}

/// -- Section Title Text Style ------------------------------------------------
TextStyle getTsSectionTitle({
  double fontSize = 16.0,
  FontWeight fontWeight = FontWeight.w600,
  double lineHeight = 1,
  Color color = const Color(0xFF141617),
}) {
  return GoogleFonts.montserrat(
    fontSize: fontSize.sp,
    fontWeight: fontWeight,
    height: lineHeight.h,
    color: color,
  );
}

/// -- Sub Title Text Style ----------------------------------------------------
TextStyle getTsSubTitle({
  double fontSize = 14.0,
  FontWeight fontWeight = FontWeight.w500,
  double lineHeight = 1.5,
  Color color = const Color(0xFF141617),
}) {
  return GoogleFonts.montserrat(
    fontSize: fontSize.sp,
    fontWeight: fontWeight,
    height: lineHeight.h,
    color: color,
  );
}

/// -- Input Label Text Style --------------------------------------------------
TextStyle getTsInputLabel({
  double fontSize = 12.0,
  FontWeight fontWeight = FontWeight.w400,
  double lineHeight = 1.5,
  Color color = const Color(0xFF333333),
}) {
  return GoogleFonts.montserrat(
    fontSize: fontSize.sp,
    fontWeight: fontWeight,
    height: lineHeight.h,
    color: color,
  );
}

/// -- Input Placeholder Text Style --------------------------------------------
TextStyle getTsInputPlaceholder({
  double fontSize = 14.0,
  FontWeight fontWeight = FontWeight.w400,
  double lineHeight = 1,
  Color color = const Color(0xFF8993A4),
}) {
  return GoogleFonts.montserrat(
    fontSize: fontSize.sp,
    fontWeight: fontWeight,
    height: lineHeight.h,
    color: color,
  );
}

/// -- Notes Text Style --------------------------------------------------------
TextStyle getTsNotesText({
  double fontSize = 12.0,
  FontWeight fontWeight = FontWeight.w400,
  double lineHeight = 1,
  Color color = const Color(0xFF3D1E00),
}) {
  return GoogleFonts.montserrat(
    fontSize: fontSize.sp,
    fontWeight: fontWeight,
    height: lineHeight.h,
    color: color,
  );
}

/// -- Paragraph Text Style ----------------------------------------------------
TextStyle getTsRegularText({
  double fontSize = 12.0,
  FontWeight fontWeight = FontWeight.w400,
  double lineHeight = 1,
  Color color = const Color(0xFF172B4D),
}) {
  return GoogleFonts.montserrat(
    fontSize: fontSize.sp,
    fontWeight: fontWeight,
    height: lineHeight.h,
    color: color,
  );
}

/// -- Regular Bold Text Style -------------------------------------------------
TextStyle getTsBoldText({
  double fontSize = 12.0,
  FontWeight fontWeight = FontWeight.w500,
  double lineHeight = 1,
  Color color = const Color(0xFF333333),
}) {
  return GoogleFonts.montserrat(
    fontSize: fontSize.sp,
    fontWeight: fontWeight,
    height: lineHeight.h,
    color: color,
  );
}

/// -- Elevator Button Text Style ----------------------------------------------
TextStyle getTsButtonText({
  double fontSize = 12.0,
  FontWeight fontWeight = FontWeight.w600,
  double lineHeight = 1,
  Color color = Colors.white,
}) {
  return GoogleFonts.montserrat(
    fontSize: fontSize.sp,
    fontWeight: fontWeight,
    height: lineHeight.h,
    color: color,
  );
}

/// -- Text Button Text Style --------------------------------------------------
TextStyle getTsTextButtonText({
  double fontSize = 14.0,
  FontWeight fontWeight = FontWeight.w600,
  double lineHeight = 1,
  Color color = const Color(0xFF12295E),
}) {
  return GoogleFonts.montserrat(
    fontSize: fontSize.sp,
    fontWeight: fontWeight,
    height: lineHeight.h,
    color: color,
  );
}
