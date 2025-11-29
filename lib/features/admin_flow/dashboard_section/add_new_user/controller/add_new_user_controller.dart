import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:logger/logger.dart';
import 'dart:convert';
import '../../../../../core/api_service/NetworkCaller.dart';
import '../../../../../core/utils/constants/api_constants.dart';
import '../../../user_section/user_management/models/user_model.dart';
import '../../../user_section/user_management/controller/user_management_controller.dart';

class AddNewUserController extends GetxController {
  static final Logger _logger = Logger();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final institutionController = TextEditingController();
  final departmentController = TextEditingController();

  var roleStatus = ''.obs;
  final List<String> roleStatusItem = ['Trainee', 'Administrator'];

  var jurisdictionStatus = ''.obs;
  final List<String> jurisdictionStatusItem = [
    'United Kingdom',
    'Middle East',
    'United States',
    'Canada',
    'Australia',
    'New Zealand',
  ];

  var specilizationStatus = ''.obs;
  final List<String> specilizationStatusItem = [
    'Aesthetic Medicine',
    'Dermatology',
    'Plastic Surgery',
    'General Practice',
  ];

  RxBool accountStatus = false.obs;

  // Add loading and editing mode variables
  final RxBool isLoading = false.obs;
  final RxBool isEditMode = false.obs;
  final Rx<UserModel?> editingUser = Rx<UserModel?>(null);
  final RxString currentUserId = ''.obs;

  void toggleAccountStatus(bool value) {
    accountStatus.value = value;
  }

  /// Fetch user data by ID for editing
  Future<void> fetchUserData(String userId) async {
    try {
      isLoading.value = true;
      currentUserId.value = userId;
      _logger.i('Fetching user data for ID: $userId');

      final response = await NetworkCaller.getRequest(
        endpoint: '$getUserByIdEndpoint/$userId',
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        _logger.i('User details fetched: $responseData');

        if (responseData['satusCode'] == 200 && responseData['data'] != null) {
          // Parse the detailed user data
          final userData = UserModel.fromJson(responseData['data']);
          setEditMode(userData);
        } else {
          _logger.e('Failed to fetch user details: ${responseData['message']}');
          Get.snackbar(
            'Error',
            'Failed to load user details',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red.withValues(alpha: 0.8),
            colorText: Colors.white,
          );
        }
      } else {
        _logger.e('HTTP Error: ${response.statusCode}');
        Get.snackbar(
          'Error',
          'Failed to load user details. Please try again.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withValues(alpha: 0.8),
          colorText: Colors.white,
        );
      }
    } catch (e) {
      _logger.e('Error fetching user details: $e');
      Get.snackbar(
        'Error',
        'Error loading user details: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.8),
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Set the controller to edit mode with user data
  void setEditMode(UserModel user) {
    isEditMode.value = true;
    editingUser.value = user;

    // Pre-fill form fields with user data
    firstNameController.text = user.firstName ?? '';
    lastNameController.text = user.lastName ?? '';
    emailController.text = user.email;
    phoneNumberController.text = user.phone ?? '';
    institutionController.text = user.institution ?? '';
    departmentController.text = user.department ?? '';

    // Set dropdown values with safety checks
    roleStatus.value = _mapRoleFromApi(user.role);
    jurisdictionStatus.value = _validateJurisdiction(user.jurisdiction ?? '');
    specilizationStatus.value = _validateSpecialization(
      user.specialization ?? '',
    );

    // Set account status
    accountStatus.value = user.statusEnum == UserStatus.active;
  }

  /// Map API role to dropdown values
  String _mapRoleFromApi(String apiRole) {
    switch (apiRole.toUpperCase()) {
      case 'TRAINEE':
        return 'Trainee';
      case 'ADMIN':
        return 'Administrator';
      default:
        return 'Trainee';
    }
  }

  /// Validate jurisdiction value exists in dropdown items
  String _validateJurisdiction(String jurisdiction) {
    if (jurisdictionStatusItem.contains(jurisdiction)) {
      return jurisdiction;
    } else {
      _logger.w(
        'Jurisdiction "$jurisdiction" not found in dropdown items, using empty value',
      );
      return '';
    }
  }

  /// Validate specialization value exists in dropdown items
  String _validateSpecialization(String specialization) {
    if (specilizationStatusItem.contains(specialization)) {
      return specialization;
    } else {
      _logger.w(
        'Specialization "$specialization" not found in dropdown items, using empty value',
      );
      return '';
    }
  }

  /// Update user with PATCH API
  Future<void> updateUser() async {
    if (!isEditMode.value || editingUser.value == null) {
      Get.snackbar(
        'Error',
        'No user selected for editing',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.8),
        colorText: Colors.white,
      );
      return;
    }

    try {
      EasyLoading.show(status: 'Updating user...');
      _logger.i('Updating user: ${editingUser.value!.id}');

      // Prepare request body - the approve endpoint doesn't accept 'status' field
      final requestBody = {
        'role': _mapRoleToApi(roleStatus.value),
        'jurisdiction': jurisdictionStatus.value,
        'institution': institutionController.text.trim(),
        'department': departmentController.text.trim(),
        'specialization': specilizationStatus.value,
      };

      _logger.i('Request body: $requestBody');

      final response = await NetworkCaller.patchRequest(
        endpoint: '$updateUserEndpoint/${editingUser.value!.id}',
        body: requestBody,
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        _logger.i('User updated successfully: $responseData');

        // Update the local user model with new data
        if (responseData['data'] != null &&
            responseData['data']['user'] != null) {
          final updatedUserData = responseData['data']['user'];
          final updatedUser = UserModel.fromJson(updatedUserData);

          // Update the user in UserManagementController if it exists
          if (Get.isRegistered<UserManagementController>()) {
            final userController = Get.find<UserManagementController>();
            userController.updateLocalUser(updatedUser);
          }
        }

        EasyLoading.showSuccess('User updated successfully');

        // Navigate back to user management screen
        await Future.delayed(const Duration(seconds: 1));
        Get.back();
      } else {
        _logger.e('Failed to update user: ${response.statusCode}');

        String errorMessage = 'Failed to update user';
        try {
          final responseData = jsonDecode(response.body);
          // Handle both string and array message formats
          if (responseData['message'] is List) {
            final messages = responseData['message'] as List;
            errorMessage = messages.join(', ');
          } else if (responseData['message'] is String) {
            errorMessage = responseData['message'];
          }
        } catch (e) {
          _logger.e('Error parsing response: $e');
        }

        EasyLoading.showError(errorMessage);
      }
    } catch (e) {
      _logger.e('Error updating user: $e');
      EasyLoading.showError('Error updating user: ${e.toString()}');
    }
  }

  /// Create new user with POST API
  Future<void> createUser() async {
    try {
      // Validate required fields
      if (firstNameController.text.trim().isEmpty ||
          lastNameController.text.trim().isEmpty ||
          emailController.text.trim().isEmpty ||
          roleStatus.value.isEmpty) {
        EasyLoading.showError('Please fill in all required fields');
        return;
      }

      EasyLoading.show(status: 'Creating user...');
      _logger.i('Creating new user');

      // Prepare request body for creating new user
      final requestBody = {
        'firstName': firstNameController.text.trim(),
        'lastName': lastNameController.text.trim(),
        'email': emailController.text.trim(),
        'phone': phoneNumberController.text.trim(),
        'role': _mapRoleToApi(roleStatus.value),
        'jurisdiction': jurisdictionStatus.value,
        'institution': institutionController.text.trim(),
        'department': departmentController.text.trim(),
        'specialization': specilizationStatus.value,
        'status': accountStatus.value ? 'active' : 'inactive',
      };

      _logger.i('Create user request body: $requestBody');

      final response = await NetworkCaller.postRequest(
        endpoint: createUserEndpoint,
        body: requestBody,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        _logger.i('User created successfully: $responseData');

        // If user management controller exists, refresh the user list
        if (Get.isRegistered<UserManagementController>()) {
          final userController = Get.find<UserManagementController>();
          userController.fetchUsers(); // Refresh user list
        }

        EasyLoading.showSuccess('User created successfully');

        // Navigate back to user management screen
        await Future.delayed(const Duration(seconds: 1));
        Get.back();
      } else {
        _logger.e('Failed to create user: ${response.statusCode}');

        String errorMessage = 'Failed to create user';
        try {
          final responseData = jsonDecode(response.body);
          // Handle both string and array message formats
          if (responseData['message'] is List) {
            final messages = responseData['message'] as List;
            errorMessage = messages.join(', ');
          } else if (responseData['message'] is String) {
            errorMessage = responseData['message'];
          }
        } catch (e) {
          _logger.e('Error parsing response: $e');
        }

        EasyLoading.showError(errorMessage);
      }
    } catch (e) {
      _logger.e('Error creating user: $e');
      EasyLoading.showError('Error creating user: ${e.toString()}');
    }
  }

  /// Map dropdown role to API format
  String _mapRoleToApi(String dropdownRole) {
    switch (dropdownRole) {
      case 'Administrator':
        return 'ADMIN';
      case 'Trainee':
        return 'TRAINEE';
      default:
        return 'TRAINEE';
    }
  }

  /// Clear all form fields (for add new user mode)
  void clearForm() {
    isEditMode.value = false;
    editingUser.value = null;

    firstNameController.clear();
    lastNameController.clear();
    emailController.clear();
    phoneNumberController.clear();
    institutionController.clear();
    departmentController.clear();

    roleStatus.value = '';
    jurisdictionStatus.value = '';
    specilizationStatus.value = '';
    accountStatus.value = false;
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    institutionController.dispose();
    departmentController.dispose();
    super.onClose();
  }
}
