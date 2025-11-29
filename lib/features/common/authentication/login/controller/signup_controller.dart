// lib/features/common/authentication/controllers/signup_controller.dart
import 'package:dermaininstitute/core/utils/helpers/app_helper.dart';
import 'package:dermaininstitute/features/common/authentication/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  var selectedRole = 'TRAINEE'.obs;
  var isPasswordVisible = true.obs;
  var isLoading = false.obs;

  final AuthService _authService = AuthService();

  // Method called from JurisdictionScreen (validation already done)
  Future<bool> completeSignup(String jurisdiction) async {
    isLoading.value = true;
    EasyLoading.show(
      status: "conpleting...",
      maskType: EasyLoadingMaskType.clear,
      dismissOnTap: true,
    );
    try {
      await _authService.signup(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        phone: phoneController.text.trim(),
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        role: selectedRole.value,
        jurisdiction: jurisdiction,
      );

      Get.snackbar('Success', 'Account created successfully!');
      return true;
    } catch (e) {
      AppHelperFunctions.showAlert("sorry", e.toString());
      return false;
    } finally {
      isLoading.value = false;
      EasyLoading.dismiss();
    }
  }

  void selectRole(String role) => selectedRole.value = role.toUpperCase();
  void togglePasswordVisibility() => isPasswordVisible.toggle();

  @override
  void onClose() {
    emailController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
