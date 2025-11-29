import 'package:dermaininstitute/core/utils/helpers/app_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dermaininstitute/core/common/widgets/custom_field.dart';
import 'package:dermaininstitute/core/utils/constants/colors.dart';
import 'package:dermaininstitute/core/utils/constants/sizer.dart';

import '../../controllers/settings_controller.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});

  final SettingsController controller = Get.find<SettingsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // appBar: AppBar(
      //   title: const Text('Change Password'),
      //   backgroundColor: AppColors.primary,
      // ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.szW20,
            vertical: AppSizes.szH20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Change your password',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Montserrat',
                ),
              ),
              SizedBox(height: AppSizes.szH24),

              // Current Password Field
              CustomField(
                label: 'Current Password *',
                hintText: 'Enter your current password',
                controller: controller.currentPasswordController,
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.visibility_off_outlined),
                ),
              ),
              SizedBox(height: AppSizes.szH16),

              // New Password Field
              CustomField(
                label: 'New Password *',
                hintText: 'Enter new password',
                controller: controller.newPasswordController,
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.visibility_off_outlined),
                ),
              ),
              SizedBox(height: AppSizes.szH16),

              // Confirm New Password Field
              CustomField(
                label: 'Confirm New Password *',
                hintText: 'Confirm new password',
                controller: controller.confirmPasswordController,
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.visibility_off_outlined),
                ),
              ),
              SizedBox(height: AppSizes.szH24),

              // Confirm Button
              Obx(
                () => ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    minimumSize: Size(double.infinity, AppSizes.szH52),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSizes.szR24),
                    ),
                  ),

                  onPressed: controller.isLoading.value
                      ? null
                      : () async {
                          final current = controller
                              .currentPasswordController
                              .text
                              .trim();
                          final newPass = controller.newPasswordController.text
                              .trim();
                          final confirm = controller
                              .confirmPasswordController
                              .text
                              .trim();

                          if (newPass != confirm) {
                            Get.snackbar('Error', 'Passwords do not match');
                            return;
                          }

                          bool success = await controller.changePassword(
                            currentPassword: current,
                            newPassword: newPass,
                          );

                          if (success) {
                            // Clear fields
                            controller.currentPasswordController.clear();
                            controller.newPasswordController.clear();
                            controller.confirmPasswordController.clear();
                            debugPrint('Password changed successfully');
                            Get.back();
                            AppHelperFunctions.showSuccessSnackBar(
                              "Password changed successfully",
                            );
                            // Go back to previous screen
                            // if (Get.previousRoute.isNotEmpty) {
                            //   Get.back(); // Only works if there is a previous route
                            // } else {
                            //   Get.offNamed(
                            //     '/settings',
                            //   ); // Fallback: navigate to Settings screen
                            // }
                          }
                        },

                  child: Text(
                    controller.isLoading.value ? 'Please wait...' : 'Confirm',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
