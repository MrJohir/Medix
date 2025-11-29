import 'package:dermaininstitute/core/common/styles/global_text_style.dart';
import 'package:dermaininstitute/core/common/widgets/custom_card.dart';
import 'package:dermaininstitute/core/utils/constants/sizer.dart';
import 'package:dermaininstitute/features/trainee_flow/report_view/models/report_model.dart';
import 'package:dermaininstitute/features/trainee_flow/report_view/views/widgets/status_badge_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// main report information card widget
/// displays title, badges, gender, created date, and overview
class ReportInfoCardWidget extends StatelessWidget {
  /// report data to display
  final ReportModel report;

  const ReportInfoCardWidget({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: EdgeInsets.all(AppSizes.szH14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // title section
          _buildTitleSection(),

          SizedBox(height: AppSizes.szH14),

          // badges section
          _buildBadgesSection(),

          SizedBox(height: AppSizes.szH14),

          // gender and created date section
          _buildDetailsSection(),

          SizedBox(height: AppSizes.szH14),

          Divider(color: const Color(0xFFE2E8F0)),

          SizedBox(height: AppSizes.szH14),

          // overview section
          _buildOverviewSection(),
        ],
      ),
    );
  }

  /// build title section
  Widget _buildTitleSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          report.incidentTitle,
          style: getTsSectionTitle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF141617),
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  /// build badges section with priority and status
  Widget _buildBadgesSection() {
    return Row(
      children: [
        StatusBadgeWidget.priority(report.priorityColor),
        SizedBox(width: AppSizes.szW8),
        StatusBadgeWidget.status(report.status),
      ],
    );
  }

  /// build gender and created date section
  Widget _buildDetailsSection() {
    return Row(
      children: [
        // gender field
        Expanded(
          child: _buildInputField(label: 'Gender', value: report.patientSex),
        ),

        SizedBox(width: AppSizes.szW12),

        // created date field
        SizedBox(
          width: 112.w,
          child: _buildInputField(
            label: 'Created',
            value: report.formattedCreatedDate,
          ),
        ),
      ],
    );
  }

  /// build input field with label and value
  Widget _buildInputField({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // label
        Text(
          label,
          style: getTsInputLabel(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF141617),
          ),
        ),

        SizedBox(height: AppSizes.szH4),

        // value container
        Container(
          width: double.infinity,
          height: 46.h,
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.szW14,
            vertical: AppSizes.szH12,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppSizes.szR10),
            border: Border.all(color: const Color(0xFFEDF1F3), width: 1),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFE4E5E7).withValues(alpha: .24),
                offset: const Offset(0, 1),
                blurRadius: 2,
              ),
            ],
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              value,
              style: getTsRegularText(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1A1C1E),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// build overview section
  Widget _buildOverviewSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // overview label
        Text(
          'Overview',
          style: getTsInputLabel(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF141617),
          ),
        ),

        SizedBox(height: AppSizes.szH12),

        // overview text
        Text(
          report.descriptionOfIncident,
          style: getTsRegularText(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF333333),
            lineHeight: 1.4,
          ),
        ),
      ],
    );
  }
}
