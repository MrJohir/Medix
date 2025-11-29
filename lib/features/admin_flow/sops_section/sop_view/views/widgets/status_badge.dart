import 'package:dermaininstitute/core/common/styles/global_text_style.dart';
import 'package:dermaininstitute/core/utils/constants/sizer.dart';
import 'package:flutter/material.dart';

/// Reusable widget for displaying status badges (Critical, Published, etc.)
/// Used throughout the details view to show different status types
class StatusBadge extends StatelessWidget {
  /// The text to display in the badge
  final String text;

  /// The background color type for the badge
  final String colorType;

  const StatusBadge({super.key, required this.text, required this.colorType});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.szR12,
        vertical: AppSizes.szR6,
      ),
      decoration: BoxDecoration(
        color: _getBackgroundColor(colorType),
        borderRadius: BorderRadius.circular(AppSizes.szR50),
      ),
      child: Text(
        text,
        style: getTsBoldText(fontSize: 12, color: _getTextColor(colorType)),
      ),
    );
  }

  /// Get background color based on color type
  Color _getBackgroundColor(String type) {
    switch (type.toLowerCase()) {
      case 'critical':
      case 'red':
        return const Color(0xFFFCEFEF);
      case 'published':
      case 'green':
        return const Color(0xFFE6F4EF);
      case 'draft':
      case 'yellow':
        return const Color(0xFFFFF6DD);
      case 'blue':
        return const Color(0xFFEFF6FF);
      default:
        return const Color(0xFFF5F6F7);
    }
  }

  /// Get text color based on color type
  Color _getTextColor(String type) {
    switch (type.toLowerCase()) {
      case 'critical':
      case 'red':
        return const Color(0xFFE40E0E);
      case 'published':
      case 'green':
        return const Color(0xFF048E5C);
      case 'draft':
      case 'yellow':
        return const Color(0xFFEAB308);
      case 'blue':
        return const Color(0xFF3B82F6);
      default:
        return const Color(0xFF6B7280);
    }
  }
}
