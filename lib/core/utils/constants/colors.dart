// ignore_for_file: use_full_hex_values_for_flutter_colors

import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Brand Colors
  static const Color primary = Color(0xFFA94907);
  static const Color grey = Color(0xFF6C7278);
  static const Color black = Color(0xFF050505);
  static const Color white = Color(0xFFFFFFFF);

  static const Color secondary = Color(0xFF3A4C67);
  static const Color accent = Color(0xFF10B981); // Softer bl
  static const Color background = Color(0xFFE5E7EB); // Softer bl
  static const Color universalBackground = Color(0xFFF9FAFB); // App BG Color

  /// -- Extra Added Colors
  static const Color text = Color(0xFF42526E); // ue for a modern touch

  static const Color textHeading = Color(0xFF050505);

  static const Color btnDisable = Color(0xFFE9EFFD); // ue for a modern touch
  static const Color fieldBg = Color(0xFFF3F3F3); // ue for a modern touch
  static const Color cardBg = Color(0xFFF2F2F2);
  static const Color placeholder = Color(0xFF898989); // ue for a modertouch
  static const Color placeholderText = Color(0xFF9CA3AF); // ue for a modertouch
  static const Color border = Color(0xFFC7CACF);
  static const Color secondaryText = Color(0xFF6B7280);

  // Gradient Colors
  static const Gradient linearGradient = LinearGradient(
    begin: Alignment(0.0, 0.0),
    end: Alignment(0.707, -0.707),
    colors: [Color(0xfffff9a9e), Color(0xFFFAD0C4), Color(0xFFFAD0C4)],
  );

  // Text Colors
  static const Color textPrimary = Color(
    0xFF1F1F1F,
  ); // Darker shade for better readability
  static const Color textSecondary = Color(
    0xFF757575,
  ); // Neutral grey for secondary text
  static const Color textWhite = Colors.white;

  // Background Colors
  static const Color backgroundLight = Color(
    0xFFF9FAFB,
  ); // Light neutral for clean look
  static const Color backgroundDark = Color(
    0xFF121212,
  ); // Dark background for contrast in dark mode
  static const Color primaryBackground = Color(
    0xFFFFFFFF,
  ); // Pure white for primary content areas

  // Utility Colors
  static const Color success = Color(0xFF4CAF50); // Green for success messages
  static const Color warning = Color(0xFFFFA726); // Orange for warnings
  static const Color error = Color(0xFFE53935); // Red for error messages
  static const Color info = Color(
    0xFF29B6F6,
  ); // Blue for informational messages

  static const Color lightGrey = Color(
    0xFF212934,
  ); // Blue for informational messages
  static const Color container1 = Color(0xFFFCEBFF);
    static const Color container2 = Color(0xFFEBF7FF);
  static const Color container3 = Color(0xFFFFEBEB);
  static const Color container4 = Color(0xFFEBFFF2);
  static const Color containerBorder = Color(0xFFE2E8F0);
}
