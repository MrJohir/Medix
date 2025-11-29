import 'package:dermaininstitute/core/common/widgets/custom_appbar.dart';
import 'package:dermaininstitute/core/utils/constants/colors.dart';
import 'package:dermaininstitute/core/utils/constants/image_path.dart';
import 'package:dermaininstitute/features/admin_flow/sops_section/sops/view/screen/manage_sops.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../core/utils/constants/sizer.dart';
import '../../../add_new_sop/views/screens/add_new_sop_screen.dart';
import '../../../add_new_sop/views/screens/draft_sop_list_screen.dart';
import '../../controller/dashboard_controller.dart';
import '../widget/custom_container.dart';
import '../widget/custom_shimmer.dart';
import '../widget/quick_actions.dart';
import '../widget/recent_activity_item.dart';
import '../widget/recent_activity_shimmer.dart';
import '../widget/reference_guide.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});
  final DashboardController controller = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.universalBackground,
      appBar: AppBarHelper.logoWithAvatar(
        logoImagePath: ImagePath.appbar,
        showConnectionStatus:
            true, // Will automatically show green/red based on network status
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              SizedBox(height: 30),

              // dashboard summary containers with shimmer effect
              Obx(() {
                if (controller.isLoading.value) {
                  return Column(
                    children: [
                      CustomShimmer(),
                      CustomShimmer(),
                      CustomShimmer(),
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      CustomContainer(
                        containerColor: AppColors.container1,
                        valueColor: Color(0xff87009F),
                        title: 'Active Users',
                        subtitle:
                            '+${controller.growthPercentage.value} from last month',
                        value: '${controller.totalCredentials.value}',
                        imagePath: ImagePath.activeUser,
                      ),
                      CustomContainer(
                        containerColor: AppColors.container2,
                        valueColor: Color(0xff1A4DBE),
                        title: 'Total SOPs',
                        subtitle: '+${controller.sopsThisWeek.value} this week',
                        value: '${controller.totalSOPs.value}',
                        imagePath: ImagePath.activeUser,
                      ),
                      CustomContainer(
                        containerColor: AppColors.container3,
                        valueColor: Color(0xffDB0000),
                        title: 'Incidents',
                        subtitle:
                            'Last ${controller.incidentReportsLast30Days.value} days',
                        value: '${controller.totalIncidentReports.value}',
                        imagePath: ImagePath.incidents,
                      ),
                    ],
                  );
                }
              }),
              Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 24),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFEFEFE),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFFDFE1E6),
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 12,
                    children: [
                      Text(
                        'Quick Actions',
                        style: TextStyle(
                          color: const Color(0xFF141617),
                          fontSize: 16,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                          height: 1.50,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(
                            () => const AddNewSopScreen(title: "Add New SOP"),
                          );
                        },
                        child: QuickActionsItem(
                          title: 'Add New SOP',
                          subtitle: 'Create emergency protocol',
                        ),
                      ),

                      InkWell(
                        onTap: () {
                          Get.to(() => ManageSOPsScreen());
                        },
                        child: QuickActionsItem(
                          title: 'Manage SOPs',
                          subtitle: 'View and edit protocols',
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(() => DraftSOPListScreen());
                        },
                        child: QuickActionsItem(
                          title: 'Draft SOPs',
                          subtitle: 'View and Publish drafts',
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.dialog(ReferenceGuide(controller: controller));
                        },
                        child: QuickActionsItem(
                          title: 'Manage Reference Guide',
                          subtitle: 'Add reference guide',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: ShapeDecoration(
                  color: const Color(0xFFFEFEFE),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: const Color(0xFFDFE1E6)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 24,
                  children: [
                    Text(
                      'Recent Activity',
                      style: TextStyle(
                        color: const Color(0xFF141617),
                        fontSize: 16,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                        height: 1.50,
                      ),
                    ),

                    // recent activity items with shimmer
                    Obx(() {
                      if (controller.isRecentActivityLoading.value) {
                        return Column(
                          children: [
                            RecentActivityShimmer(),
                            RecentActivityShimmer(),
                            RecentActivityShimmer(),
                            RecentActivityShimmer(),
                          ],
                        );
                      } else {
                        final activities = controller.getCombinedActivityList();

                        if (activities.isEmpty) {
                          return RecentActivityItem(
                            title: 'No recent activity found',
                            subtitle: 'System',
                            duration: 'Just now',
                            buttonText: 'Info',
                            buttonTextColor: Color(0xff1A4DBE),
                            buttonColor: Color(0xff1A4DBE),
                          );
                        }

                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: activities.length,
                          itemBuilder: (context, index) {
                            final activity = activities[index];
                            return Padding(
                              padding: EdgeInsets.only(
                                bottom: index == activities.length - 1 ? 0 : 24,
                              ),
                              child: RecentActivityItem(
                                title: activity['title'],
                                subtitle: activity['subtitle'],
                                duration: activity['duration'],
                                buttonText: activity['buttonText'],
                                buttonTextColor: activity['buttonColor'],
                                buttonColor: activity['buttonColor'],
                              ),
                            );
                          },
                        );
                      }
                    }),
                  ],
                ),
              ),
              SizedBox(height: AppSizes.szH20),
            ],
          ),
        ),
      ),
    );
  }
}
