import 'package:dermaininstitute/core/common/styles/global_text_style.dart';
import 'package:dermaininstitute/core/utils/constants/sizer.dart';
import 'package:dermaininstitute/features/trainee_flow/home/controllers/home_controller.dart';
import 'package:dermaininstitute/features/trainee_flow/home/ui/widgets/recent_activity_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecentActivitySection extends StatelessWidget {
  const RecentActivitySection({super.key});

  /// format time ago from datetime
  String _getTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
    } else {
      return 'Just now';
    }
  }

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.szW24,
        vertical: AppSizes.szH14,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFFEFEFE),
        borderRadius: BorderRadius.circular(AppSizes.szR12),
        border: Border.all(color: const Color(0xFFDFE1E6)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Recent Activity', style: getTsSectionTitle(fontSize: 14)),
              Icon(
                Icons.access_time,
                size: AppSizes.szR16,
                color: const Color(0xFFB3BAC5),
              ),
            ],
          ),
          SizedBox(height: AppSizes.szH12),
          Obx(() {
            if (homeController.isLoading) {
              // show shimmer loading
              return _buildLoadingShimmer();
            }

            if (homeController.recentActivities.isEmpty) {
              // show empty state
              return _buildEmptyState();
            }

            // show recent activities list
            return Column(
              children: homeController.recentActivities.map((activity) {
                return Padding(
                  padding: EdgeInsets.only(bottom: AppSizes.szH12),
                  child: RecentActivityCard(
                    title: activity.incidentTitle,
                    subtitle: _getTimeAgo(activity.updatedAt),
                    place: activity.jurisdiction.isEmpty
                        ? 'No jurisdiction'
                        : activity.jurisdiction,
                  ),
                );
              }).toList(),
            );
          }),
        ],
      ),
    );
  }

  /// build loading shimmer effect
  Widget _buildLoadingShimmer() {
    return Column(
      children: List.generate(2, (index) {
        return Padding(
          padding: EdgeInsets.only(bottom: AppSizes.szH12),
          child: Container(
            height: AppSizes.szH80,
            padding: EdgeInsets.symmetric(
              horizontal: AppSizes.szW14,
              vertical: AppSizes.szH12,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFF9FAFB),
              borderRadius: BorderRadius.circular(AppSizes.szR6),
              border: Border.all(color: const Color(0xFFDFE1E6)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: AppSizes.szW120,
                      height: AppSizes.szH16,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE0E0E0),
                        borderRadius: BorderRadius.circular(AppSizes.szR4),
                      ),
                    ),
                    SizedBox(height: AppSizes.szH6),
                    Container(
                      width: AppSizes.szW80,
                      height: AppSizes.szH12,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE0E0E0),
                        borderRadius: BorderRadius.circular(AppSizes.szR4),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: AppSizes.szW40,
                  height: AppSizes.szH12,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE0E0E0),
                    borderRadius: BorderRadius.circular(AppSizes.szR4),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  /// build empty state when no activities
  Widget _buildEmptyState() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: AppSizes.szH24),
      child: Column(
        children: [
          Icon(
            Icons.history,
            size: AppSizes.szR32,
            color: const Color(0xFFB3BAC5),
          ),
          SizedBox(height: AppSizes.szH8),
          Text(
            'No recent activities',
            style: getTsSubTitle(fontSize: AppSizes.font14),
          ),
        ],
      ),
    );
  }
}
