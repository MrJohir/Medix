// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// /// Edit User Controller
// /// Manages the state and business logic for the Edit User screen
// /// Handles form validation, user data management, and navigation
// class EditUserController extends GetxController {
//   // Form key for validation
//   final formKey = GlobalKey<FormState>();

//   // Text editing controllers for input fields
//   final nameController = TextEditingController();
//   final institutionController = TextEditingController();
//   final jurisdictionController = TextEditingController();

//   // Observable variables for selections
//   final selectedRole = 'Administrator'.obs;
//   final selectedTag = 'Active'.obs;

//   // Loading state
//   final isLoading = false.obs;

//   // User ID for editing existing user
//   String? userId;

//   @override
//   void onInit() {
//     super.onInit();
//     // Initialize with user data if editing existing user
//     _initializeUserData();
//   }

//   @override
//   void onClose() {
//     // Dispose controllers to prevent memory leaks
//     nameController.dispose();
//     institutionController.dispose();
//     jurisdictionController.dispose();
//     super.onClose();
//   }

//   /// Initialize user data if editing existing user
//   void _initializeUserData() {
//     // Get user ID from route parameters if available
//     final arguments = Get.arguments;
//     if (arguments != null && arguments is Map<String, dynamic>) {
//       userId = arguments['userId'];

//       // Load user data based on user ID
//       if (userId != null) {
//         _loadUserData(userId!);
//       }
//     }
//   }

//   /// Load user data for editing
//   void _loadUserData(String id) {
//     // Todo: Implement API call to load user data
//     // For now, using mock data based on the Figma design
//     nameController.text = 'Sarah Johnson';
//     institutionController.text = 'London Medical School';
//     jurisdictionController.text = 'UK';
//     selectedRole.value = 'Administrator';
//     selectedTag.value = 'Active';
//   }

//   /// Handle role selection change
//   void onRoleChanged(String role) {
//     selectedRole.value = role;
//   }

//   /// Handle tag selection change
//   void onTagChanged(String tag) {
//     selectedTag.value = tag;
//   }

//   /// Validate form and save user data
//   Future<void> saveUser() async {
//     if (!formKey.currentState!.validate()) {
//       return;
//     }

//     try {
//       isLoading.value = true;

//       // Prepare user data
//       final userData = {
//         'name': nameController.text.trim(),
//         'institution': institutionController.text.trim(),
//         'jurisdiction': jurisdictionController.text.trim(),
//         'role': selectedRole.value,
//         'status': selectedTag.value,
//       };

//       // Todo: Implement API call to save user data
//       if (userId != null) {
//         // Update existing user
//         await _updateUser(userId!, userData);
//       } else {
//         // Create new user
//         await _createUser(userData);
//       }

//       // Show success message
//       Get.snackbar(
//         'Success',
//         userId != null
//             ? 'User updated successfully'
//             : 'User created successfully',
//         snackPosition: SnackPosition.TOP,
//         backgroundColor: const Color(0xFF00CB0E),
//         colorText: Colors.white,
//         duration: const Duration(seconds: 3),
//       );

//       // Navigate back to user management
//       Get.back();
//     } catch (e) {
//       // Show error message
//       Get.snackbar(
//         'Error',
//         'Failed to save user data. Please try again.',
//         snackPosition: SnackPosition.TOP,
//         backgroundColor: const Color(0xFFFF8484),
//         colorText: Colors.white,
//         duration: const Duration(seconds: 3),
//       );
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   /// Create new user
//   Future<void> _createUser(Map<String, dynamic> userData) async {
//     // Todo: Implement API call to create user
//     await Future.delayed(const Duration(seconds: 2)); // Simulate API call
//   }

//   /// Update existing user
//   Future<void> _updateUser(String id, Map<String, dynamic> userData) async {
//     // Todo: Implement API call to update user
//     await Future.delayed(const Duration(seconds: 2)); // Simulate API call
//   }

//   /// Handle cancel action
//   void onCancel() {
//     // Show confirmation dialog if form has changes
//     if (_hasFormChanges()) {
//       Get.dialog(
//         AlertDialog(
//           title: const Text('Discard Changes?'),
//           content: const Text('Are you sure you want to discard your changes?'),
//           actions: [
//             TextButton(
//               onPressed: () => Get.back(), // Close dialog
//               child: const Text('Continue Editing'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Get.back(); // Close dialog
//                 Get.back(); // Go back to previous screen
//               },
//               child: const Text('Discard'),
//             ),
//           ],
//         ),
//       );
//     } else {
//       Get.back();
//     }
//   }

//   /// Check if form has changes
//   bool _hasFormChanges() {
//     // Todo: Implement proper change detection
//     // For now, just check if any field has content
//     return nameController.text.isNotEmpty ||
//         institutionController.text.isNotEmpty ||
//         jurisdictionController.text.isNotEmpty;
//   }

//   /// Get page title based on whether editing or creating
//   String get pageTitle => 'Edit User';

//   /// Get save button text based on whether editing or creating
//   String get saveButtonText => userId != null ? 'Update' : 'Done';
// }
