import 'package:dermaininstitute/core/common/widgets/custom_appbar.dart';
import 'package:dermaininstitute/core/utils/constants/colors.dart';
import 'package:dermaininstitute/core/utils/constants/sizer.dart';
import 'package:dermaininstitute/features/trainee_flow/report_view/controllers/report_view_controller.dart';
import 'package:dermaininstitute/features/trainee_flow/report_view/views/widgets/incident_details_card_widget.dart';
import 'package:dermaininstitute/features/trainee_flow/report_view/views/widgets/procedure_card_widget.dart';
import 'package:dermaininstitute/features/trainee_flow/report_view/views/widgets/report_info_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// main screen for viewing report details
/// displays all report information in organized cards
class ReportViewScreen extends StatelessWidget {
  final String? reportId;

  const ReportViewScreen({super.key, this.reportId});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReportViewController>(
      init: ReportViewController(),
      builder: (controller) {
        // Load report data if reportId is provided and no current report
        if (reportId != null &&
            controller.currentReport.value == null &&
            !controller.isLoading.value) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            controller.loadReport(reportId!);
          });
        }

        return Scaffold(
          backgroundColor: AppColors.universalBackground,
          appBar: AppBarHelper.backWithAvatar(title: 'Report View'),
          body: Obx(() {
            // show loading state
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            // show error state
            if (controller.errorMessage.value.isNotEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 64, color: AppColors.error),
                    SizedBox(height: AppSizes.szH16),
                    Text(
                      controller.errorMessage.value,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: AppColors.error),
                    ),
                    SizedBox(height: AppSizes.szH16),
                    ElevatedButton(
                      onPressed: () => controller.refreshReport(),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            // show report content
            final report = controller.currentReport.value;
            if (report == null) {
              return const Center(child: Text('No report data available'));
            }

            return SingleChildScrollView(
              padding: EdgeInsets.all(AppSizes.szW20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // main report information card
                  ReportInfoCardWidget(report: report),

                  SizedBox(height: AppSizes.szH16),

                  // procedure card
                  ProcedureCardWidget(procedure: report.procedure),

                  SizedBox(height: AppSizes.szH16),

                  // incident details card
                  IncidentDetailsCardWidget(report: report),

                  // bottom spacing for better scrolling
                  SizedBox(height: AppSizes.szH40),
                ],
              ),
            );
          }),
        );
      },
    );
  }
}
