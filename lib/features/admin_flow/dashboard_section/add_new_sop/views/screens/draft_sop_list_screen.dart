import 'package:dermaininstitute/core/common/widgets/custom_appbar.dart';
import 'package:dermaininstitute/core/utils/constants/sizer.dart';
import 'package:dermaininstitute/core/common/styles/global_text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/draft_sop_list_controller.dart';
import '../widget/draft_sop_card.dart';

/// Screen to display saved draft SOPs with publish and delete options
/// Shows list of all locally stored draft SOPs
class DraftSOPListScreen extends StatelessWidget {
  const DraftSOPListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DraftSOPListController controller = Get.put(DraftSOPListController());

    return Scaffold(
      appBar: AppBarHelper.backWithAvatar(
        title: 'Draft SOPs',
        onBackPressed: controller.onBackPressed,

        showConnectionStatus: true,
      ),
      backgroundColor: const Color(0xFFF9FAFB),
      body: Obx(() {
        // Show empty state when no drafts available
        if (controller.hasNoDrafts) {
          return _buildEmptyState();
        }

        // Show draft SOPs list
        return _buildDraftSOPsList(controller);
      }),
    );
  }

  /// Build empty state when no draft SOPs found
  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppSizes.szW32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Empty state icon
            Icon(
              Icons.description_outlined,
              size: AppSizes.szW80,
              color: const Color(0xFF6B7280),
            ),

            SizedBox(height: AppSizes.szH24),

            // Empty state title
            Text(
              'No Draft SOPs',
              style: getTsSectionTitle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF374151),
              ),
            ),

            SizedBox(height: AppSizes.szH12),

            // Empty state description
            Text(
              'You haven\'t saved any draft SOPs yet.\nSave SOPs as drafts from the Add New SOP screen.',
              textAlign: TextAlign.center,
              style: getTsRegularText(
                fontSize: 14,
                color: const Color(0xFF6B7280),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build draft SOPs list with cards
  Widget _buildDraftSOPsList(DraftSOPListController controller) {
    return RefreshIndicator(
      onRefresh: () async {
        controller.refreshDraftSOPs();
      },
      color: const Color(0xFF12295E),
      child: Column(
        children: [
          // Header with count
          _buildListHeader(controller),

          // List of draft SOPs
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.all(AppSizes.szW16),
              itemCount: controller.draftSOPs.length,
              separatorBuilder: (context, index) =>
                  SizedBox(height: AppSizes.szH16),
              itemBuilder: (context, index) {
                final draftSOP = controller.draftSOPs[index];
                return DraftSOPCard(
                  draftSOP: draftSOP,
                  onDelete: () =>
                      _showDeleteConfirmation(context, controller, draftSOP),
                  onPublish: () =>
                      _showPublishConfirmation(context, controller, draftSOP),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Build header with draft count and refresh button
  Widget _buildListHeader(DraftSOPListController controller) {
    return Container(
      padding: EdgeInsets.all(AppSizes.szW16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFE5E7EB), width: 1)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Saved Drafts',
                  style: getTsSectionTitle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF374151),
                  ),
                ),
                SizedBox(height: AppSizes.szH4),
                Text(
                  '${controller.draftCount} ${controller.draftCount == 1 ? 'draft' : 'drafts'} saved locally',
                  style: getTsRegularText(
                    fontSize: 12,
                    color: const Color(0xFF6B7280),
                  ),
                ),
              ],
            ),
          ),
          // Refresh button
          IconButton(
            onPressed: controller.refreshDraftSOPs,
            icon: const Icon(Icons.refresh, color: Color(0xFF12295E)),
            tooltip: 'Refresh list',
          ),
        ],
      ),
    );
  }

  /// Show delete confirmation dialog
  void _showDeleteConfirmation(
    BuildContext context,
    DraftSOPListController controller,
    draftSOP,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Delete Draft',
            style: getTsSectionTitle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF374151),
            ),
          ),
          content: Text(
            'Are you sure you want to delete this draft SOP? This action cannot be undone.',
            style: getTsRegularText(
              fontSize: 14,
              color: const Color(0xFF6B7280),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style: getTsBoldText(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF6B7280),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                controller.deleteDraftSOP(draftSOP);
              },
              child: Text(
                'Delete',
                style: getTsBoldText(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFFDC3545),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  /// Show publish confirmation dialog
  void _showPublishConfirmation(
    BuildContext context,
    DraftSOPListController controller,
    draftSOP,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Publish SOP',
            style: getTsSectionTitle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF374151),
            ),
          ),
          content: Text(
            'Are you sure you want to publish this SOP? Once published, it will be available to all users and the draft will be removed.',
            style: getTsRegularText(
              fontSize: 14,
              color: const Color(0xFF6B7280),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style: getTsBoldText(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF6B7280),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                controller.publishDraftSOP(draftSOP);
              },
              child: Text(
                'Publish',
                style: getTsBoldText(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF12295E),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
