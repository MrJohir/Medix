import 'package:dermaininstitute/core/utils/constants/colors.dart';
import 'package:dermaininstitute/core/utils/constants/sizer.dart';
import 'package:dermaininstitute/features/admin_flow/bottom_nav_bar/controller/bottoma_navbar_controller.dart';
import 'package:dermaininstitute/features/admin_flow/dashboard_section/dashboard/views/screens/dashboard_screen.dart';
import 'package:dermaininstitute/features/admin_flow/sops_section/sops/view/screen/manage_sops.dart';
import 'package:dermaininstitute/features/admin_flow/user_section/user_management/views/screens/user_management.dart';
import 'package:dermaininstitute/features/common/settings/views/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavbarAdmin extends StatelessWidget {
  BottomNavbarAdmin({super.key});

  final BottomNavbarControllerAdmin controller = Get.put(
    BottomNavbarControllerAdmin(),
  );

  final List<Widget> screens = [
    DashboardScreen(),
    ManageSOPsScreen(),
    UserManagementScreen(),
    SettingsScreen(role: "Admin"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => screens[controller.selectedIndex.value]),
      bottomNavigationBar: Obx(
        () => NavigationBarTheme(
          data: NavigationBarThemeData(
            overlayColor: WidgetStatePropertyAll(AppColors.white),
            labelTextStyle: WidgetStatePropertyAll(
              TextStyle(color: AppColors.lightGrey, fontSize: AppSizes.font12),
            ),
          ),
          child: NavigationBar(
            labelTextStyle: WidgetStateProperty.resolveWith<TextStyle?>((
              Set<WidgetState> states,
            ) {
              if (states.contains(WidgetState.selected)) {
                return TextStyle(
                  color: AppColors.primary, // Selected label color
                  fontSize: AppSizes.font12,
                  fontWeight: FontWeight.w500,
                );
              }
              return TextStyle(
                color: AppColors.lightGrey, // Unselected label color
                fontSize: AppSizes.font12,
                fontWeight: FontWeight.w400,
              );
            }),
            elevation: 9,
            indicatorColor: AppColors.white,
            backgroundColor: AppColors.white,
            shadowColor: AppColors.white.withValues(alpha: 0.5),
            selectedIndex: controller.selectedIndex.value,
            onDestinationSelected: (int index) {
              controller.changeIndex(index);
            },
            destinations: [
              NavigationDestination(
                icon: controller.selectedIndex.value == 0
                    ? Image.asset(
                        controller.activeIcons[0],
                        width: 24,
                        height: 24,
                      )
                    : Image.asset(
                        controller.inactiveIcons[0],
                        width: 24,
                        height: 24,
                      ),
                label: 'Dashboard',
              ),
              NavigationDestination(
                icon: controller.selectedIndex.value == 1
                    ? Image.asset(
                        controller.activeIcons[1],
                        width: 24,
                        height: 24,
                      )
                    : Image.asset(
                        controller.inactiveIcons[1],
                        width: 24,
                        height: 24,
                      ),
                label: 'SOPs',
              ),
              NavigationDestination(
                icon: controller.selectedIndex.value == 2
                    ? Image.asset(
                        controller.activeIcons[2],
                        width: 24,
                        height: 24,
                      )
                    : Image.asset(
                        controller.inactiveIcons[2],
                        width: 24,
                        height: 24,
                      ),
                label: 'Users',
              ),
              NavigationDestination(
                icon: controller.selectedIndex.value == 3
                    ? Image.asset(
                        controller.activeIcons[3],
                        width: 24,
                        height: 24,
                      )
                    : Image.asset(
                        controller.inactiveIcons[3],
                        width: 24,
                        height: 24,
                      ),
                label: 'Settings',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
