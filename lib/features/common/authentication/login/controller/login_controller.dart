import 'package:dermaininstitute/core/utils/helpers/app_helper.dart';
import 'package:dermaininstitute/features/common/authentication/services/auth_services.dart';

import 'package:dermaininstitute/routes/app_route.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';

class LoginController extends GetxController {
  // Controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Role
  var selectedRole = 'trainee'.obs;

  // States
  var rememberMe = false.obs;
  var isPasswordVisible = true.obs;
  var isLoading = false.obs;

  // Storage
  final box = GetStorage();

  // Service
  final AuthService _authService = AuthService();

  @override
  void onInit() {
    super.onInit();
    _loadSavedData();
  }

  @override
  void onReady() {
    super.onReady();
    // Ensure clean state when login screen is ready
    final authToken = box.read('authToken');
    if (authToken == null || authToken.toString().isEmpty) {
      debugPrint('No auth token found, forcing complete reset');
      forceCompleteReset();
    }
  }

  /// Load saved email/password if Remember Me was checked
  void _loadSavedData() {
    final savedEmail = box.read('savedEmail');
    final savedPassword = box.read('savedPassword');
    final savedRememberMe = box.read('rememberMe') ?? false;
    final authToken = box.read('authToken');

    debugPrint(
      'Loading saved data - AuthToken exists: ${authToken != null}, RememberMe: $savedRememberMe',
    );

    // ALWAYS clear fields first regardless of any condition
    forceCompleteReset();

    // Only load saved data if remember me was checked AND no current auth token
    if (savedRememberMe &&
        savedEmail != null &&
        savedPassword != null &&
        (authToken == null || authToken.toString().isEmpty)) {
      emailController.text = savedEmail;
      passwordController.text = savedPassword;
      rememberMe.value = true;
      debugPrint('Loaded saved credentials');
    } else {
      debugPrint('Not loading saved credentials - staying cleared');
    }
  }

  /// Save data to GetStorage
  void _saveData() {
    if (rememberMe.value) {
      box.write('savedEmail', emailController.text);
      box.write('savedPassword', passwordController.text);
      box.write('rememberMe', true);
    } else {
      box.remove('savedEmail');
      box.remove('savedPassword');
      box.write('rememberMe', false);
    }
  }

  /// Submit login form
  /// Submit login form
  Future<void> submitForm(GlobalKey<FormState> formKey) async {
    if (!formKey.currentState!.validate()) {
      Get.snackbar("Error", "Please fill in all fields");
      return;
    }

    isLoading.value = true;
    EasyLoading.show(
      status: "Logging in...",
      maskType: EasyLoadingMaskType.clear,
      dismissOnTap: true,
    );

    try {
      final response = await _authService.login(
        emailController.text.trim(),
        passwordController.text.trim(),
      );

      debugPrint("Login response: $response");

      if (response['success'] == true) {
        // Unwrap API body
        final Map<String, dynamic> api =
            (response['data'] as Map?)?.cast<String, dynamic>() ?? {};
        final Map<String, dynamic> inner =
            (api['data'] as Map?)?.cast<String, dynamic>() ?? {};

        // Token
        final String? token =
            (inner['accessToken'] as String?) ??
            (api['accessToken'] as String?) ??
            (api['token'] as String?);

        // User + Role
        final Map<String, dynamic> user =
            (inner['user'] as Map?)?.cast<String, dynamic>() ?? {};
        final String role = (user['role']?.toString() ?? '').toUpperCase();
        final String userId = (user['id']?.toString() ?? '');

        if (token == null || token.isEmpty) {
          debugPrint("No token found. api=$api");
          AppHelperFunctions.showAlert(
            "Oh NO! 🤦‍♂️",
            "You Enter Wrong infromation",
          );
          return;
        }

        // ✅ ALWAYS save token (regardless of rememberMe)
        box.write('authToken', token);

        // Save role & (optional) whole user
        box.write('userRole', role);
        box.write('user', user);
        box.write('userId', userId);

        // Save email/password ONLY if rememberMe is checked
        _saveData();

        // Get.snackbar(
        //   "Success",
        //   api['message']?.toString() ?? "Login successful",
        // );

        AppHelperFunctions.showSuccessSnackBar(
          api['message']?.toString() ?? "Login successful",
        );

        // Role-based navigation
        if (role == 'TRAINEE') {
          Get.offAllNamed(AppRoute.getBottomNavBarScreen());
        } else {
          Get.offAllNamed(AppRoute.getBottomNavbarAdmin());
        }
      } else {
        final msg = (response['message'] as String?) ?? "Login failed";
        Get.snackbar("Error", msg);
      }
    } catch (e, st) {
      debugPrint("Login exception: $e\n$st");
      Get.snackbar("Error", "Something went wrong. Please try again.");
    } finally {
      isLoading.value = false;
      EasyLoading.dismiss();
    }
  }

  // UI state toggles
  void selectRole(String role) => selectedRole.value = role;
  void togglePasswordVisibility() => isPasswordVisible.toggle();
  void toggleRememberMe() => rememberMe.toggle();

  void clearForm() {
    emailController.clear();
    passwordController.clear();
    // Also reset states to ensure complete clearing
    rememberMe.value = false;
    selectedRole.value = 'trainee';
    isPasswordVisible.value = true;
    debugPrint('Form cleared completely');
  }

  /// Aggressive clearing method - forces text to empty
  void forceCompleteReset() {
    // Multiple ways to clear the text controllers
    emailController.text = '';
    passwordController.text = '';
    emailController.clear();
    passwordController.clear();

    // Reset selection cursors
    emailController.selection = TextSelection.collapsed(offset: 0);
    passwordController.selection = TextSelection.collapsed(offset: 0);

    // Reset all observable states
    rememberMe.value = false;
    selectedRole.value = 'trainee';
    isPasswordVisible.value = true;
    isLoading.value = false;

    debugPrint(
      'Force complete reset done - Email: "${emailController.text}", Password: "${passwordController.text}"',
    );
  }

  void clearStorage() {
    box.remove('authToken');
    box.remove('savedEmail');
    box.remove('savedPassword');
    box.write('rememberMe', false);
    box.remove("userID");
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
