import 'package:dermaininstitute/core/common/styles/global_text_style.dart';
import 'package:dermaininstitute/core/common/widgets/custom_button.dart';
import 'package:dermaininstitute/core/utils/constants/icon_path.dart';
import 'package:dermaininstitute/core/utils/helpers/svg_icon_helper.dart';
import 'package:dermaininstitute/features/common/authentication/login/controller/login_controller.dart';
import 'package:dermaininstitute/features/common/settings/controllers/settings_controller.dart';
import 'package:dermaininstitute/features/common/settings/views/widgets/app_information_section.dart';
import 'package:dermaininstitute/features/common/settings/views/widgets/info_update_section.dart';
import 'package:dermaininstitute/features/common/settings/views/widgets/notifications_section.dart';
import 'package:dermaininstitute/features/common/settings/views/widgets/security_section.dart';
import 'package:dermaininstitute/features/common/settings/views/widgets/setting_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dermaininstitute/core/common/widgets/custom_appbar.dart';
import 'package:dermaininstitute/core/utils/constants/sizer.dart';
import 'package:dermaininstitute/routes/app_route.dart';

class SettingsScreen extends StatelessWidget {
  final String role; // Required parameter: "Admin" or "Trainee"

  SettingsScreen({super.key, required this.role});
  final LoginController loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    // Initialize controller using GetX dependency injection
    final SettingsController controller = Get.put(SettingsController());

    return Scaffold(
      backgroundColor: Color(0xFFF9FAFB),
      appBar: AppBarHelper.logoWithAvatar(
        customLogo: Text('Settings', style: getTsAppBarTitle(lineHeight: 1.0)),
        showConnectionStatus:
            true, // Will automatically show green/red based on network status
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return SettingsShimmer();
        } else {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(height: AppSizes.szH32),

                // Main Content Sections
                Column(
                  spacing: AppSizes.szH24,
                  children: [
                    // Role-based Information Section (Admin/Trainee)
                    InfoUpdateSection(controller: controller, role: role),

                    // Jurisdiction & Protocols Section
                    // JurisdictionSection(controller: controller),

                    // Notifications Section
                    NotificationsSection(controller: controller),

                    // Data & Sync Section
                    // DataSyncSection(controller: controller),

                    // Security & Privacy Section
                    SecuritySection(controller: controller),

                    // App Information Section
                    AppInformationSection(controller: controller),

                    // Logout Button - Figma Design
                    ElevButton(
                      onPressed: () {
                        // Read token & role from storage
                        final token = loginController.box.read('authToken');
                        final String role =
                            (loginController.box.read('userRole') ?? '')
                                .toString()
                                .toUpperCase();

                        if (token != null && token.toString().isNotEmpty) {
                          // ✅ Token found → clear everything
                          loginController.clearStorage();

                          // Role-based logging / messaging (optional)
                          if (role == 'TRAINEE') {
                            Get.snackbar(
                              "Logged Out",
                              "Trainee session has been cleared.",
                            );
                          } else if (role == 'ADMIN') {
                            Get.snackbar(
                              "Logged Out",
                              "Admin session has been cleared.",
                            );
                          } else {
                            Get.snackbar(
                              "Logged Out",
                              "Session has been cleared.",
                            );
                          }
                        } else {
                          // ❌ No token found → just clear form
                          loginController.clearForm();
                          Get.snackbar("Logged Out", "Thank you.");
                        }

                        // Always navigate back to login screen
                        Get.offAllNamed(AppRoute.getLoginScreen());
                      },
                      text: 'Logout',
                      backgroundColor: const Color(0xFFFFE1E1),
                      color: const Color(0xFFDB0000),
                      preIcon: SvgIconHelper.buildIcon(
                        assetPath: IconPath.icLogoutRed,
                      ),
                      radius: 50,
                      paddingHeight: 16,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),

                    SizedBox(height: AppSizes.szH4),
                  ],
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}
