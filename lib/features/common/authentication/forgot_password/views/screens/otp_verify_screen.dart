import 'package:dermaininstitute/core/utils/constants/colors.dart';
import 'package:dermaininstitute/core/utils/constants/image_path.dart';
import 'package:dermaininstitute/core/utils/constants/sizer.dart';
import 'package:dermaininstitute/core/utils/helpers/app_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../controllers/forgot_password_controller.dart';
import 'reset_password_screen.dart';

class OtpVerifyScreen extends StatelessWidget {
  OtpVerifyScreen({super.key});
  final ForgotPasswordController forgotPasswordController =
      Get.find<ForgotPasswordController>();
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
                  'Enter the email code',
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
                'Please enter the code we’ve sent to ****lx@gmail.com',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFF475569),
                  fontSize: 14,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w400,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: AppSizes.szH48,
                  bottom: AppSizes.szH6,
                ),
                child: PinCodeTextField(
                  length: 4,
                  obscureText: false,
                  keyboardType: TextInputType.number,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 65,
                    fieldWidth: 65,
                    activeFillColor: Color(0xFFF9FAFB),
                    selectedFillColor: Color(0xFFF9FAFB),
                    inactiveFillColor: Color(0xFFF9FAFB),
                    inactiveColor: Color(0xFFE2E8F0),
                    selectedColor: Colors.green,
                  ),
                  animationDuration: const Duration(milliseconds: 300),
                  backgroundColor: Colors.transparent,
                  enableActiveFill: true,
                  controller: forgotPasswordController.otpController,
                  appContext: context,
                ),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Didn’t get the code? Send again in',
                      style: TextStyle(
                        color: const Color(0xFF475569),
                        fontSize: 14,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w400,
                      ),
                    ),

                    TextSpan(
                      text: '0:59',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 14,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                        height: 1.43,
                        letterSpacing: 0.22,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: AppSizes.szH40),
              Obx(
                () => ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    minimumSize: Size(double.infinity, AppSizes.szH52),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSizes.szR24),
                    ),
                  ),
                  onPressed: () {
                    forgotPasswordController.verifyOtp(
                      forgotPasswordController.otpController.text.trim(),
                    );

                    Get.off(() => ResetPasswordScreen());
                    AppHelperFunctions.showSuccessSnackBar(
                      'OTP verified successfully',
                    );
                  },
                  child: Text(
                    forgotPasswordController.isLoading.value
                        ? 'Verifying...'
                        : 'Continue',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Montserrat',
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
