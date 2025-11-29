// lib/features/common/authentication/views/signup_screen.dart
import 'package:dermaininstitute/core/common/styles/global_text_style.dart';
import 'package:dermaininstitute/core/common/widgets/custom_button.dart';
import 'package:dermaininstitute/core/common/widgets/custom_field.dart';
import 'package:dermaininstitute/core/common/widgets/custom_password_field.dart';
import 'package:dermaininstitute/core/utils/constants/app_texts.dart';
import 'package:dermaininstitute/core/utils/constants/colors.dart';
import 'package:dermaininstitute/core/utils/constants/image_path.dart';
import 'package:dermaininstitute/core/utils/constants/sizer.dart';
import 'package:dermaininstitute/core/utils/validators/app_validator.dart';
import 'package:dermaininstitute/features/common/authentication/login/controller/signup_controller.dart';
import 'package:dermaininstitute/features/common/authentication/login/views/screens/jurisdiction_screen.dart';
import 'package:dermaininstitute/features/common/authentication/login/views/widgets/role_selected_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  final GlobalKey<FormState> _signUpFormKey = GlobalKey<FormState>();

  SignUpScreen({super.key}) {
    // Make sure you don't also put this controller elsewhere for the same page.
    Get.put(SignUpController());
  }

  SignUpController get signUpController => Get.find<SignUpController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.szW20,
                vertical: AppSizes.szH20,
              ),
              child: Form(
                key: _signUpFormKey, // ✅ use the local key
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /// -- Logo
                    Image.asset(
                      ImagePath.imgLogo,
                      width: AppSizes.szW100,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(height: AppSizes.szH24),

                    /// -- Welcome Title
                    Text(
                      'Get Started now',
                      style: getTsAppBarTitle(
                        color: const Color(0xFF12295E),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: AppSizes.szH12),

                    /// -- Subtitle
                    Text(
                      'Create an account or log in to\nexplore about our app',
                      style: getTsRegularText(color: const Color(0xFF42526E)),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: AppSizes.szH26),

                    /// -- Role Selection
                    RoleSelectionButtons(
                      onTraineeSelected: () =>
                          signUpController.selectRole('trainee'),
                      onAdminSelected: () =>
                          signUpController.selectRole('admin'),
                    ),
                    SizedBox(height: AppSizes.szH20),

                    /// -- Email Field
                    CustomField(
                      label: "Email",
                      controller: signUpController.emailController,
                      validator: (value) => AppValidator.validateEmail(value),
                      hintText: "Enter your email",
                    ),
                    SizedBox(height: AppSizes.szH20),

                    /// -- Name Fields
                    Row(
                      children: [
                        Expanded(
                          child: CustomField(
                            label: "First Name",
                            controller: signUpController.firstNameController,
                            validator: (value) =>
                                AppValidator.validateEmptyText(
                                  "First Name",
                                  value,
                                ),
                            hintText: "Enter your first name",
                          ),
                        ),
                        SizedBox(width: AppSizes.szW12),
                        Expanded(
                          child: CustomField(
                            label: "Last Name",
                            controller: signUpController.lastNameController,
                            validator: (value) =>
                                AppValidator.validateEmptyText(
                                  "Last Name",
                                  value,
                                ),
                            hintText: "Enter your last name",
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: AppSizes.szH20),

                    /// -- Phone Field
                    CustomField(
                      hintText: AppText.enterPhone,
                      label: AppText.phone,
                      controller: signUpController.phoneController,
                      validator: (value) =>
                          AppValidator.validatePhoneNumber(value),
                    ),
                    SizedBox(height: AppSizes.szH20),

                    /// -- Password Field
                    CustomPasswordField(
                      controller: signUpController.passwordController,
                      validator: (value) =>
                          AppValidator.validateEmptyText("Password", value),
                    ),
                    SizedBox(height: AppSizes.szH24),

                    /// -- Registration Button
                    Obx(
                      () => ElevButton(
                        textStyle: getTsButtonText(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        text: signUpController.isLoading.value
                            ? "Registering..."
                            : "Register",
                        onPressed: () async {
                          if (_signUpFormKey.currentState!.validate()) {
                            Get.to(() => JurisdictionScreen());
                          }
                        },
                      ),
                    ),
                    SizedBox(height: AppSizes.szH24),

                    Divider(color: Colors.black.withValues(alpha: 0.12)),
                    SizedBox(height: AppSizes.szH12),

                    /// -- Already have an account?
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account? ',
                          style: getTsRegularText(
                            color: const Color(0xFF42526E),
                            lineHeight: 1.5,
                            fontSize: 16,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            // Get.offAllNamed(AppRoute.getLoginScreen());
                            Get.back();
                          },
                          child: Text(
                            'Sign in',
                            style: getTsTextButtonText(
                              color: AppColors.primary,
                              fontSize: 16,
                              lineHeight: 1.5,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
