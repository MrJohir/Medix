// lib/features/trainee_flow/reports/views/widgets/reports_incidents_list.dart
import 'package:dermaininstitute/core/utils/constants/sizer.dart';
import 'package:dermaininstitute/features/trainee_flow/reports/controllers/reports_controller.dart';
import 'package:dermaininstitute/features/trainee_flow/reports/views/widgets/insident_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'incident_card.dart';

class ReportsIncidentsList extends StatelessWidget {
  const ReportsIncidentsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final controller = Get.find<ReportsController>();

      // Show loading indicator
      if (controller.isLoading && controller.filteredIncidents.isEmpty) {
        return const Center(child: IncidentCardShimmerList());
      }

      // Show error state
      if (controller.hasError && controller.filteredIncidents.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: AppSizes.szW48,
                color: const Color(0xFFDB0000),
              ),
              SizedBox(height: AppSizes.szH16),
              Text(
                'Error Loading Incidents',
                style: TextStyle(
                  color: const Color(0xFFDB0000),
                  fontSize: AppSizes.font16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: AppSizes.szH8),
              Text(
                controller.errorMessage,
                style: TextStyle(
                  color: const Color(0xFF8993A4),
                  fontSize: AppSizes.font12,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: AppSizes.szH16),
              ElevatedButton(
                onPressed: () {
                  controller.clearError();
                  controller.refreshData();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFA94907),
                  foregroundColor: Colors.white,
                ),
                child: const Text('Retry'),
              ),
            ],
          ),
        );
      }

      // Show empty state
      if (controller.filteredIncidents.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.search_off,
                size: AppSizes.szW48,
                color: const Color(0xFF8993A4),
              ),
              SizedBox(height: AppSizes.szH16),
              Text(
                'No incidents found',
                style: TextStyle(
                  color: const Color(0xFF8993A4),
                  fontSize: AppSizes.font16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: AppSizes.szH8),
              Text(
                'Try adjusting your search or filter criteria',
                style: TextStyle(
                  color: const Color(0xFF8993A4),
                  fontSize: AppSizes.font12,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
              if (controller.searchQuery.isNotEmpty ||
                  controller.selectedPriority.name != 'all') ...[
                SizedBox(height: AppSizes.szH16),
                TextButton(
                  onPressed: () {
                    // Use the new clearAllFilters method for proper state management
                    controller.clearAllFilters();
                  },
                  child: const Text('Clear Filters'),
                ),
              ],
            ],
          ),
        );
      }

      // Show incidents list with pull-to-refresh
      return RefreshIndicator(
        onRefresh: () async {
          await controller.refreshData();
        },
        color: const Color(0xFFA94907),
        child: ListView.separated(
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: controller.filteredIncidents.length,
          separatorBuilder: (context, index) =>
              SizedBox(height: AppSizes.szH25),
          itemBuilder: (context, index) {
            final incident = controller.filteredIncidents[index];
            return GestureDetector(
              onTap: () {
                Get.toNamed(
                  '/report-details',
                  arguments: controller.allReports.firstWhere(
                    (report) => report.id == incident.id,
                  ),
                );
              },
              child: IncidentCard(incident: incident),
            );
          },
        ),
      );
    });
  }
}
