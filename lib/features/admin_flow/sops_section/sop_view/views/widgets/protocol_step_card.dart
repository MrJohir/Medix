import 'package:dermaininstitute/core/common/styles/global_text_style.dart';
import 'package:dermaininstitute/core/utils/constants/icon_path.dart';
import 'package:dermaininstitute/core/utils/constants/sizer.dart';
import 'package:dermaininstitute/core/utils/helpers/svg_icon_helper.dart';
import 'package:flutter/material.dart';

/// Reusable widget for displaying protocol steps in a numbered format
/// Used to show step-by-step instructions with timing information
class ProtocolStepCard extends StatelessWidget {
  /// The step number (1, 2, 3, etc.)
  final String stepNumber;

  /// The title of the step
  final String title;

  /// The description of what to do in this step
  final String description;

  /// The timeframe for completing this step
  final String timeframe;

  const ProtocolStepCard({
    super.key,
    required this.stepNumber,
    required this.title,
    required this.description,
    required this.timeframe,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSizes.szR14),
      decoration: BoxDecoration(
        color: const Color(0xFFDDFCFF), // Light blue background
        borderRadius: BorderRadius.circular(AppSizes.szR12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Step header with number and title
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Step number circle
              Container(
                width: AppSizes.szW24,
                height: AppSizes.szH24,
                decoration: BoxDecoration(
                  color: const Color(0xFFA6F9FF),
                  borderRadius: BorderRadius.circular(AppSizes.szR50),
                ),
                child: Center(
                  child: Text(
                    stepNumber,
                    style: getTsRegularText(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF049B8F),
                    ),
                  ),
                ),
              ),
              SizedBox(width: AppSizes.szW8),
              // Step title
              Expanded(
                child: Text(
                  title,
                  style: getTsSubTitle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF141617),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: AppSizes.szH8),

          // Step description
          Text(
            description,
            style: getTsRegularText(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              lineHeight: 1.2,
              color: const Color(0xFF42526E),
            ),
          ),
          SizedBox(height: AppSizes.szH8),

          // Timeframe with clock icon
          Row(
            children: [
              // Clock icon placeholder - in real app you'd use an actual icon
              SvgIconHelper.buildIcon(
                assetPath: IconPath.icClock,
                height: AppSizes.szH16,
                width: AppSizes.szH16,
              ),
              SizedBox(width: AppSizes.szW4),
              Text(
                timeframe,
                style: getTsRegularText(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  lineHeight: 1.2,
                  color: const Color(0xFF8993A4),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
