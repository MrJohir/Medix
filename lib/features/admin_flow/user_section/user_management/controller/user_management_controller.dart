import 'package:dermaininstitute/features/admin_flow/dashboard_section/add_new_user/views/screens/add_new_user.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:logger/logger.dart';
import 'dart:convert';
import '../../../../../core/api_service/NetworkCaller.dart';
import '../../../../../core/utils/constants/api_constants.dart';
import '../models/user_model.dart';

class UserManagementController extends GetxController {
  static final Logger _logger = Logger();

  /// Search controller for user search functionality
  final TextEditingController searchController = TextEditingController();

  /// List of all users from API
  final RxList<UserModel> _allUsers = <UserModel>[].obs;

  /// Filtered users based on search and filters
  final RxList<UserModel> filteredUsers = <UserModel>[].obs;

  /// Selected role filter
  final Rx<UserRole?> selectedRole = Rx<UserRole?>(null);

  /// Selected status filter
  final Rx<UserStatus?> selectedStatus = Rx<UserStatus?>(null);

  /// Loading state
  final RxBool isLoading = false.obs;

  /// Search text
  final RxString searchText = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _setupSearchListener();
    fetchUsers();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  /// Fetch users from API
  Future<void> fetchUsers() async {
    try {
      isLoading.value = true;
      _logger.i('Fetching users from API...');

      final response = await NetworkCaller.getRequest(
        endpoint: getAllUsersEndpoint,
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        _logger.i('API Response: $responseData');

        if (responseData['statusCode'] == 200 && responseData['data'] != null) {
          final List<dynamic> usersJson = responseData['data'];
          final List<UserModel> users = usersJson
              .map((json) => UserModel.fromJson(json))
              .toList();

          _allUsers.value = users;
          _applyFilters();

          _logger.i('Successfully fetched ${users.length} users');
        } else {
          _logger.e('API returned error: ${responseData['message']}');
          EasyLoading.showError(
            'Failed to load users: ${responseData['message']}',
          );
        }
      } else {
        _logger.e('HTTP Error: ${response.statusCode}');
        EasyLoading.showError('Failed to load users. Please try again.');
      }
    } catch (e) {
      _logger.e('Error fetching users: $e');
      EasyLoading.showError('Error loading users: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  /// Setup listener for search text changes
  void _setupSearchListener() {
    searchController.addListener(() {
      searchText.value = searchController.text;
      _applyFilters();
    });
  }

  /// Apply search and filter criteria to users list
  void _applyFilters() {
    List<UserModel> filtered = List.from(_allUsers);

    // Apply search filter
    if (searchText.value.isNotEmpty) {
      filtered = filtered.where((user) {
        final searchLower = searchText.value.toLowerCase();
        return user.fullName.toLowerCase().contains(searchLower) ||
            user.email.toLowerCase().contains(searchLower) ||
            (user.institution?.toLowerCase().contains(searchLower) ?? false) ||
            (user.jurisdiction?.toLowerCase().contains(searchLower) ?? false);
      }).toList();
    }

    // Apply role filter
    if (selectedRole.value != null) {
      filtered = filtered
          .where((user) => user.roleEnum == selectedRole.value)
          .toList();
    }

    // Apply status filter
    if (selectedStatus.value != null) {
      filtered = filtered
          .where((user) => user.statusEnum == selectedStatus.value)
          .toList();
    }

    filteredUsers.value = filtered;
  }

  /// Handle role filter change
  void onRoleFilterChanged(UserRole? role) {
    selectedRole.value = role;
    _applyFilters();
  }

  /// Handle status filter change
  void onStatusFilterChanged(UserStatus? status) {
    selectedStatus.value = status;
    _applyFilters();
  }

  /// Handle add new user action
  void onAddNewUser() async {
    _logger.i('Navigating to add new user screen...');

    // Navigate to add user screen and wait for return
    await Get.to(() => AddNewUser());

    // When user returns from add user screen, refresh the list
    _logger.i('Returned from add new user screen, refreshing users...');
    await refreshUsers();
  }

  /// Handle edit user action
  void onEditUser(UserModel user) async {
    _logger.i('Edit user clicked for: ${user.fullName} (ID: ${user.id})');

    try {
      // Navigate to AddNewUser screen first, it will handle its own loading
      await Get.to(() => AddNewUser(userId: user.id, editUser: user));

      // Refresh users list when returning
      _logger.i('Returned from edit user screen, refreshing users...');
      await refreshUsers();
    } catch (e) {
      _logger.e('Error navigating to edit user: $e');
      EasyLoading.showError('Error opening edit screen: ${e.toString()}');
    }
  }

  /// Refresh users data
  Future<void> refreshUsers() async {
    await fetchUsers();
  }

  /// Force refresh users (can be called from external sources)
  /// This is useful when other screens add/edit users
  static void forceRefreshIfExists() {
    if (Get.isRegistered<UserManagementController>()) {
      final controller = Get.find<UserManagementController>();
      controller.refreshUsers();
    }
  }

  /// Update a single user in the local list (used after updating user data)
  void updateLocalUser(UserModel updatedUser) {
    final index = _allUsers.indexWhere((user) => user.id == updatedUser.id);
    if (index != -1) {
      _allUsers[index] = updatedUser;
      _applyFilters();
      _logger.i('Updated local user: ${updatedUser.fullName}');
    } else {
      // If user not found, add it to the list (in case it's a newly approved user)
      _allUsers.add(updatedUser);
      _applyFilters();
      _logger.i('Added new user to local list: ${updatedUser.fullName}');
    }
  }

  /// Handle delete user action
  void onDeleteUser(UserModel user) {
    Get.dialog(
      AlertDialog(
        title: const Text('Delete User'),
        content: Text('Are you sure you want to delete ${user.fullName}?'),
        actions: [
          TextButton(
            onPressed: () {
              Get.back(); // Close dialog without deleting
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Get.back(); // Close dialog first
              _deleteUser(user); // Then delete the user
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
      barrierDismissible: true,
    );
  }

  /// Delete user from list
  Future<void> _deleteUser(UserModel user) async {
    try {
      // set loading state for shimmer
      isLoading.value = true;
      _logger.i('Deleting user: ${user.id}');

      final response = await NetworkCaller.deleteRequest(
        endpoint: '$deleteUserEndpoint/${user.id}',
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        _logger.i('User deleted successfully');

        // Remove user from local list
        _allUsers.removeWhere((u) => u.id == user.id);
        // Reapply filters to update the displayed list
        _applyFilters();

        // Show success message
        Get.snackbar(
          'Success',
          '${user.fullName} has been deleted successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withValues(alpha: 0.8),
          colorText: Colors.white,
        );
      } else {
        _logger.e('Failed to delete user: ${response.statusCode}');

        // Try to parse error message from response
        String errorMessage = 'Failed to delete user';
        try {
          final responseData = jsonDecode(response.body);
          errorMessage = responseData['message'] ?? errorMessage;
        } catch (e) {
          _logger.e('Error parsing response: $e');
        }

        Get.snackbar(
          'Error',
          errorMessage,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withValues(alpha: 0.8),
          colorText: Colors.white,
        );
      }
    } catch (e) {
      _logger.e('Error deleting user: $e');
      Get.snackbar(
        'Error',
        'Error deleting user: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.8),
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Clear all filters
  void clearFilters() {
    selectedRole.value = null;
    selectedStatus.value = null;
    searchController.clear();
    _applyFilters();
  }

  /// Get total users count
  int get totalUsersCount => _allUsers.length;

  /// Get all users list (for checking if empty)
  List<UserModel> get allUsers => _allUsers;

  /// Get filtered users count
  int get filteredUsersCount => filteredUsers.length;

  /// Check if any filters are active
  bool get hasActiveFilters {
    return selectedRole.value != null ||
        selectedStatus.value != null ||
        searchText.value.isNotEmpty;
  }
}
