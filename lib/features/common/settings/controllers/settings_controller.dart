import 'dart:convert';
import 'dart:io';
import 'package:dermaininstitute/core/utils/helpers/app_helper.dart';
import 'package:dermaininstitute/features/admin_flow/user_section/user_management/models/user_model.dart';
import 'package:dermaininstitute/features/common/authentication/login/controller/login_controller.dart';
import 'package:dermaininstitute/features/common/settings/services/user_services.dart';
import 'package:dermaininstitute/routes/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';

class SettingsController extends GetxController {
  // ========================================================================
  // DEPENDENCIES
  // ========================================================================
  final box = GetStorage();
  final ImagePicker _picker = ImagePicker();

  // ========================================================================
  // USER PROFILE DATA (from API)
  // ========================================================================
  var user = Rxn<UserModel>();
  var isLoading = false.obs;

  var profileImagePath = ''.obs;

  // ========================================================================
  // CONTROLLERS FOR EDITABLE FIELDS
  // ========================================================================
  late TextEditingController fullNameController;
  late TextEditingController emailController;
  late TextEditingController licenseController;
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  var specialization = ''.obs;
  var primaryJurisdiction = ''.obs;

  // ========================================================================
  // NOTIFICATIONS & SYNC
  // ========================================================================
  final isPushNotificationsEnabled = true.obs;
  final isEmergencyAlertsEnabled = true.obs;
  final isOfflineSyncEnabled = true.obs;
  final isAutoBackupEnabled = true.obs;
  final syncStatus = 'All data synchronized'.obs;
  final isDataSynced = true.obs;

  // ========================================================================
  // APP INFO
  // ========================================================================
  var appVersion = ''.obs;
  var lastUpdated = ''.obs;
  var storageUsed = ''.obs;

  // ========================================================================
  // INIT
  // ========================================================================
  @override
  void onInit() {
    super.onInit();
    fullNameController = TextEditingController();
    emailController = TextEditingController();
    licenseController = TextEditingController();

    fetchUser();
    fetchAppInfo(); // fetch real app info
  }

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    licenseController.dispose();
    super.onClose();
  }

  // ========================================================================
  // USER API METHODS
  // ========================================================================
  Future<void> fetchUser() async {
    final String? token = box.read('authToken');
    if (token == null) return;

    try {
      isLoading.value = true;
      final result = await UserService.getMe(token: token);
      if (result != null) {
        user.value = result;
        fullNameController.text = "${result.firstName} ${result.lastName}";
        emailController.text = result.email;
        licenseController.text = result.phone ?? '';
        specialization.value = result.specialization ?? '';
        primaryJurisdiction.value = result.jurisdiction ?? '';
        profileImagePath.value = result.image ?? '';
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateProfile() async {
    final String? token = box.read('authToken');
    if (token == null) {
      Get.snackbar("Error", "Authentication token missing");
      return;
    }

    try {
      EasyLoading.show(status: "Updating profile...");

      final fullName = fullNameController.text.trim();
      final nameParts = fullName.split(" ");
      final firstName = nameParts.isNotEmpty ? nameParts.first : "";
      final lastName = nameParts.length > 1
          ? nameParts.sublist(1).join(" ")
          : "";

      final updatedUser = await UserService.updateProfile(
        token: token,
        firstName: firstName,
        lastName: lastName,
        phone: licenseController.text.trim(),
        jurisdiction: primaryJurisdiction.value,
        specialization: specialization.value,
        image: profileImagePath.value.isNotEmpty
            ? File(profileImagePath.value)
            : null,
      );

      if (updatedUser != null) {
        user.value = updatedUser;
        Get.snackbar("Success", "Profile updated successfully");
      }
    } catch (e) {
      debugPrint("❌ Error updating profile: $e");
      Get.snackbar("Error", "Failed to update profile");
    } finally {
      EasyLoading.dismiss();
    }
  }

  Future<void> updateNotificationSettings() async {
    final String? token = box.read('authToken');
    if (token == null) {
      Get.snackbar("Error", "Authentication token missing");
      return;
    }

    try {
      EasyLoading.show(status: "Updating notifications...");

      // Call the NotificationService
      final Map<String, dynamic>? updatedUserJson =
          await UserService.updateNotifications(
            token: token,
            notification: user.value?.notification.toString() ?? 'false',
            emargencyAlert: user.value?.emargencyAlert.toString() ?? 'false',
          );

      if (updatedUserJson != null) {
        // Convert JSON map to UserModel
        user.value = UserModel.fromJson(updatedUserJson);
        Get.snackbar("Success", "Notification settings updated successfully");
      } else {
        Get.snackbar("Error", "Failed to update notifications");
      }
    } catch (e) {
      debugPrint("❌ Error updating notification: $e");
      Get.snackbar("Error", "Failed to update notifications");
    } finally {
      EasyLoading.dismiss();
    }
  }

  // ========================================================================
  // IMAGE PICKER
  // ========================================================================
  Future<void> pickProfileImage() async {
    try {
      final ImageSource? source = await Get.dialog<ImageSource>(
        AlertDialog(
          title: const Text('Select Image Source'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () => Get.back(result: ImageSource.camera),
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () => Get.back(result: ImageSource.gallery),
              ),
            ],
          ),
        ),
      );

      if (source != null) {
        final XFile? pickedFile = await _picker.pickImage(
          source: source,
          maxWidth: 512,
          maxHeight: 512,
          imageQuality: 80,
        );

        if (pickedFile != null) {
          profileImagePath.value = pickedFile.path;
          Get.snackbar("Success", "Profile picture updated successfully");
        }
      }
    } catch (e) {
      debugPrint('❌ Error picking image: $e');
      Get.snackbar("Error", "Failed to select image. Please try again.");
    }
  }

  // ========================================================================
  // NOTIFICATION & SYNC SETTINGS
  // ========================================================================
  void togglePushNotifications(bool value) =>
      isPushNotificationsEnabled.value = value;
  void toggleEmergencyAlerts(bool value) =>
      isEmergencyAlertsEnabled.value = value;
  void toggleOfflineSync(bool value) => isOfflineSyncEnabled.value = value;
  void toggleAutoBackup(bool value) => isAutoBackupEnabled.value = value;

  void syncNow() {
    syncStatus.value = "Syncing...";
    isDataSynced.value = false;
    Future.delayed(Duration(seconds: 2), () {
      syncStatus.value = "All data synchronized";
      isDataSynced.value = true;
    });
  }

  // ========================================================================
  // CHANGE PASSWORD
  // ========================================================================
  Future<bool> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    final String? token = box.read('authToken');
    if (token == null) {
      Get.snackbar("Error", "Authentication token missing");
      return false;
    }

    try {
      EasyLoading.show(status: "Changing password...");
      isLoading.value = true;

      final success = await UserService.resetPassword(
        token: token,
        oldPassword: currentPassword,
        newPassword: newPassword,
      );

      if (success) {
        AppHelperFunctions.showSuccessSnackBar("Password changed successfully");
        currentPasswordController.clear();
        newPasswordController.clear();
        confirmPasswordController.clear();
        return true;
      } else {
        Get.snackbar("Error", "Failed to change password");
      }
    } catch (e) {
      debugPrint('❌ Exception: $e');
      Get.snackbar("Error", "Something went wrong");
    } finally {
      isLoading.value = false;
      EasyLoading.dismiss();
    }

    return false;
  }

  // ========================================================================
  // APP INFO
  // ========================================================================
  Future<void> fetchAppInfo() async {
    try {
      // App Version
      final info = await PackageInfo.fromPlatform();
      appVersion.value = '${info.version} (${info.buildNumber})';

      // // Last Updated
      // lastUpdated.value = '2025-09-01'; // or dynamically fetch

      // Storage Used
      storageUsed.value = await _getStorageUsed();
    } catch (e) {
      debugPrint('Error fetching app info: $e');
    }
  }

  Future<String> _getStorageUsed() async {
    try {
      Directory dir = await getApplicationDocumentsDirectory();
      int size = await _getTotalSizeOfFilesInDir(dir);
      return '${(size / (1024 * 1024)).toStringAsFixed(2)} MB';
    } catch (e) {
      debugPrint('Error calculating storage: $e');
      return '0 MB';
    }
  }

  Future<int> _getTotalSizeOfFilesInDir(FileSystemEntity file) async {
    if (file is File) return await file.length();
    if (file is Directory) {
      int total = 0;
      for (var child in file.listSync()) {
        total += await _getTotalSizeOfFilesInDir(child);
      }
      return total;
    }
    return 0;
  }

  void exportData() async {
    try {
      EasyLoading.show(status: "Exporting data...");

      // Prepare user data
      final data = {
        "name": "${user.value?.firstName} ${user.value?.lastName}",
        "email": user.value?.email,
        "phone": user.value?.phone,
        "specialization": user.value?.specialization,
      };

      // Get local documents directory
      final directory = await getApplicationDocumentsDirectory();

      // Create file and write JSON
      final file = File('${directory.path}/user_data.json');
      await file.writeAsString(jsonEncode(data));

      EasyLoading.dismiss();
      Get.snackbar("Success", "Data exported locally at ${file.path}");
      debugPrint("Data exported to ${file.path}");
    } catch (e) {
      EasyLoading.dismiss();
      Get.snackbar("Error", "Failed to export data: $e");
      debugPrint("❌ Export error: $e");
    }
  }

  // ========================================================================
  // UTILITY
  // ========================================================================
  void openTermsOfService() => debugPrint("Opening Terms of Service...");
  void openPrivacyPolicy() => Get.toNamed(AppRoute.getPrivacyPolicyScreen());
  void contactSupport() => debugPrint("Opening Contact Support...");
  void updateJurisdiction(String newJurisdiction) =>
      primaryJurisdiction.value = newJurisdiction;

  void refreshSettings() => fetchUser();

  void logout() {
    debugPrint('Starting logout...');
    box.erase();
    debugPrint('Storage cleared');

    try {
      final loginController = Get.find<LoginController>();
      debugPrint('Found controller, force clearing...');

      // Use the aggressive clearing method
      loginController.forceCompleteReset();
      loginController.clearStorage();

      debugPrint(
        'Force clearing completed. Email: "${loginController.emailController.text}", Password: "${loginController.passwordController.text}"',
      );
    } catch (e) {
      debugPrint('LoginController not found during logout: $e');
    }

    Get.offAllNamed('/login');
    debugPrint('Navigated to login');

    // Additional aggressive clearing after navigation
    Future.delayed(const Duration(milliseconds: 200), () {
      try {
        final loginController = Get.find<LoginController>();
        loginController.forceCompleteReset();
        debugPrint('Post-navigation force clearing completed');
      } catch (e) {
        debugPrint('Post-navigation clearing failed: $e');
      }
    });
  }
}
