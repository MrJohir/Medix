import 'package:dermaininstitute/core/utils/constants/colors.dart';
import 'package:dermaininstitute/core/utils/constants/icon_path.dart';
import 'package:dermaininstitute/core/utils/constants/image_path.dart';
import 'package:dermaininstitute/core/utils/constants/sizer.dart';
import 'package:dermaininstitute/core/common/widgets/custom_button.dart';
import 'package:dermaininstitute/core/common/styles/global_text_style.dart';
import 'package:dermaininstitute/core/utils/helpers/svg_icon_helper.dart';
import 'package:dermaininstitute/features/common/authentication/login/controller/jurisdiction_controller.dart';
import 'package:dermaininstitute/features/common/authentication/login/controller/signup_controller.dart';
import 'package:dermaininstitute/features/common/authentication/login/views/widgets/jurisdiction_dropdown.dart';
import 'package:dermaininstitute/routes/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class JurisdictionScreen extends StatelessWidget {
  final JurisdictionController controller = Get.put(JurisdictionController());
  final SignUpController signupicontroller = Get.find<SignUpController>();

  JurisdictionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(
                left: AppSizes.szW20,
                right: AppSizes.szW20,
                top: AppSizes.szH50,
                bottom: AppSizes.szH50,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /// -- Logo
                  Image.asset(
                    ImagePath.imgLogo,
                    width: AppSizes.szW100,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height: AppSizes.szH50),

                  /// -- Jurisdiction Card
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEFEFE),
                      borderRadius: BorderRadius.circular(AppSizes.szR24),
                      border: Border.all(
                        color: const Color(0xFFDFE1E6),
                        width: 1,
                      ),
                    ),
                    padding: EdgeInsets.all(AppSizes.szH24),
                    child: Column(
                      children: [
                        /// -- Earth Icon
                        Container(
                          width: 65.w,
                          height: 65.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFFECFDEC),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(AppSizes.szR16),
                            child: SvgIconHelper.buildIcon(
                              assetPath: IconPath.icWorld,
                            ),
                          ),
                        ),
                        SizedBox(height: AppSizes.szH8),

                        /// -- Title
                        Text(
                          'Select Your Jurisdiction',
                          style: getTsAppBarTitle(
                            color: const Color(0xFF12295E),
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: AppSizes.szH14),

                        /// -- Subtitle
                        Text(
                          'Choose your primary practice location to customize protocols and regulations',
                          style: getTsRegularText(
                            color: const Color(0xFF253858),
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: AppSizes.szH24),

                        /// -- Select Jurisdiction Dropdown
                        Obx(
                          () => JurisdictionDropdown(
                            selectedCountry: controller.selectedCountry.value,
                            isExpanded: controller.isExpanded.value,
                            onToggle: (expanded) {
                              controller.toggleExpanded();
                            },
                            onChanged: (country) {
                              controller.setSelectedCountry(country);
                            },
                          ),
                        ),
                        SizedBox(height: AppSizes.szH24),

                        /// -- Details Text
                        Text(
                          "This selection will customize your emergency protocols, dosing guidelines, and regulatory requirements to match your local jurisdiction's standards.",
                          style: getTsRegularText(
                            color: const Color(0xFF253858),
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 6,
                        ),
                        SizedBox(height: AppSizes.szH32),

                        /// -- Complete Setup Button
                        ElevButton(
                          text: "Complete Setup",
                          onPressed: () async {
                            // <-- mark async
                            if (controller.selectedCountry.value.isNotEmpty) {
                              bool success = await signupicontroller
                                  .completeSignup(
                                    controller.selectedCountry.value,
                                  ); // <-- await the future

                              if (success) {
                                Get.offAllNamed(AppRoute.getLoginScreen());
                              }
                            } else {
                              Get.snackbar(
                                'Error',
                                'Please select a jurisdiction',
                              );
                            }
                          },
                          backgroundColor: AppColors.primary,
                          fontSize: 16,
                        ),

                        SizedBox(height: AppSizes.szH18),

                        /// -- Back Button
                        TextButton(
                          onPressed: () => Get.back(),
                          child: Text(
                            'Back',
                            style: getTsTextButtonText(
                              color: const Color(0xFFA83C1D),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
