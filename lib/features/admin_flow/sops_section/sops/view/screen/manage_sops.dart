import 'package:dermaininstitute/core/common/styles/global_text_style.dart';
import 'package:dermaininstitute/core/common/widgets/custom_appbar.dart';
import 'package:dermaininstitute/core/common/widgets/custom_button.dart';
import 'package:dermaininstitute/core/utils/constants/sizer.dart';
import 'package:dermaininstitute/features/admin_flow/bottom_nav_bar/controller/bottoma_navbar_controller.dart';
import 'package:dermaininstitute/features/admin_flow/sops_section/sops/controller/manage_sops_controller.dart';
import 'package:dermaininstitute/features/admin_flow/sops_section/sops/view/widget/filter_section.dart';
import 'package:dermaininstitute/features/admin_flow/sops_section/sops/view/widget/sop_card.dart';
import 'package:dermaininstitute/features/admin_flow/sops_section/sops/view/widget/sop_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManageSOPsScreen extends StatelessWidget {
  const ManageSOPsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the controller
    Get.put(ManageSOPsController());

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),

      // Custom AppBar with back button, title, and avatar with connection status
      appBar: AppBarHelper.backWithAvatar(
        title: 'SOPs',
        onBackPressed: () {
          Get.back();
          // Navigate back to home screen via bottom navigation
          final bottomNavController = BottomNavbarControllerAdmin.instance;
          bottomNavController.changeIndex(0); // Index 0 is home screen
        },
      ),

      body: GetBuilder<ManageSOPsController>(
        builder: (controller) {
          return SafeArea(
            child: RefreshIndicator(
              onRefresh: () async {
                // Call the refresh method from controller
                await controller.refreshSOPs();
              },
              color: const Color(0xFFA94907),
              backgroundColor: Colors.white,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.only(bottom: AppSizes.szH40),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppSizes.szW20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: AppSizes.szH32),

                      // Add New SOP Button
                      _buildAddNewSOPButton(controller),

                      SizedBox(height: AppSizes.szH24),

                      // Filter Section (Search and Filters)
                      const FilterSection(),

                      SizedBox(height: AppSizes.szH24),

                      // SOPs List
                      _buildSOPsList(controller),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  /// Build Add New SOP button
  Widget _buildAddNewSOPButton(ManageSOPsController controller) {
    return ElevButton(
      text: 'Add New SOP',
      fontSize: 14,
      fontWeight: FontWeight.w600,
      backgroundColor: const Color(0xFFA94907),
      paddingHeight: AppSizes.szH12,
      onPressed: controller.onAddNewSOP,
      preIcon: Icon(Icons.add, color: Colors.white, size: AppSizes.szW24),
    );
  }

  /// Build SOPs list with loading and empty states
  Widget _buildSOPsList(ManageSOPsController controller) {
    return Obx(() {
      // Show shimmer loading while fetching data
      if (controller.isLoading.value) {
        return const SOPsListShimmer(itemCount: 5);
      }

      // Show error state if there's an error
      if (controller.errorMessage.value.isNotEmpty) {
        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: AppSizes.szH40),
          child: _buildErrorState(controller),
        );
      }

      // Show empty state if no SOPs
      if (controller.filteredSOPs.isEmpty) {
        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: AppSizes.szH40),
          child: _buildEmptyState(),
        );
      }

      // Show SOPs list with shrinkWrap for proper scrolling
      return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.filteredSOPs.length,
        separatorBuilder: (context, index) => SizedBox(height: AppSizes.szH12),
        itemBuilder: (context, index) {
          final sop = controller.filteredSOPs[index];
          return SOPCard(sop: sop, controller: controller);
        },
      );
    });
  }

  /// Build empty state widget
  Widget _buildEmptyState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.description_outlined,
          size: AppSizes.szW80,
          color: const Color(0xFF8993A4),
        ),

        SizedBox(height: AppSizes.szH16),

        Text(
          'No SOPs Found',
          style: getTsSectionTitle(
            fontSize: 18,
            color: const Color(0xFF8993A4),
          ),
          textAlign: TextAlign.center,
        ),

        SizedBox(height: AppSizes.szH8),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.szW20),
          child: Text(
            'Try adjusting your search or filter criteria',
            style: getTsRegularText(
              fontSize: 14,
              color: const Color(0xFF8993A4),
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  /// Build error state widget
  Widget _buildErrorState(ManageSOPsController controller) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.error_outline,
          size: AppSizes.szW80,
          color: const Color(0xFFDB7906),
        ),

        SizedBox(height: AppSizes.szH16),

        Text(
          'Failed to Load SOPs',
          style: getTsSectionTitle(
            fontSize: 18,
            color: const Color(0xFFDB7906),
          ),
          textAlign: TextAlign.center,
        ),

        SizedBox(height: AppSizes.szH8),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.szW20),
          child: Text(
            controller.errorMessage.value,
            style: getTsRegularText(
              fontSize: 14,
              color: const Color(0xFF8993A4),
            ),
            textAlign: TextAlign.center,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ),

        SizedBox(height: AppSizes.szH20),

        // Retry button
        ElevButton(
          text: 'Retry',
          fontSize: 14,
          fontWeight: FontWeight.w600,
          backgroundColor: const Color(0xFFA94907),
          paddingHeight: AppSizes.szH10,
          onPressed: controller.refreshSOPs,
          preIcon: Icon(
            Icons.refresh,
            color: Colors.white,
            size: AppSizes.szW20,
          ),
        ),
      ],
    );
  }
}
