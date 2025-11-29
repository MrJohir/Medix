import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dermaininstitute/core/common/widgets/custom_appbar.dart';
import 'package:dermaininstitute/core/common/widgets/custom_note_card.dart';
import 'package:dermaininstitute/core/common/styles/global_text_style.dart';
import 'package:dermaininstitute/core/utils/constants/sizer.dart';
import '../../controller/user_management_controller.dart';
import '../../../../bottom_nav_bar/controller/bottoma_navbar_controller.dart';
import '../widgets/custom_search_field.dart';
import '../widgets/user_card.dart';
import '../widgets/user_card_shimmer.dart';

class UserManagementScreen extends StatefulWidget {
  const UserManagementScreen({super.key});

  @override
  State<UserManagementScreen> createState() => _UserManagementScreenState();
}

class _UserManagementScreenState extends State<UserManagementScreen>
    with WidgetsBindingObserver {
  late UserManagementController controller;

  @override
  void initState() {
    super.initState();
    // Initialize controller
    controller = Get.put(UserManagementController());
    // Add observer for app lifecycle
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    // Remove observer for app lifecycle
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    // Refresh users when app comes back to foreground
    if (state == AppLifecycleState.resumed) {
      controller.refreshUsers();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBarHelper.backWithAvatar(
        title: 'User Management',
        showConnectionStatus: true,
        onBackPressed: () {
          if (Get.isRegistered<BottomNavbarControllerAdmin>()) {
            final bottomNavController = Get.find<BottomNavbarControllerAdmin>();
            bottomNavController.changeIndex(0);
          }
        },
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Main scrollable content with pull-to-refresh
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  // Call the refresh method from controller
                  await controller.refreshUsers();
                },
                color: const Color(0xFFA94907),
                backgroundColor: Colors.white,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.all(AppSizes.szW20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Search Field Section
                      _buildSearchSection(controller),

                      SizedBox(height: AppSizes.szH24),
                      // Users List Section
                      _buildUsersListSection(controller),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build search section with search field
  Widget _buildSearchSection(UserManagementController controller) {
    return CustomSearchField(
      controller: controller.searchController,
      hintText: 'Search incident logs...',
    );
  }

  /// Build users list section with user count and user cards
  Widget _buildUsersListSection(UserManagementController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Users count header
        Obx(
          () => Text(
            'Users (${controller.filteredUsersCount})',
            style: getTsSectionTitle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF141617),
            ),
          ),
        ),

        SizedBox(height: AppSizes.szH12),

        // Users list
        Obx(() => _buildUsersList(controller)),
      ],
    );
  }

  /// Build the actual users list with user cards
  Widget _buildUsersList(UserManagementController controller) {
    // Show shimmer loading when data is being fetched
    if (controller.isLoading.value) {
      return Column(
        children: List.generate(
          5,
          (index) => Padding(
            padding: EdgeInsets.only(bottom: AppSizes.szH12),
            child: AppNoteCard(color: 'White', child: const UserCardShimmer()),
          ),
        ),
      );
    }

    final users = controller.filteredUsers;

    if (users.isEmpty) {
      return _buildEmptyState(controller);
    }

    return Column(
      children: users
          .map(
            (user) => Padding(
              padding: EdgeInsets.only(bottom: AppSizes.szH12),
              child: AppNoteCard(
                color: 'White',
                child: UserCard(
                  user: user,
                  onEdit: () => controller.onEditUser(user),
                  onDelete: () => controller.onDeleteUser(user),
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  /// Build empty state when no users match the filters
  Widget _buildEmptyState(UserManagementController controller) {
    return AppNoteCard(
      color: 'White',
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(AppSizes.szR24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.people_outline,
              size: AppSizes.szW48,
              color: const Color(0xFF8993A4),
            ),

            SizedBox(height: AppSizes.szH16),

            Text(
              controller.hasActiveFilters
                  ? 'No users match your search criteria'
                  : controller.allUsers.isEmpty
                  ? 'No users found'
                  : 'No users match your filters',
              style: getTsSubTitle(
                fontSize: 16,
                color: const Color(0xFF8993A4),
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: AppSizes.szH8),

            Text(
              controller.hasActiveFilters
                  ? 'Try adjusting your search or filter criteria'
                  : controller.allUsers.isEmpty
                  ? 'Pull down to refresh or check your connection'
                  : 'Try adjusting your filter criteria',
              style: getTsRegularText(
                fontSize: 14,
                color: const Color(0xFF8993A4),
              ),
              textAlign: TextAlign.center,
            ),

            if (controller.hasActiveFilters) ...[
              SizedBox(height: AppSizes.szH16),

              TextButton(
                onPressed: controller.clearFilters,
                child: Text(
                  'Clear Filters',
                  style: getTsTextButtonText(
                    fontSize: 14,
                    color: const Color(0xFF12295E),
                  ),
                ),
              ),
            ] else if (controller.allUsers.isEmpty) ...[
              SizedBox(height: AppSizes.szH16),

              TextButton(
                onPressed: controller.refreshUsers,
                child: Text(
                  'Refresh',
                  style: getTsTextButtonText(
                    fontSize: 14,
                    color: const Color(0xFF12295E),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
