import 'package:dermaininstitute/core/utils/constants/icon_path.dart';
import 'package:dermaininstitute/core/utils/helpers/svg_icon_helper.dart';
import 'package:dermaininstitute/features/trainee_flow/reports/controllers/reports_controller.dart';
import 'package:dermaininstitute/features/trainee_flow/reports/models/incident_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:dermaininstitute/core/utils/constants/sizer.dart';
import '../../../report_view/views/screens/report_view_screen.dart';

class IncidentCard extends StatelessWidget {
  final IncidentModel incident;

  const IncidentCard({super.key, required this.incident});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ReportsController>();

    return GestureDetector(
      onTap: () {
        Get.to(() => ReportViewScreen(reportId: incident.id));
      },
      child: Container(
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
            // Title and ID Row
            Row(
              children: [
                Expanded(
                  child: Text(
                    incident.title,
                    style: TextStyle(
                      color: const Color(0xFF141617),
                      fontSize: AppSizes.font16,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Montserrat',
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
                    color: const Color(0xFFF9FAFB),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        width: 1,
                        color: Color(0xFFDFE1E6),
                      ),
                      borderRadius: BorderRadius.circular(AppSizes.szR50),
                    ),
                  ),
                  child: Text(
                    incident.patientSex.isNotEmpty
                        ? incident.patientSex
                        : 'N/A',
                    style: TextStyle(
                      color: const Color(0xFF141617),
                      fontSize: AppSizes.font12,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: AppSizes.szH6),

            // Description
            Text(
              incident.description,
              style: TextStyle(
                color: const Color(0xFF333333),
                fontSize: AppSizes.font12,
                fontWeight: FontWeight.w400,
                fontFamily: 'Montserrat',
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

            // Priority and Status Tags
            Row(
              children: [
                _buildPriorityTag(incident.priority, controller),
                SizedBox(width: AppSizes.szW8),
                _buildStatusTag(incident.status, controller),
              ],
            ),

            SizedBox(height: AppSizes.szH8),

            // Date and Time
            Row(
              children: [
                SvgIconHelper.buildIcon(
                  assetPath: IconPath.calendarIcon,
                  height: AppSizes.szH18,
                  width: AppSizes.szW18,
                ),
                SizedBox(width: AppSizes.szW4),
                Text(
                  _formatDateTime(incident.dateTime),
                  style: TextStyle(
                    color: const Color(0xFF8993A4),
                    fontSize: AppSizes.font10,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),

            SizedBox(height: AppSizes.szH8),

            // Procedure
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Procedure: ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: AppSizes.font12,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  TextSpan(
                    text: incident.procedure,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: AppSizes.font12,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriorityTag(Priority priority, ReportsController controller) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.szW12,
        vertical: AppSizes.szH6,
      ),
      decoration: ShapeDecoration(
        color: _hexToColor(controller.getPriorityColor(priority)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.szR50),
        ),
      ),
      child: Text(
        priority.displayName,
        style: TextStyle(
          color: _hexToColor(controller.getPriorityTextColor(priority)),
          fontSize: AppSizes.font12,
          fontWeight: FontWeight.w500,
          fontFamily: 'Montserrat',
        ),
      ),
    );
  }

  Widget _buildStatusTag(Status status, ReportsController controller) {
    return GestureDetector(
      onTap: () {
        // Todo: API Integration - Quick status toggle functionality
        debugPrint('Quick toggle status for incident: ${incident.id}');
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.szW12,
          vertical: AppSizes.szH6,
        ),
        decoration: ShapeDecoration(
          color: _hexToColor(controller.getStatusColor(status)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.szR50),
          ),
        ),
        child: Text(
          status.displayName,
          style: TextStyle(
            color: _hexToColor(controller.getStatusTextColor(status)),
            fontSize: AppSizes.font12,
            fontWeight: FontWeight.w500,
            fontFamily: 'Montserrat',
          ),
        ),
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy \'at\' HH:mm').format(dateTime);
  }

  Color _hexToColor(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
