import 'package:dermaininstitute/features/common/authentication/forgot_password/forget_pass_services/forget_password_services.dart';
import 'package:dermaininstitute/features/common/authentication/forgot_password/forget_pass_services/otp_verify_services.dart';
import 'package:dermaininstitute/features/common/authentication/forgot_password/forget_pass_services/reset_password_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/state_manager.dart';

class ForgotPasswordController extends GetxController {
  final forgotPasswordKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final otpController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  ////services
  final ForgetPasswordServices _forgetPasswordServices =
      ForgetPasswordServices();
  final OtpVerifyService _otpVerifyServices = OtpVerifyService();
  final ResetPasswordService _resetPasswordService = ResetPasswordService();

  ////for loading
  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final successMessage = ''.obs;

  Future<void> sendPasswordResetOtp(String email) async {
    try {
      isLoading(true);
      EasyLoading.show(
        status: "waiting...",
        maskType: EasyLoadingMaskType.clear,
      );
      errorMessage('');
      successMessage('');

      final response = await _forgetPasswordServices.sendPasswordResetOtp(
        email,
      );

      if (response['success'] == true) {
        successMessage(
          response['message'] ?? 'Password reset link sent successfully',
        );
      } else {
        errorMessage('Failed to send password reset OTP');
      }
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
      EasyLoading.dismiss();
    }
  }

  Future<void> verifyOtp(String otp) async {
    try {
      EasyLoading.show(
        status: "Verifying OTP...",
        maskType: EasyLoadingMaskType.clear,
      );
      isLoading(true);
      errorMessage('');

      final response = await _otpVerifyServices.verifyOtp(otp);

      if (response['success'] == true) {
        debugPrint('OTP verified successfully');
        successMessage(response['message'] ?? 'OTP verified successfully');
        debugPrint(response['message']);
      } else {
        errorMessage('Failed to verify OTP');
      }
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
      EasyLoading.dismiss();
    }
  }

  Future<void> resetPassword() async {
    try {
      EasyLoading.show(
        status: "Resetting Password...",
        maskType: EasyLoadingMaskType.clear,
      );
      isLoading(true);
      errorMessage('');

      final response = await _resetPasswordService.resetPassword(
        newPasswordController.text.trim(),
      );

      if (response['success'] == true) {
        debugPrint('Password reset successfully');
        successMessage(response['message'] ?? 'Password reset successfully');
        debugPrint(response['message']);
      } else {
        errorMessage('Failed to reset password');
      }
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
      EasyLoading.dismiss();
    }
  }

  // void clear() {
  //   emailController.clear();
  //   otpController.clear();
  //   newPasswordController.clear();
  //   confirmPasswordController.clear();
  //   super.onClose();
  // }
}
