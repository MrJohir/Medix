import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dermaininstitute/core/utils/constants/sizer.dart';
import 'package:dermaininstitute/features/trainee_flow/triage/controllers/triage_controller.dart';

class EmergencyCategories extends StatelessWidget {
  const EmergencyCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final TriageController controller = Get.find<TriageController>();

    return Container(
      margin: EdgeInsets.only(bottom: AppSizes.szH16),
      height: AppSizes.szH32,
      child: Obx(() => ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: controller.selectedCategories.length,
        separatorBuilder: (context, index) => SizedBox(width: AppSizes.szW8),
        itemBuilder: (context, index) {
          final category = controller.selectedCategories[index];
          return GestureDetector(
            onTap: () {
              // Todo: API Integration - Track suggestion click for analytics
              // Example: await apiService.trackEvent('suggestion_clicked', {'category': category});
              controller.handleSuggestionClick(category);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: AppSizes.szW12, vertical: AppSizes.szH6),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(AppSizes.szR16),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Text(
                category,
                style: TextStyle(
                  fontSize: AppSizes.font12,
                  color: Colors.blue.shade700,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        },
      )),
    );
  }
}
