import 'package:dermaininstitute/core/common/styles/global_text_style.dart';
import 'package:dermaininstitute/core/utils/constants/sizer.dart';
import 'package:flutter/material.dart';

/// Reusable widget for displaying section headers
/// Provides consistent styling for section titles throughout the details view
class SectionHeader extends StatelessWidget {
  /// The title text for the section
  final String title;

  /// Optional spacing below the header
  final double? bottomSpacing;

  const SectionHeader({super.key, required this.title, this.bottomSpacing});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: AppSizes.szH20, // Fixed height for consistency
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: getTsBoldText(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF333333),
            ),
          ),
        ),
        if (bottomSpacing != null) SizedBox(height: bottomSpacing!),
      ],
    );
  }
}
