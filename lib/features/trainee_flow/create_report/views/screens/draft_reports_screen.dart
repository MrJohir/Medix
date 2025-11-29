import 'package:dermaininstitute/core/common/widgets/custom_appbar.dart';
import 'package:dermaininstitute/core/utils/constants/sizer.dart';
import 'package:dermaininstitute/core/common/styles/global_text_style.dart';
import 'package:dermaininstitute/features/trainee_flow/reports/controllers/reports_controller.dart';
import 'package:dermaininstitute/features/trainee_flow/create_report/views/widgets/draft_incident_card.dart';
import 'package:dermaininstitute/features/trainee_flow/create_report/models/simple_draft_report_model.dart';
import 'package:dermaininstitute/core/services/local_data_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Draft reports screen for viewing and managing saved draft reports
/// Shows drafts as incident cards with delete and submit log buttons
class DraftReportsScreen extends StatelessWidget {
  const DraftReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DraftReportsController());

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBarHelper.backWithAvatar(
        title: 'Draft Reports',
        onBackPressed: () => Get.back(),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.draftReports.isEmpty) {
          return _buildEmptyState();
        }

        return _buildDraftReportsList(controller);
      }),
    );
  }

  /// Build empty state when no drafts exist
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.article_outlined,
            size: AppSizes.szW80,
            color: const Color(0xFF8993A4),
          ),
          SizedBox(height: AppSizes.szH16),
          Text(
            'No Draft Reports',
            style: getTsAppBarTitle(
              fontSize: AppSizes.font18,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF141617),
            ),
          ),
          SizedBox(height: AppSizes.szH8),
          Text(
            'You don\'t have any saved draft reports.',
            textAlign: TextAlign.center,
            style: getTsAppBarTitle(
              fontSize: AppSizes.font14,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF8993A4),
            ),
          ),
        ],
      ),
    );
  }

  /// Build the list of draft reports
  Widget _buildDraftReportsList(DraftReportsController controller) {
    return Padding(
      padding: EdgeInsets.all(AppSizes.szW16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with count
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Draft Reports (${controller.draftReports.length})',
                style: getTsAppBarTitle(
                  fontSize: AppSizes.font16,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF141617),
                ),
              ),
              TextButton(
                onPressed: () => controller.clearAllDrafts(),
                child: Text(
                  'Clear All',
                  style: getTsAppBarTitle(
                    fontSize: AppSizes.font14,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFFA94907),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: AppSizes.szH16),

          // List of draft reports
          Expanded(
            child: ListView.separated(
              itemCount: controller.draftReports.length,
              separatorBuilder: (context, index) =>
                  SizedBox(height: AppSizes.szH12),
              itemBuilder: (context, index) {
                final draft = controller.draftReports[index];
                return DraftIncidentCard(
                  draftReport: draft,
                  onDelete: () => controller.deleteDraft(draft.id),
                  onSubmit: () => controller.submitDraft(draft),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// Controller for managing draft reports screen
class DraftReportsController extends GetxController {
  final RxList<SimpleDraftReportModel> draftReports =
      <SimpleDraftReportModel>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadDraftReports();
  }

  /// Load all draft reports from local storage
  void loadDraftReports() {
    try {
      isLoading.value = true;
      final drafts = LocalDataService.getAllDraftReports();
      draftReports.value = drafts;
    } catch (e) {
      debugPrint('Error loading draft reports: $e');
    } finally {
      isLoading.value = false;
    }
  }

  /// Delete a specific draft report
  Future<void> deleteDraft(String id) async {
    try {
      // Show confirmation dialog
      final confirmed = await Get.dialog<bool>(
        AlertDialog(
          title: const Text('Delete Draft'),
          content: const Text(
            'Are you sure you want to delete this draft report?',
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(result: false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Get.back(result: true),
              child: const Text('Delete'),
            ),
          ],
        ),
      );

      if (confirmed == true) {
        final success = await LocalDataService.deleteDraftReport(id);
        if (success) {
          draftReports.removeWhere((draft) => draft.id == id);
          Get.snackbar(
            'Success',
            'Draft report deleted successfully',
            backgroundColor: const Color(0xFF10B981),
            colorText: Colors.white,
          );
        } else {
          Get.snackbar(
            'Error',
            'Failed to delete draft report',
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      }
    } catch (e) {
      debugPrint('Error deleting draft: $e');
      Get.snackbar(
        'Error',
        'Failed to delete draft report',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  /// Submit a draft report to the API
  Future<void> submitDraft(SimpleDraftReportModel draft) async {
    try {
      // Get or create reports controller for API submission
      ReportsController reportsController;
      try {
        reportsController = Get.find<ReportsController>();
      } catch (e) {
        // If controller not found, create a new one
        reportsController = Get.put(ReportsController());
      }

      // Submit the draft using reports controller
      final success = await reportsController.submitDraftReport(draft);

      if (success) {
        // Remove from local storage
        await LocalDataService.deleteDraftReport(draft.id);

        // Remove from list
        draftReports.removeWhere((d) => d.id == draft.id);

        Get.snackbar(
          'Success',
          'Report submitted successfully',
          backgroundColor: const Color(0xFF10B981),
          colorText: Colors.white,
        );
      }
    } catch (e) {
      debugPrint('Error submitting draft: $e');
      Get.snackbar(
        'Error',
        'Failed to submit report',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  /// Clear all draft reports
  Future<void> clearAllDrafts() async {
    try {
      final confirmed = await Get.dialog<bool>(
        AlertDialog(
          title: const Text('Clear All Drafts'),
          content: const Text(
            'Are you sure you want to delete all draft reports?',
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(result: false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Get.back(result: true),
              child: const Text('Clear All'),
            ),
          ],
        ),
      );

      if (confirmed == true) {
        final success = await LocalDataService.clearAllDraftReports();
        if (success) {
          draftReports.clear();
          Get.snackbar(
            'Success',
            'All draft reports cleared',
            backgroundColor: const Color(0xFF10B981),
            colorText: Colors.white,
          );
        }
      }
    } catch (e) {
      debugPrint('Error clearing all drafts: $e');
    }
  }
}
