import 'package:dermaininstitute/core/utils/constants/icon_path.dart';
import 'package:dermaininstitute/core/utils/helpers/svg_icon_helper.dart';
import 'package:dermaininstitute/features/trainee_flow/create_report/models/simple_draft_report_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dermaininstitute/core/utils/constants/sizer.dart';

/// Draft incident card widget for displaying draft reports
/// Shows draft report information with delete and submit log buttons only
class DraftIncidentCard extends StatelessWidget {
  final SimpleDraftReportModel draftReport;
  final VoidCallback onDelete;
  final VoidCallback onSubmit;

  const DraftIncidentCard({
    super.key,
    required this.draftReport,
    required this.onDelete,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSizes.szW14),
      decoration: ShapeDecoration(
        color: const Color(0xFFFEFEFE),
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0xFFDFE1E6)),
          borderRadius: BorderRadius.circular(AppSizes.szR12),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title and Draft Badge Row
          Row(
            children: [
              Expanded(
                child: Text(
                  draftReport.incidentTitle.isNotEmpty
                      ? draftReport.incidentTitle
                      : 'Untitled Report',
                  style: TextStyle(
                    color: const Color(0xFF141617),
                    fontSize: AppSizes.font16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(width: AppSizes.szW10),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.szW8,
                  vertical: AppSizes.szH4,
                ),
                decoration: ShapeDecoration(
                  color: const Color(0xFFFEF3C7),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 1, color: Color(0xFFD97706)),
                    borderRadius: BorderRadius.circular(AppSizes.szR50),
                  ),
                ),
                child: Text(
                  'DRAFT',
                  style: TextStyle(
                    color: const Color(0xFFD97706),
                    fontSize: AppSizes.font12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: AppSizes.szH6),

          // Description
          Text(
            draftReport.incidentDescription.isNotEmpty
                ? draftReport.incidentDescription
                : 'No description provided',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: const Color(0xFF333333),
              fontSize: AppSizes.font12,
              fontWeight: FontWeight.w400,
            ),
          ),

          SizedBox(height: AppSizes.szH12),

          // Divider
          Container(
            width: double.infinity,
            height: 1,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 1,
                  color: Colors.black.withValues(alpha: 0.12),
                ),
              ),
            ),
          ),

          SizedBox(height: AppSizes.szH12),

          // Severity and Procedure Info
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildInfoTag(draftReport.severity),
              SizedBox(width: AppSizes.szW8),
              _buildInfoTag(draftReport.procedure),
            ],
          ),

          SizedBox(height: AppSizes.szH8),

          // Date and Author
          Row(
            children: [
              SvgIconHelper.buildIcon(
                assetPath: IconPath.calendarIcon,
                height: AppSizes.szH18,
                width: AppSizes.szW18,
              ),
              SizedBox(width: AppSizes.szW4),
              Text(
                _formatDateTime(draftReport.createdAt),
                style: TextStyle(
                  color: const Color(0xFF8993A4),
                  fontSize: AppSizes.font10,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(width: AppSizes.szW16),
              Icon(
                Icons.person_outline,
                size: AppSizes.szW18,
                color: const Color(0xFF8993A4),
              ),
              SizedBox(width: AppSizes.szW4),
              Text(
                draftReport.author,
                style: TextStyle(
                  color: const Color(0xFF8993A4),
                  fontSize: AppSizes.font10,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),

          SizedBox(height: AppSizes.szH16),

          // Action Buttons
          Row(
            children: [
              // Delete Button
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: onDelete,
                  icon: Icon(
                    Icons.delete_outline,
                    size: AppSizes.szW18,
                    color: const Color(0xFFDC2626),
                  ),
                  label: Text(
                    'Delete',
                    style: TextStyle(
                      color: const Color(0xFFDC2626),
                      fontSize: AppSizes.font14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFFDC2626), width: 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSizes.szR8),
                    ),
                    padding: EdgeInsets.symmetric(vertical: AppSizes.szH12),
                  ),
                ),
              ),

              SizedBox(width: AppSizes.szW12),

              // Submit Log Button
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: onSubmit,
                  icon: Icon(
                    Icons.send_outlined,
                    size: AppSizes.szW18,
                    color: Colors.white,
                  ),
                  label: Text(
                    'Submit Log',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: AppSizes.font14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFA94907),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSizes.szR8),
                    ),
                    padding: EdgeInsets.symmetric(vertical: AppSizes.szH12),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Build info tag widget
  Widget _buildInfoTag(String value) {
    if (value.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.szW12,
        vertical: AppSizes.szH6,
      ),
      decoration: ShapeDecoration(
        color: const Color(0xFFF3F4F6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.szR50),
        ),
      ),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              // text: '',
              style: TextStyle(
                color: const Color(0xFF6B7280),
                fontSize: AppSizes.font12,
                fontWeight: FontWeight.w500,
              ),
            ),
            TextSpan(
              text: value,
              style: TextStyle(
                color: const Color(0xFF374151),
                fontSize: AppSizes.font12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Format date time string
  String _formatDateTime(String dateTimeString) {
    try {
      final dateTime = DateTime.parse(dateTimeString);
      return DateFormat('dd/MM/yyyy \'at\' HH:mm').format(dateTime);
    } catch (e) {
      return 'Invalid date';
    }
  }
}
