import 'package:dermaininstitute/core/utils/constants/sizer.dart';
import 'package:dermaininstitute/features/trainee_flow/reports/controllers/reports_controller.dart';
import 'package:dermaininstitute/features/trainee_flow/reports/models/incident_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PriorityFilterTabs extends StatelessWidget {
   PriorityFilterTabs({super.key});

  final controller = Get.find<ReportsController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        // width: double.infinity,
        // height: AppSizes.szH48,
        padding: EdgeInsets.all(AppSizes.szW2),
        decoration: ShapeDecoration(
          color: const Color(0xFFF5F6F9),
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: Color(0xFFF5F5F9)),
            borderRadius: BorderRadius.circular(AppSizes.szR7),
          ),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: Priority.values.map((priority) {
              final isSelected = controller.selectedPriority == priority;
              return GestureDetector(
                onTap: () {
                  // Todo: API Integration - This will trigger server-side filtering
                  controller.updatePriorityFilter(priority);
                },
                child: Container(
                  // height: double.infinity,
                  margin: EdgeInsets.all(AppSizes.szR2),
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSizes.szW22,
                    vertical: AppSizes.szH14,
                  ),
                  decoration: isSelected
                      ? ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              width: 1,
                              color: Color(0xFFFEFEFE),
                            ),
                            borderRadius: BorderRadius.circular(AppSizes.szR6),
                          ),
                          shadows: const [
                            BoxShadow(
                              color: Color(0x3DE4E5E7),
                              blurRadius: 2,
                              offset: Offset(0, 1),
                              spreadRadius: 0,
                            ),
                          ],
                        )
                      : const ShapeDecoration(shape: RoundedRectangleBorder()),
                  child: Center(
                    child: Text(
                      priority.displayName,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: isSelected
                            ? const Color(0xFF050505)
                            : const Color(0xFF42526E),
                        fontSize: isSelected
                            ? AppSizes.font14
                            : AppSizes.font12,
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      );
    });
  }
}
