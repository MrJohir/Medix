import 'package:dermaininstitute/core/common/widgets/custom_field.dart';
import 'package:dermaininstitute/core/utils/constants/colors.dart';
import 'package:dermaininstitute/core/utils/helpers/app_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../core/utils/constants/image_path.dart';
import '../../../../../../core/utils/constants/sizer.dart';
import '../../controllers/forgot_password_controller.dart';
import 'otp_verify_screen.dart';

class EmailVerifyScreen extends StatelessWidget {
  EmailVerifyScreen({super.key});
  final ForgotPasswordController forgotPasswordController = Get.put(
    ForgotPasswordController(),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.szW20,
            vertical: AppSizes.szH20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  ImagePath.imgLogo,
                  width: AppSizes.szW100,
                  fit: BoxFit.contain,
                ),
              ),

              Padding(
                padding: EdgeInsets.only(
                  top: AppSizes.szH80,
                  bottom: AppSizes.szH10,
                ),
                child: Text(
                  'Forgot Password?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFFA94907),
                    fontSize: 28,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w700,
                    height: 1.50,
                  ),
                ),
              ),
              Text(
                'Enter your email and we’ll send you a password reset link.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFF42526E),
                  fontSize: 14,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w400,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: AppSizes.szH48,
                  bottom: AppSizes.szH24,
                ),
                child: CustomField(
                  label: 'Email *',
                  labelStyle: TextStyle(
                    color: const Color(0xFF1C2028),
                    fontSize: 14,
                    fontFamily: 'Manrope',
                    fontWeight: FontWeight.w500,
                    height: 1.43,
                    letterSpacing: 0.22,
                  ),
                  hintStyle: TextStyle(
                    color: const Color(0xFF0E1225),
                    fontSize: 14,
                    fontFamily: 'Manrope',
                    fontWeight: FontWeight.w400,
                    height: 1.43,
                    letterSpacing: 0.22,
                  ),
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    size: 24,
                    color: Color(0xFF0E1225),
                  ),
                  controller: forgotPasswordController.emailController,
                  hintText: 'Enter your email',
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  minimumSize: Size(double.infinity, AppSizes.szH52),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSizes.szR24),
                  ),
                ),
                onPressed: () {
                  forgotPasswordController
                      .sendPasswordResetOtp(
                        forgotPasswordController.emailController.text.trim(),
                      )
                      .then((value) => Get.off(() => OtpVerifyScreen()));
                  AppHelperFunctions.showSuccessSnackBar(
                    'OTP sent successfully!',
                  );
                },
                child: Text(
                  'Send',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: AppSizes.szH24),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Don’t have an account?',
                      style: TextStyle(
                        color: const Color(0xFF1C2028),
                        fontSize: 14,
                        fontFamily: 'Manrope',
                        fontWeight: FontWeight.w500,
                        height: 1.43,
                        letterSpacing: 0.22,
                      ),
                    ),

                    WidgetSpan(
                      child: GestureDetector(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            'Register Now',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xFFA94907),
                              fontSize: 14,
                              fontFamily: 'Manrope',
                              fontWeight: FontWeight.w500,
                              height: 1.43,
                              letterSpacing: 0.22,
                            ),
                          ),
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
    );
  }
}
