import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dermaininstitute/core/common/widgets/custom_button.dart';
import 'package:dermaininstitute/core/utils/constants/sizer.dart';
import 'package:dermaininstitute/core/utils/constants/icon_path.dart';
import '../../models/user_model.dart';
import 'custom_dropdown_field.dart';

/// Filter section widget for user management
/// Contains role and status filters with add new user button
class FilterSection extends StatelessWidget {
  final UserRole? selectedRole;
  final UserStatus? selectedStatus;
  final ValueChanged<UserRole?> onRoleChanged;
  final ValueChanged<UserStatus?> onStatusChanged;
  final VoidCallback onAddNewUser;

  const FilterSection({
    super.key,
    required this.selectedRole,
    required this.selectedStatus,
    required this.onRoleChanged,
    required this.onStatusChanged,
    required this.onAddNewUser,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Role filter dropdown
        CustomDropdownField<UserRole>(
          label: 'Role',
          hintText: 'Select role',
          value: selectedRole,
          items: UserRole.values,
          itemText: (role) => role.displayName,
          onChanged: onRoleChanged,
        ),

        SizedBox(height: AppSizes.szH12),

        // Status filter dropdown
        CustomDropdownField<UserStatus>(
          label: 'Status',
          hintText: 'Select status',
          value: selectedStatus,
          items: UserStatus.values,
          itemText: (status) => status.displayName,
          onChanged: onStatusChanged,
        ),

        SizedBox(height: AppSizes.szH12),

        // Add new user button
        ElevButton(
          onPressed: onAddNewUser,
          text: 'Add New User',
          preIcon: SvgPicture.asset(
            IconPath.icProfileAdd,
            width: AppSizes.szW20,
            height: AppSizes.szH20,
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          ),
          backgroundColor: const Color(0xFFA94907),
          fontSize: 12,
          fontWeight: FontWeight.w600,
          paddingHeight: AppSizes.szH10,
        ),
      ],
    );
  }
}
