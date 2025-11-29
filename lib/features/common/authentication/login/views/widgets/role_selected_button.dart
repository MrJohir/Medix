import 'package:dermaininstitute/core/common/styles/global_text_style.dart';
import 'package:dermaininstitute/core/utils/constants/sizer.dart';
import 'package:dermaininstitute/features/common/authentication/login/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RoleSelectionButtons extends StatelessWidget {
  final VoidCallback onTraineeSelected;
  final VoidCallback onAdminSelected;

  const RoleSelectionButtons({
    super.key,
    required this.onTraineeSelected,
    required this.onAdminSelected,
  });

  @override
  Widget build(BuildContext context) {
    final LoginController controller = Get.find<LoginController>();

    return Container(
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F8),
        borderRadius: BorderRadius.circular(AppSizes.szR7),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Trainee Button (Active)
          Expanded(
            child: GestureDetector(
              onTap: () {
                onTraineeSelected();
                controller.selectRole('trainee');
              },
              child: Obx(() {
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: controller.selectedRole.value == 'trainee'
                        ? Colors.white
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(AppSizes.szR6),
                    boxShadow: controller.selectedRole.value == 'trainee'
                        ? [
                            BoxShadow(
                              color: Colors.grey.withValues(alpha: 0.1),
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            ),
                          ]
                        : [],
                  ),
                  child: Text(
                    'Trainee',
                    style: controller.selectedRole.value == 'trainee'
                        ? getTsButtonText(
                            color: const Color(0xFF050505),
                            fontSize: 14,
                            lineHeight: 1.3,
                          )
                        : getTsButtonText(
                            color: const Color(0xFF42526E),
                            fontWeight: FontWeight.w500,
                          ),
                    textAlign: TextAlign.center,
                  ),
                );
              }),
            ),
          ),

          // Administrator Button (Inactive)
          Expanded(
            child: GestureDetector(
              onTap: () {
                onAdminSelected();
                controller.selectRole('admin');
              },
              child: Obx(() {
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: controller.selectedRole.value == 'admin'
                        ? Colors.white
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(AppSizes.szR6),
                    boxShadow: controller.selectedRole.value == 'admin'
                        ? [
                            BoxShadow(
                              color: Colors.grey.withValues(alpha: 0.1),
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            ),
                          ]
                        : [],
                  ),
                  child: Text(
                    'Administrator',
                    style: controller.selectedRole.value == 'admin'
                        ? getTsButtonText(
                            color: const Color(0xFF050505),
                            fontSize: 14,
                            lineHeight: 1.3,
                          )
                        : getTsButtonText(
                            color: const Color(0xFF42526E),
                            fontWeight: FontWeight.w500,
                          ),
                    textAlign: TextAlign.center,
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
