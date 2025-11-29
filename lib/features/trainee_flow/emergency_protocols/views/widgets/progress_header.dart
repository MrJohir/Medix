import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dermaininstitute/core/utils/constants/sizer.dart';
import 'package:dermaininstitute/features/trainee_flow/emergency_protocols/controllers/emergency_protocols_controller.dart';

class ProgressHeader extends StatelessWidget {
  const ProgressHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final EmergencyProtocolsController controller = Get.find<EmergencyProtocolsController>();

    return Container(
      padding: EdgeInsets.only(top: AppSizes.szH20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Progress text and count aligned horizontally
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Progress',
                style: TextStyle(
                  fontSize: AppSizes.font12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF141617),
                ),
              ),
              Obx(() => Text(
                '${controller.completedProtocols.value}/${controller.totalProtocols.value}',
                style: TextStyle(
                  fontSize: AppSizes.font12,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87,
                ),
              )),
            ],
          ),

          SizedBox(height: AppSizes.szH6),

          // Progress Bar
          Obx(() => Container(
            width: double.infinity,
            height: AppSizes.szH6,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              // Square corners - no border radius
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: controller.progressPercentage,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF12295E),
                  // Square corners - no border radius
                ),
              ),
            ),
          )),
        ],
      ),
    );
  }
}
