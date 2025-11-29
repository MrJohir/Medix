import 'package:dermaininstitute/core/common/styles/global_text_style.dart';
import 'package:dermaininstitute/core/utils/constants/sizer.dart';
import 'package:flutter/material.dart';

/// Reusable widget for displaying jurisdiction tags (UK, US, CA, etc.)
/// Shows country/region tags in a consistent format
class JurisdictionTag extends StatelessWidget {
  /// The jurisdiction text to display (e.g., "UK", "US", "CA")
  final String jurisdiction;

  const JurisdictionTag({super.key, required this.jurisdiction});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.szR12,
        vertical: AppSizes.szR6,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFDFE1E6), width: 1),
        borderRadius: BorderRadius.circular(AppSizes.szR50),
      ),
      child: Text(
        jurisdiction,
        style: getTsBoldText(fontSize: 12, color: const Color(0xFF141617)),
      ),
    );
  }
}
