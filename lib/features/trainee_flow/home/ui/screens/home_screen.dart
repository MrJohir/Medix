import 'package:dermaininstitute/core/common/styles/global_text_style.dart';
import 'package:dermaininstitute/core/common/widgets/custom_appbar.dart';
import 'package:dermaininstitute/core/common/widgets/custom_button.dart';
import 'package:dermaininstitute/core/utils/constants/colors.dart';
import 'package:dermaininstitute/core/utils/constants/icon_path.dart';
import 'package:dermaininstitute/core/utils/constants/sizer.dart';
import 'package:dermaininstitute/core/utils/helpers/svg_icon_helper.dart';
import 'package:dermaininstitute/features/trainee_flow/bottom_nav_bar/controllers/bottom_nav_bar_controller.dart';
import 'package:dermaininstitute/features/trainee_flow/home/ui/widgets/protocols_report_section.dart';
import 'package:dermaininstitute/features/trainee_flow/home/ui/widgets/recent_activity_section.dart';
import 'package:dermaininstitute/features/trainee_flow/protocols/ui/screens/protocols_screen.dart';
import 'package:dermaininstitute/features/trainee_flow/reports/views/screens/reports_screen.dart';
import 'package:dermaininstitute/features/trainee_flow/triage/controllers/triage_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../create_report/views/screens/draft_reports_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final BottomNavbarController bottomNavbarController =
      Get.find<BottomNavbarController>();
  final TriageController triageController = Get.put(TriageController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBarHelper.logoWithAvatar(),

        body: Column(
          children: [
            // Main content
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  left: AppSizes.szW20,
                  right: AppSizes.szW20,
                ),
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(
                      bottom: AppSizes.szH28,
                      top: AppSizes.szH24,
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppSizes.szW24,
                            vertical: AppSizes.szH14,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(AppSizes.szR12),
                            color: const Color(0xFFFFDDDD),
                            border: BoxBorder.all(color: Color(0xFFDB8383)),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: AppSizes.szR32,
                                backgroundColor: const Color(0xFFFFC2C2),
                                child: SvgIconHelper.buildIcon(
                                  assetPath: IconPath.warningError,
                                ),
                              ),
                              SizedBox(height: AppSizes.szH12),
                              Text(
                                'Patient Emergency',
                                style: getTsSectionTitle(
                                  color: Color(0xFFDB0000),
                                ),
                              ),
                              SizedBox(height: AppSizes.szH6),
                              Text(
                                'Immediate step-by-step guidance for aesthetic complications',
                                style: getTsSubTitle(
                                  color: Color(0xFF141617),
                                  lineHeight: 1.5,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: AppSizes.szH24),
                              ElevButton(
                                onPressed: () {
                                  bottomNavbarController.changeIndex(1);
                                  triageController.startNewChat();
                                },
                                text: 'Start Emergency Triage',
                                textStyle: getTsButtonText(),
                                paddingHeight: AppSizes.szH10,
                                backgroundColor: AppColors.primary,
                                preIcon: SvgIconHelper.buildIcon(
                                  assetPath: IconPath.zapIcon,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: AppSizes.szH24),
                        Row(
                          children: [
                            Expanded(
                              child: ProtocolsReportAndCalculatorSection(
                                onTap: () => Get.to(ProtocolsScreen()),
                                cardBackgroundColor: Color(0xFFE6F4FF),
                                circleAvatarBackgroundColor: Color(0xFFB3DFFF),
                                icon: IconPath.bookOpenIcon,
                                title: 'Protocols',
                                subtitle: 'Browse SOPs & guidelines',
                              ),
                            ),
                            SizedBox(width: AppSizes.szW16),
                            Expanded(
                              child: ProtocolsReportAndCalculatorSection(
                                onTap: () {
                                  Get.to(ReportsScreen());
                                },
                                cardBackgroundColor: Color(0xFFEBFEEB),
                                circleAvatarBackgroundColor: Color(0xFFD2FED0),
                                icon: IconPath.clipboardIcon,
                                title: 'Reports',
                                subtitle: 'Incident logs & cases',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: AppSizes.szH16),
                        SizedBox(
                          width: double.infinity,
                          child: ProtocolsReportAndCalculatorSection(
                            cardBackgroundColor: const Color(0xFFFEF0EB),
                            circleAvatarBackgroundColor: const Color(
                              0xFFFFDDD1,
                            ),
                            icon: IconPath.calculatorIcon2,
                            title: 'Calculator',
                            subtitle: 'Quick access dosing',
                            onTap: () => Get.find<BottomNavbarController>()
                                .moveToCalculator(),
                          ),
                        ),
                        // SizedBox(height: AppSizes.szH24),
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: AppSizes.szH16,
                            top: AppSizes.szH16,
                          ),
                          child: ElevButton(
                            onPressed: () {
                              Get.to(() => DraftReportsScreen());
                            },
                            text: 'Draft Reports',
                            textStyle: getTsButtonText(),
                          ),
                        ),
                        RecentActivitySection(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
