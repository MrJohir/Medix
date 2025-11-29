import 'package:dermaininstitute/core/common/styles/global_text_style.dart';
import 'package:dermaininstitute/core/common/widgets/custom_button.dart';
import 'package:dermaininstitute/core/common/widgets/custom_field.dart';
import 'package:dermaininstitute/core/common/widgets/custom_outline_button.dart';
import 'package:dermaininstitute/core/common/widgets/custom_password_field.dart';
import 'package:dermaininstitute/core/utils/constants/app_texts.dart';
import 'package:dermaininstitute/core/utils/constants/colors.dart';
import 'package:dermaininstitute/core/utils/constants/image_path.dart';
import 'package:dermaininstitute/core/utils/constants/sizer.dart';
import 'package:dermaininstitute/core/utils/validators/app_validator.dart';
import 'package:dermaininstitute/features/common/authentication/login/controller/login_controller.dart';
import 'package:dermaininstitute/features/common/authentication/login/views/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../forgot_password/views/screens/email_verify_screen.dart';

class LoginScreen extends StatelessWidget {
  late final LoginController loginController;
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();

  LoginScreen({super.key}) {
    loginController = Get.find<LoginController>();
  }

  @override
  Widget build(BuildContext context) {
    // Force clear fields when building login screen if no auth token
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authToken = loginController.box.read('authToken');
      if (authToken == null || authToken.toString().isEmpty) {
        debugPrint('LoginScreen: No auth token, forcing clear on build');
        loginController.forceCompleteReset();
      }
    });

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.szW20,
                vertical: AppSizes.szH20,
              ),
              child: Form(
                key: _loginFormKey,
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
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Welcome to ',
                            style: getTsAppBarTitle(
                              color: const Color(0xFF010101),
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          TextSpan(
                            text: 'DERMA INSTITUTE',
                            style: getTsAppBarTitle(
                              color: const Color(0xFF12295E),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: AppSizes.szH12),

                    /// -- Subtitle
                    Text(
                      'Your digital co-pilot for aesthetic medicine training and emergency guidance',
                      style: getTsRegularText(color: const Color(0xFF42526E)),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: AppSizes.szH26),

                    /// -- Buttons Row
                    // RoleSelectionButtons(
                    //   onTraineeSelected: () =>
                    //       loginController.selectRole('trainee'),
                    //   onAdminSelected: () =>
                    //       loginController.selectRole('admin'),
                    // ),
                    SizedBox(height: AppSizes.szH20),

                    /// -- Email Field
                    CustomField(
                      label: AppText.emailOrPass,
                      labelStyle: getTsRegularText(
                        color: AppColors.textPrimary,
                        lineHeight: 1.6,
                        fontWeight: FontWeight.w500,
                        fontSize: AppSizes.szH12,
                      ),
                      controller: loginController.emailController,
                      validator: (value) => AppValidator.validateEmail(value),
                    ),
                    SizedBox(height: AppSizes.szH20),

                    /// -- Password Field
                    CustomPasswordField(
                      controller: loginController.passwordController,
                      validator: (value) =>
                          AppValidator.validateEmptyText("Password", value),
                    ),

                    SizedBox(height: AppSizes.szH24),

                    /// -- Remember me & Forgot Password
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // Row(
                        //   children: [
                        //     // Obx(
                        //     //   () => Checkbox(
                        //     //     value: loginController.rememberMe.value,
                        //     //     onChanged: (bool? value) {
                        //     //       loginController.toggleRememberMe();
                        //     //     },
                        //     //     activeColor: const Color(0xFFA83C1D),
                        //     //   ),
                        //     // ),
                        //     Text(
                        //       'Remember me',
                        //       style: getTsRegularText(color: Colors.black),
                        //     ),
                        //   ],
                        // ),
                        TextButton(
                          onPressed: () {
                            Get.to(EmailVerifyScreen());
                          },
                          child: Text(
                            'Forgot Password ?',
                            style: getTsTextButtonText(
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: AppSizes.szH24),

                    /// -- Login Button
                    Obx(() {
                      return ElevButton(
                        textStyle: getTsButtonText(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        text: loginController.isLoading.value
                            ? "Loading..."
                            : AppText.hdLogin,
                        // onPressed: () => loginController.submitForm(_loginFormKey),
                        onPressed: () {
                          if (_loginFormKey.currentState!.validate()) {
                            loginController.submitForm(_loginFormKey);
                            // loginController.clearForm();
                          }
                        },
                      );
                    }),
                    SizedBox(height: AppSizes.szH16),

                    /// -- Create Account Button
                    OutButton(
                      // onPressed: () => Get.toNamed(AppRoute.getSignUpScreen()),
                      onPressed: () {
                        Get.to(SignUpScreen());
                      },
                      text: "Create Account",
                      color: const Color(0xFF12295E), // Text color
                      paddingHeight: 16,
                      fontSize: 16,
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
