import 'package:dermaininstitute/core/common/styles/global_text_style.dart';
import 'package:dermaininstitute/core/utils/constants/sizer.dart';
import 'package:flutter/material.dart';

/// custom badge widget for displaying priority and status
/// with appropriate colors based on the type
class StatusBadgeWidget extends StatelessWidget {
  /// text to display on the badge
  final String text;

  /// text color of the badge
  final Color textColor;

  /// background color of the badge
  final Color backgroundColor;

  const StatusBadgeWidget({
    super.key,
    required this.text,
    required this.textColor,
    required this.backgroundColor,
  });

  /// factory constructor for priority badge
  /// automatically sets colors based on priority level
  factory StatusBadgeWidget.priority(String priority) {
    Color textColor;
    Color backgroundColor;

    switch (priority.toLowerCase()) {
      case 'high':
        textColor = const Color(0xFF1A4DBE);
        backgroundColor = const Color(0xFFD2DAF6);
        break;
      case 'medium':
        textColor = const Color(0xFFFF8C00);
        backgroundColor = const Color(0xFFFFE4B5);
        break;
      case 'low':
        textColor = const Color(0xFF32CD32);
        backgroundColor = const Color(0xFFE6FFE6);
        break;
      default:
        textColor = const Color(0xFF1A4DBE);
        backgroundColor = const Color(0xFFD2DAF6);
    }

    return StatusBadgeWidget(
      text: priority,
      textColor: textColor,
      backgroundColor: backgroundColor,
    );
  }

  /// factory constructor for status badge
  /// automatically sets colors based on status
  factory StatusBadgeWidget.status(String status) {
    Color textColor;
    Color backgroundColor;

    switch (status.toLowerCase()) {
      case 'submitted':
        textColor = const Color(0xFF2A7900);
        backgroundColor = const Color(0xFFE4F6D2);
        break;
      case 'pending':
        textColor = const Color(0xFFFF8C00);
        backgroundColor = const Color(0xFFFFE4B5);
        break;
      case 'draft':
        textColor = const Color(0xFF6B7280);
        backgroundColor = const Color(0xFFF3F4F6);
        break;
      default:
        textColor = const Color(0xFF2A7900);
        backgroundColor = const Color(0xFFE4F6D2);
    }

    return StatusBadgeWidget(
      text: status,
      textColor: textColor,
      backgroundColor: backgroundColor,
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
        borderRadius: BorderRadius.circular(9999),
      ),
      child: Text(
        text,
        style: getTsBoldText(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }
}
