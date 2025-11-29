import 'package:dermaininstitute/core/common/styles/global_text_style.dart';
import 'package:dermaininstitute/core/utils/constants/sizer.dart';
import 'package:dermaininstitute/routes/app_route.dart';
import 'package:dermaininstitute/features/trainee_flow/reports/controllers/reports_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ReportsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFF9FAFB),
      elevation: 0,
      leadingWidth: AppSizes.szW30,
      leading: IconButton(
        padding: EdgeInsets.only(left: AppSizes.szW20),
        onPressed: () => Get.back(),
        icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
      ),
      title: Text('Reports', style: getTsAppBarTitle(lineHeight: 1)),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: AppSizes.szW20),
          child: ElevatedButton.icon(
            onPressed: () async {
              final result = await Get.toNamed(
                AppRoute.getCreateReportScreen(),
              );

              // If result is true, refresh the reports list
              if (result == true) {
                final reportsController = Get.find<ReportsController>();
                await reportsController.refreshData();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFA94907),
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.szW16,
                vertical: AppSizes.szH10,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSizes.szR50),
              ),
              elevation: 0,
            ),
            icon: Icon(Icons.add, size: AppSizes.szW20, color: Colors.white),
            label: Text(
              'New Log',
              style: TextStyle(
                fontSize: AppSizes.font12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
