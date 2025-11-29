import 'package:dermaininstitute/core/common/widgets/custom_field.dart';
import 'package:dermaininstitute/core/utils/constants/colors.dart';
import 'package:dermaininstitute/core/utils/constants/image_path.dart';
import 'package:dermaininstitute/core/utils/constants/sizer.dart';
import 'package:dermaininstitute/core/utils/helpers/app_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../login/views/screens/login_screen.dart';
import '../../controllers/forgot_password_controller.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});

  final ForgotPasswordController forgotPasswordController = Get.put(
    ForgotPasswordController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                  'Reset Password?',
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
                'Please enter a new password & confirm to reset your password',
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
                  label: 'Password *',
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
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.visibility_off_outlined,
                      color: Color(0xFF0E1225),
                      size: 24,
                    ),
                  ),
                  controller: forgotPasswordController.newPasswordController,
                  hintText: 'Enter your new password',
                  keyboardType: TextInputType.text,
                ),
              ),
              CustomField(
                label: 'Confirm Password *',
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
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.visibility_off_outlined,
                    color: Color(0xFF0E1225),
                    size: 24,
                  ),
                ),
                controller: forgotPasswordController.confirmPasswordController,
                hintText: 'Confirm your password',
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: AppSizes.szH24),

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
                    final newPassword = forgotPasswordController
                        .newPasswordController
                        .text
                        .trim();
                    final confirmPassword = forgotPasswordController
                        .confirmPasswordController
                        .text
                        .trim();
                    if (newPassword == confirmPassword) {
                      forgotPasswordController.resetPassword();

                      Get.offAll(() => LoginScreen());
                      AppHelperFunctions.showSuccessSnackBar(
                        'Password reset successfully',
                      );
                    } else {
                      Get.snackbar('Error', 'Passwords do not match');
                    }
                  },
                  child: Text(
                    forgotPasswordController.isLoading.value
                        ? 'Please wait...'
                        : 'Confirm',
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
