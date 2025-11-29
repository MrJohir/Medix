import 'package:dermaininstitute/core/common/styles/global_text_style.dart';
import 'package:dermaininstitute/core/utils/constants/sizer.dart';
import 'package:flutter/material.dart';

/// Reusable widget for displaying medication information
/// Shows medication details like dose, route, and repeat instructions
class MedicationInfoCard extends StatelessWidget {
  /// The name of the medication
  final String medicationName;

  /// The dose of the medication
  final String dose;

  /// The route of administration
  final String route;

  /// Repeat instructions
  final String repeat;

  const MedicationInfoCard({
    super.key,
    required this.medicationName,
    required this.dose,
    required this.route,
    required this.repeat,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Medication name header
        Text(
          medicationName,
          style: getTsBoldText(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: const Color(0xFFA94907), // Orange color for medication names
          ),
        ),
        SizedBox(height: AppSizes.szH12),

        // Medication details
        Column(
          children: [
            // Dose information
            _buildMedicationRow('Dose:', dose),
            SizedBox(height: AppSizes.szH10),

            // Route information
            _buildMedicationRow('Route:', route),
            SizedBox(height: AppSizes.szH10),

            // Repeat instructions
            _buildMedicationRow('Repeat:', repeat),
          ],
        ),
      ],
    );
  }

  /// Helper method to build consistent medication information rows
  Widget _buildMedicationRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Text(
          label,
          style: getTsRegularText(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF141617),
          ),
        ),
        SizedBox(width: AppSizes.szW8),

        // Value
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: getTsRegularText(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF141617),
            ),
          ),
        ),
      ],
    );
  }
}
