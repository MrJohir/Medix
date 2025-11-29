import 'package:dermaininstitute/core/common/styles/global_text_style.dart';
import 'package:dermaininstitute/core/common/widgets/custom_card.dart';
import 'package:dermaininstitute/core/utils/constants/sizer.dart';
import 'package:flutter/material.dart';

/// simple card widget to display procedure information
class ProcedureCardWidget extends StatelessWidget {
  /// procedure text to display
  final String procedure;

  const ProcedureCardWidget({super.key, required this.procedure});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: EdgeInsets.all(AppSizes.szH14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // procedure label
          Text(
            'Procedure:',
            style: getTsInputLabel(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF141617),
            ),
          ),

          SizedBox(height: AppSizes.szH12),

          // procedure text
          Text(
            procedure,
            style: getTsRegularText(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF333333),
              lineHeight: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
