import 'package:dermaininstitute/core/common/shimmer/card_shimmer.dart';
import 'package:dermaininstitute/core/common/widgets/custom_appbar.dart';
import 'package:dermaininstitute/core/utils/constants/colors.dart';
import 'package:dermaininstitute/core/utils/constants/sizer.dart';
import 'package:dermaininstitute/features/admin_flow/sops_section/sop_view/views/screens/details_view_screen.dart';
import 'package:dermaininstitute/features/trainee_flow/protocols/ui/widgets/category_chip.dart';
import 'package:dermaininstitute/features/trainee_flow/protocols/ui/widgets/location_tab.dart';
import 'package:dermaininstitute/features/trainee_flow/protocols/ui/widgets/protocol_screen_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:dermaininstitute/features/trainee_flow/protocols/controllers/protocols_controller.dart';
import 'package:dermaininstitute/features/trainee_flow/protocols/models/protocol_enums.dart';

class ProtocolsScreen extends StatelessWidget {
  ProtocolsScreen({super.key});
  final controller = Get.put(ProtocolsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarHelper.backWithAvatar(title: 'Protocols'),
      body: Column(
        children: [
          // search bar with clear functionality
          Container(
            padding: EdgeInsets.all(AppSizes.szW16),
            child: TextFormField(
              onChanged: controller.updateSearchQuery,
              decoration: InputDecoration(
                hintText: 'Search protocols...',
                prefixIcon: const Icon(Icons.search, size: 28),
                suffixIcon: Obx(
                  () => controller.searchQuery.value.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            controller.updateSearchQuery('');
                          },
                        )
                      : const SizedBox.shrink(),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSizes.szR8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSizes.szR8),
                  borderSide: BorderSide(color: AppColors.primary),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSizes.szR8),
                  borderSide: BorderSide(color: AppColors.grey),
                ),
              ),
            ),
          ),

          // location tabs - always show all locations
          Container(
            color: Color(0xffF5F6F9),
            height: 60.h,
            padding: EdgeInsets.symmetric(horizontal: AppSizes.szW16),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: ProtocolLocation.values.length,
              itemBuilder: (context, index) {
                final location = ProtocolLocation.values[index];
                return LocationTab(location: location, controller: controller);
              },
            ),
          ),

          // category chips - always show all categories
          Container(
            height: 40.h,
            margin: EdgeInsets.only(top: AppSizes.szH8, bottom: AppSizes.szH16),
            padding: EdgeInsets.symmetric(horizontal: AppSizes.szW16),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: ProtocolCategory.values.length,
              itemBuilder: (context, index) {
                final category = ProtocolCategory.values[index];
                return Padding(
                  padding: EdgeInsets.only(right: AppSizes.szW8),
                  child: CategoryChip(
                    category: category,
                    controller: controller,
                  ),
                );
              },
            ),
          ),
          // // protocols list
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const ProtocolScreenCardShimmer();
              }

              if (controller.errorMessage.value.isNotEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 64,
                        color: AppColors.error,
                      ),
                      SizedBox(height: AppSizes.szH16),
                      Text(
                        'Oops! Something went wrong',
                        style: TextStyle(
                          fontSize: AppSizes.font18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: AppSizes.szH8),
                      Text(
                        controller.errorMessage.value,
                        style: TextStyle(
                          fontSize: AppSizes.font14,
                          color: AppColors.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: AppSizes.szH24),
                      ElevatedButton.icon(
                        onPressed: controller.loadProtocols,
                        icon: const Icon(Icons.refresh),
                        label: const Text('Try Again'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                );
              }
              if (controller.filteredProtocols.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.search_off, size: 64, color: AppColors.grey),
                      SizedBox(height: AppSizes.szH16),
                      Text(
                        'No protocols found',
                        style: TextStyle(
                          fontSize: AppSizes.font18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.black,
                        ),
                      ),
                      SizedBox(height: AppSizes.szH8),
                      Text(
                        'Try adjusting your search or filters',
                        style: TextStyle(
                          fontSize: AppSizes.font14,
                          color: AppColors.grey,
                        ),
                      ),
                      SizedBox(height: AppSizes.szH16),
                      if (controller.searchQuery.value.isNotEmpty ||
                          controller.selectedLocation.value !=
                              ProtocolLocation.all ||
                          controller.selectedCategory.value !=
                              ProtocolCategory.allCategories)
                        TextButton(
                          onPressed: controller.clearFilters,
                          child: Text(
                            'Clear All Filters',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              }
              return RefreshIndicator(
                onRefresh: controller.refreshProtocols,
                color: AppColors.primary,
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: AppSizes.szW16),
                  itemCount: controller.filteredProtocols.length,
                  itemBuilder: (context, index) {
                    final sop = controller.filteredProtocols[index];
                    return Padding(
                      padding: EdgeInsets.only(bottom: AppSizes.szH16),
                      child: ProtocolScreenCard(
                        title: sop.title,
                        subTitle: sop.subtitle.isNotEmpty
                            ? sop.subtitle
                            : sop.overview,
                        location: sop.location.value,
                        categoryType: sop.category.value,
                        categoryTypeBackgroundColor:
                            sop.category.backgroundColor,
                        categoryTypeTextColor: sop.category.textColor,
                        priorityType: sop.priority.value,
                        priorityTypeTextColor: sop.priority.color,
                        dotColor: sop.priority.color,
                        date: controller.formatDate(sop.updatedDate),
                        onTap: () {
                          // navigate to protocol details
                          Get.to(() => DetailsViewScreen(sopId: sop.id));
                        },
                      ),
                    );
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
