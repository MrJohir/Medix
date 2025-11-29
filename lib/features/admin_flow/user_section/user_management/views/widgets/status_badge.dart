import 'package:flutter/material.dart';
import 'package:dermaininstitute/core/common/styles/global_text_style.dart';
import 'package:dermaininstitute/core/utils/constants/sizer.dart';

/// Custom status badge widget for displaying user role and status
/// Supports different colors based on the badge type
class StatusBadge extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;

  const StatusBadge({
    super.key,
    required this.text,
    required this.backgroundColor,
    required this.textColor,
  });

  /// Factory constructor for role badges
  factory StatusBadge.role(String role) {
    Color backgroundColor;
    Color textColor;

    switch (role.toLowerCase()) {
      case 'administrator':
        backgroundColor = const Color(0xFFD4E7F8);
        textColor = const Color(0xFF0637DB);
        break;
      case 'trainee':
        backgroundColor = const Color(0xFFD4E7F8);
        textColor = const Color(0xFF0637DB);
        break;
      case 'supervisor':
        backgroundColor = const Color(0xFFFFF6DD);
        textColor = const Color(0xFFA94907);
        break;
      default:
        backgroundColor = const Color(0xFFF0F0F0);
        textColor = const Color(0xFF919191);
    }

    return StatusBadge(
      text: role,
      backgroundColor: backgroundColor,
      textColor: textColor,
    );
  }

  /// Factory constructor for status badges
  factory StatusBadge.status(String status) {
    Color backgroundColor;
    Color textColor;

    switch (status.toLowerCase()) {
      case 'active':
        backgroundColor = const Color(0xFFE6F4EF);
        textColor = const Color(0xFF048E5C);
        break;
      case 'inactive':
        backgroundColor = const Color(0xFFF0F0F0);
        textColor = const Color(0xFF919191);
        break;
      default:
        backgroundColor = const Color(0xFFF0F0F0);
        textColor = const Color(0xFF919191);
    }

    return StatusBadge(
      text: status,
      backgroundColor: backgroundColor,
      textColor: textColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.szW12,
        vertical: AppSizes.szH6,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppSizes.szR50),
      ),
      child: Text(
        text,
        style: getTsRegularText(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
      ),
    );
  }
}
