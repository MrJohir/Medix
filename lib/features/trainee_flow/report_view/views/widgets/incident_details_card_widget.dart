import 'package:dermaininstitute/core/common/styles/global_text_style.dart';
import 'package:dermaininstitute/core/common/widgets/custom_card.dart';
import 'package:dermaininstitute/core/utils/constants/sizer.dart';
import 'package:dermaininstitute/features/trainee_flow/report_view/models/report_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IncidentDetailsCardWidget extends StatelessWidget {
  /// report data to display
  final ReportModel report;

  const IncidentDetailsCardWidget({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: EdgeInsets.all(AppSizes.szH14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // title
          Text(
            'Incident Details',
            style: getTsSectionTitle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF141617),
            ),
          ),

          SizedBox(height: AppSizes.szH16),

          // details content
          Column(
            children: [
              // description of incident
              _buildTextAreaField(
                label: 'Description of Incident',
                text: report.descriptionOfIncident,
              ),

              SizedBox(height: AppSizes.szH14),

              // action taken
              _buildTextAreaField(
                label: 'Action Taken',
                text: report.actionsTaken,
              ),

              SizedBox(height: AppSizes.szH14),

              // outcome
              _buildTextAreaField(label: 'Outcome', text: report.outcome),

              SizedBox(height: AppSizes.szH14),

              // lesson learned
              _buildTextAreaField(
                label: 'Lesson Learned',
                text: report.lessonsLearned,
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// build text area field with label and text
  Widget _buildTextAreaField({required String label, required String text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // label
        Text(
          label,
          style: getTsInputLabel(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF333333),
          ),
        ),

        SizedBox(height: AppSizes.szH6),

        // text area container
        Container(
          width: double.infinity,
          constraints: BoxConstraints(
            minHeight: 80.h, // minimum height for consistent design
          ),
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.szW12,
            vertical: AppSizes.szH10,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppSizes.szR10),
            border: Border.all(color: const Color(0xFFEDF1F3), width: 1),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFE4E5E7).withValues(alpha: 0.24),
                offset: const Offset(0, 1),
                blurRadius: 2,
              ),
            ],
          ),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              text,
              style: getTsRegularText(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF333333),
                lineHeight: 1.4,
              ),
              softWrap: true,
            ),
          ),
        ),
      ],
    );
  }
}
