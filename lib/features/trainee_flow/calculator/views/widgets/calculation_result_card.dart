import 'package:dermaininstitute/core/common/styles/global_text_style.dart';
import 'package:dermaininstitute/core/common/widgets/custom_note_card.dart';
import 'package:dermaininstitute/core/utils/constants/sizer.dart';
import 'package:flutter/material.dart';

class CalculationResultCard extends StatelessWidget {
  final String medication;
  final String weight;
  final String age;
  final String calculatedDose;

  const CalculationResultCard({
    super.key,
    required this.medication,
    required this.weight,
    required this.age,
    required this.calculatedDose,
  });

  @override
  Widget build(BuildContext context) {
    return AppNoteCard(
      color: 'Green',
      radius: AppSizes.szR12,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Calculation Result', style: getTsSectionTitle(fontSize: 16)),
          SizedBox(height: AppSizes.szH12),
          _buildResultRow('Medication:', medication),
          SizedBox(height: AppSizes.szH4),
          _buildResultRow('Weight:', '$weight kg'),
          SizedBox(height: AppSizes.szH4),
          _buildResultRow('Age:', '$age years'),
          SizedBox(height: AppSizes.szH8),
          Text(
            'Recommended Dose:',
            style: getTsBoldText(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: AppSizes.szH4),
          Text(
            calculatedDose,
            style: getTsRegularText(
              fontSize: 14,
              color: const Color(0xFF1A4DBE),
            ),
          ),
          SizedBox(height: AppSizes.szH12),
          Text(
            'Note: Always verify with local protocols and clinical judgment.',
            style: getTsRegularText(
              fontSize: 12,
              color: const Color(0xFF666666),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultRow(String label, String value) {
    return Row(
      children: [
        Text(label, style: getTsBoldText(fontSize: 12)),
        SizedBox(width: AppSizes.szW8),
        Text(value, style: getTsRegularText(fontSize: 12)),
      ],
    );
  }
}
