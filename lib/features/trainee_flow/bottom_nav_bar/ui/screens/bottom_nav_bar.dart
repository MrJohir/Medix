import 'package:dermaininstitute/core/utils/constants/colors.dart';
import 'package:dermaininstitute/core/utils/constants/icon_path.dart';
import 'package:dermaininstitute/core/utils/constants/sizer.dart';
import 'package:dermaininstitute/core/utils/helpers/svg_icon_helper.dart';
import 'package:dermaininstitute/features/common/settings/views/screens/settings_screen.dart';
import 'package:dermaininstitute/features/trainee_flow/bottom_nav_bar/controllers/bottom_nav_bar_controller.dart';
import 'package:dermaininstitute/features/trainee_flow/calculator/views/screens/calculator_screen.dart';
import 'package:dermaininstitute/features/trainee_flow/home/ui/screens/home_screen.dart';
import 'package:dermaininstitute/features/trainee_flow/triage/views/screens/triage_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavbarScreen extends StatelessWidget {
  BottomNavbarScreen({super.key});

  final BottomNavbarController controller = Get.put(BottomNavbarController());

  final List<Widget> screens = [
    HomeScreen(),
    TriageScreen(),
    CalculatorScreen(),
    SettingsScreen(role: "Trainee",)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => screens[controller.selectedIndex.value]),
      bottomNavigationBar: Obx(
            () => NavigationBarTheme(
          data: NavigationBarThemeData(
            overlayColor: WidgetStatePropertyAll(
              Color(0xffFFFFFF).withValues(alpha: 0.1),
            ),
            labelTextStyle: WidgetStatePropertyAll(
              TextStyle(color: Color(0xff4B5563), fontSize: AppSizes.font12),
            ),
          ),
          child: NavigationBar(
            labelTextStyle: WidgetStateProperty.resolveWith<TextStyle?>((Set<WidgetState> states) {
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
            indicatorColor: Color(0xffFFFFFF),
            backgroundColor: Color(0xffFFFFFF),
            shadowColor: Color(0xff000000).withValues(alpha: 0.5),
            selectedIndex: controller.selectedIndex.value,
            onDestinationSelected: (int index) {
              controller.changeIndex(index);
            },
            destinations: [
              NavigationDestination(
                icon: controller.selectedIndex.value == 0 ? SvgIconHelper.buildIcon(
                  height: AppSizes.szH32,
                  width: AppSizes.szW32,
                  assetPath: IconPath.homeIconFilled,
                ) : SvgIconHelper.buildIcon(
                  height: AppSizes.szH28,
                  width: AppSizes.szW28,
                  assetPath: IconPath.homeIcon,
                ),
                label: 'Home',
              ),
              NavigationDestination(
                icon: controller.selectedIndex.value == 1 ? SvgIconHelper.buildIcon(
                  height: AppSizes.szH32,
                  width: AppSizes.szW32,
                  assetPath: IconPath.triageIconFilled,
                ) : SvgIconHelper.buildIcon(
                  height: AppSizes.szH25,
                  width: AppSizes.szH25,
                  assetPath: IconPath.triageIcon,
                ),
                label: 'Triage',
              ),
              NavigationDestination(
                icon: controller.selectedIndex.value == 2 ? SvgIconHelper.buildIcon(
                  height: AppSizes.szH32,
                  width: AppSizes.szW32,
                  assetPath: IconPath.calculatorIconFilled,
                ) : SvgIconHelper.buildIcon(
                  height: AppSizes.szH28,
                  width: AppSizes.szW28,
                  assetPath: IconPath.calculatorIcon,
                ),
                label: 'Calculator',
              ),
              NavigationDestination(
                icon: controller.selectedIndex.value == 3 ? SvgIconHelper.buildIcon(
                  height: AppSizes.szH32,
                  width: AppSizes.szW32,
                  assetPath: IconPath.settingsIconFilled,
                ) : SvgIconHelper.buildIcon(
                  height: AppSizes.szH28,
                  width: AppSizes.szW28,
                  assetPath: IconPath.settingsIcon,
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
