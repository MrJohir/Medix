import 'package:dermaininstitute/core/common/widgets/admin_appbar.dart';
import 'package:dermaininstitute/core/utils/constants/colors.dart';
import 'package:dermaininstitute/core/utils/constants/image_path.dart';
import 'package:dermaininstitute/core/common/widgets/custom_admin_button.dart';
import 'package:dermaininstitute/features/admin_flow/dashboard_section/add_new_user/views/widget/account_settings.dart';
import 'package:dermaininstitute/features/admin_flow/dashboard_section/add_new_user/views/widget/basic_information.dart';
import 'package:dermaininstitute/features/admin_flow/dashboard_section/add_new_user/views/widget/professional_information.dart';
import 'package:dermaininstitute/features/admin_flow/dashboard_section/add_new_user/views/widget/add_new_user_shimmer.dart';
import 'package:dermaininstitute/features/admin_flow/user_section/user_management/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../../controller/add_new_user_controller.dart';

class AddNewUser extends StatelessWidget {
  final UserModel? editUser; // Optional user for editing mode
  final String? userId; // User ID for fetching data

  const AddNewUser({super.key, this.editUser, this.userId});

  @override
  Widget build(BuildContext context) {
    // Initialize controller
    final AddNewUserController controller = Get.put(AddNewUserController());

    // Set edit mode if user data is provided directly
    if (editUser != null) {
      controller.setEditMode(editUser!);
    }
    // Or fetch user data if userId is provided
    else if (userId != null) {
      controller.fetchUserData(userId!);
    }

    return Scaffold(
      backgroundColor: AppColors.universalBackground,
      appBar: AdminAppBar(
        title: editUser != null ? 'Edit User' : 'Edit User',
        image: ImagePath.adminProfile,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: SingleChildScrollView(
          child: Obx(() {
            // show shimmer while loading user data
            if (controller.isLoading.value) {
              return Column(
                children: [
                  BasicInformationShimmer(),
                  AccountSettingsShimmer(),
                  ProfessionalInformationShimmer(),
                  SizedBox(height: 24),
                  // shimmer for buttons
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Column(
                      children: [
                        Container(
                          height: 48,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        SizedBox(height: 12),
                        Container(
                          height: 48,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 26),
                ],
              );
            }

            // show actual content when not loading
            return Column(
              children: [
                BasicInformation(controller: controller),
                AccountSettings(controller: controller),
                ProfessionalInformation(controller: controller),
                SizedBox(height: 24),
                CustomAdminButton(
                  text: 'Cancel',
                  textColor: Color(0xff12295E),
                  borderColor: Color(0xff12295E),
                  onPressed: () => Get.back(),
                ),
                CustomAdminButton(
                  text: editUser != null ? 'Update User' : 'Save User',
                  textColor: Color(0xffFFFFFF),
                  borderColor: Color(0xffA94907),
                  onPressed: () {
                    // Call appropriate method based on edit mode
                    if (controller.isEditMode.value) {
                      controller.updateUser();
                    } else {
                      controller.createUser();
                    }
                  },
                  backgroundColor: Color(0xffA94907),
                ),
                SizedBox(height: 26),
              ],
            );
          }),
        ),
      ),
    );
  }
}
