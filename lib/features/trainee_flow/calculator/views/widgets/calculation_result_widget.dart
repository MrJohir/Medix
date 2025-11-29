import 'package:dermaininstitute/core/common/styles/global_text_style.dart';
import 'package:dermaininstitute/core/utils/constants/sizer.dart';
import 'package:dermaininstitute/features/trainee_flow/calculator/controllers/calculator_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Widget to display calculation results in either safe (positive) or review required (negative) format
/// This widget appears below the calculate button and shows detailed dosage information
class CalculationResultWidget extends StatelessWidget {
  final CalculatorController controller;

  const CalculationResultWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Only show if we have calculation results
      if (!controller.showResult.value) {
        return const SizedBox.shrink();
      }

      // Determine if calculation is safe or requires review
      bool isSafe = controller.isSafeCalculation.value;

      return Container(
        width: double.infinity,
        padding: EdgeInsets.all(AppSizes.szR14),
        decoration: ShapeDecoration(
          // Red background when critical_info_flag=true (isSafe=false), green when false (isSafe=true)
          color: isSafe ? const Color(0xFFEDF6F4) : const Color(0xFFF8F0F1),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1,
              // Red border when critical_info_flag=true (isSafe=false), green when false (isSafe=true)
              color: isSafe ? const Color(0xFF36B37E) : const Color(0xFFDB0000),
            ),
            borderRadius: BorderRadius.circular(AppSizes.szR12),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header section with title and copy button
            _buildHeaderSection(isSafe),
            SizedBox(height: AppSizes.szH12),

            // Main content section with dose details
            _buildContentSection(),

            // Critical warnings section - always show
            SizedBox(height: AppSizes.szH12),
            _buildDivider(),
            SizedBox(height: AppSizes.szH12),
            _buildCriticalWarningsSection(),
          ],
        ),
      );
    });
  }

  /// Builds the header section with title, subtitle, and copy button
  Widget _buildHeaderSection(bool isSafe) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isSafe ? 'Safe Calculation' : 'Review Required',
                style: getTsSectionTitle(
                  fontSize: 16,
                  color: isSafe
                      ? const Color(0xFF36B37E) // Green for safe
                      : const Color(0xFFDB0000), // Red for review required
                ),
              ),
              Text(
                'Dosing result',
                style: getTsRegularText(
                  fontSize: 12,
                  color: const Color(0xFF141617),
                ),
              ),
            ],
          ),
        ),
        // // Copy button
        // GestureDetector(
        //   onTap: () => controller.copyResultToClipboard(),
        //   child: Container(
        //     padding: EdgeInsets.symmetric(
        //       horizontal: AppSizes.szW8,
        //       vertical: AppSizes.szH6,
        //     ),
        //     decoration: ShapeDecoration(
        //       color: const Color(0xFFFEFEFE),
        //       shape: RoundedRectangleBorder(
        //         side: const BorderSide(width: 1, color: Color(0xFF12295E)),
        //         borderRadius: BorderRadius.circular(AppSizes.szR6),
        //       ),
        //     ),
        //     child: Row(
        //       mainAxisSize: MainAxisSize.min,
        //       children: [
        //         // Copy icon placeholder - you can replace with actual icon
        //         Container(
        //           width: AppSizes.szW16,
        //           height: AppSizes.szH16,
        //           decoration: const BoxDecoration(),
        //           // Todo: Add copy icon here
        //           child: Icon(
        //             Icons.copy,
        //             size: AppSizes.szW14,
        //             color: const Color(0xFF12295E),
        //           ),
        //         ),
        //         SizedBox(width: AppSizes.szW8),
        //         Text(
        //           'Copy',
        //           style: getTsBoldText(
        //             fontSize: 12,
        //             color: const Color(0xFF12295E),
        //             fontWeight: FontWeight.w600,
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
      ],
    );
  }

  /// Builds the main content section with calculated dose and administration route
  Widget _buildContentSection() {
    return Column(
      children: [
        // Calculated Dose Card (full width)
        _buildInfoCard(
          'Calculated Dose',
          controller.calculatedDoseValue.value,
          isFullWidth: true,
        ),

        SizedBox(height: AppSizes.szH16),

        // Administration Route/Notes Card (full width)
        _buildInfoCard(
          'Note:',
          controller.administrationRoute.value,
          isFullWidth: true,
        ),
      ],
    );
  }

  /// Builds individual information cards for dose details
  Widget _buildInfoCard(
    String title,
    String value, {
    bool isFullWidth = false,
  }) {
    return Container(
      width: isFullWidth ? double.infinity : null,
      padding: EdgeInsets.all(AppSizes.szR14),
      decoration: ShapeDecoration(
        color: const Color(0xFFFEFEFE),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.szR6),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: getTsRegularText(
              fontSize: 12,
              color: const Color(0xFF212934),
            ),
          ),
          SizedBox(height: AppSizes.szH6),
          Text(
            value,
            style: getTsSectionTitle(
              fontSize: 16,
              color: const Color(0xFF141617),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the divider for separating main content from warnings
  Widget _buildDivider() {
    return Container(
      height: 1,
      width: double.infinity,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            color: Colors.black.withValues(alpha: 0.12),
          ),
        ),
      ),
    );
  }

  /// Builds the critical warnings section - always shown
  Widget _buildCriticalWarningsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Critical Warnings',
          style: getTsBoldText(
            fontSize: 12,
            color: const Color(0xFF141617),
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: AppSizes.szH12),

        // List of warnings
        ...controller.clinicalWarnings.map(
          (warning) => _buildWarningItem(warning),
        ),
      ],
    );
  }

  /// Builds individual warning items with warning icon
  Widget _buildWarningItem(String warning) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSizes.szR8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Warning icon
          Icon(
            Icons.warning_rounded,
            size: AppSizes.szW16,
            color: const Color(0xFFEAB308),
          ),
          SizedBox(width: AppSizes.szW8),

          // Warning text
          Expanded(
            child: Text(
              warning,
              style: getTsRegularText(
                fontSize: 12,
                color: const Color(0xFF141617),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Extension for easier access to result widget in calculator screen
extension CalculationResultExtension on CalculatorController {
  /// Creates the result widget for display in the calculator screen
  Widget buildResultWidget() {
    return CalculationResultWidget(controller: this);
  }
}
