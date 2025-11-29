import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dermaininstitute/core/common/styles/global_text_style.dart';
import 'package:dermaininstitute/core/common/widgets/custom_button.dart';
import 'package:dermaininstitute/core/utils/constants/sizer.dart';
import 'package:dermaininstitute/core/utils/constants/icon_path.dart';
import 'package:dermaininstitute/core/utils/constants/image_path.dart';
import '../../models/user_model.dart';
import 'status_badge.dart';

/// User card widget displaying user information and action buttons
/// Shows user details, role, status, and provides edit/delete actions
class UserCard extends StatelessWidget {
  final UserModel user;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const UserCard({
    super.key,
    required this.user,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // User header with name, email, role, and status
        _buildUserHeader(),

        SizedBox(height: AppSizes.szH12),

        // User details (institution, jurisdiction, last login)
        _buildUserDetails(),

        SizedBox(height: AppSizes.szH12),

        // Action buttons (Edit and Delete)
        _buildActionButtons(),
      ],
    );
  }

  /// Build user header section with name, email, role, and status
  Widget _buildUserHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left side: Name and Email
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User name
              Text(
                user.fullName,
                style: getTsSubTitle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF141617),
                ),
              ),

              SizedBox(height: AppSizes.szH4),

              // User email
              Text(
                user.email,
                style: getTsRegularText(
                  fontSize: 12,
                  color: const Color(0xFF141617),
                ),
              ),
            ],
          ),
        ),

        SizedBox(width: AppSizes.szW4),

        // Right side: Role and Status badges
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Role badge
              StatusBadge.role(user.roleEnum.displayName),

              SizedBox(height: AppSizes.szH8),

              // Status badge
              StatusBadge.status(user.statusEnum.displayName),
            ],
          ),
        ),
      ],
    );
  }

  /// Build user details section with institution, jurisdiction, and last login
  Widget _buildUserDetails() {
    return Row(
      children: [
        // Labels column
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Institution:',
                style: getTsRegularText(
                  fontSize: 12,
                  color: const Color(0xFF141617),
                ),
              ),

              SizedBox(height: AppSizes.szH8),
              Text(
                'Jurisdiction:',
                style: getTsRegularText(
                  fontSize: 12,
                  color: const Color(0xFF141617),
                ),
              ),
            ],
          ),
        ),

        // Values column
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                user.institution ?? 'Not specified',
                textAlign: TextAlign.right,
                style: getTsRegularText(
                  fontSize: 12,
                  color: const Color(0xFF141617),
                ),
              ),

              SizedBox(height: AppSizes.szH8),

              Text(
                user.jurisdiction ?? 'Not specified',
                textAlign: TextAlign.right,
                style: getTsRegularText(
                  fontSize: 12,
                  color: const Color(0xFF141617),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Build action buttons section with Edit and Delete buttons
  Widget _buildActionButtons() {
    return Row(
      children: [
        // Edit button (expanded to take available space)
        Expanded(
          child: ElevButton(
            onPressed: onEdit,
            text: 'Edit',
            preIcon: SvgPicture.asset(
              IconPath.icEditPen,
              width: AppSizes.szW20,
              height: AppSizes.szH20,
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
            ),
            backgroundColor: const Color(0xFF12295E),
            fontSize: 12,
            fontWeight: FontWeight.w600,
            paddingHeight: AppSizes.szH10,
          ),
        ),

        SizedBox(width: AppSizes.szW16),

        // Delete button (circular with icon only)
        Container(
          width: AppSizes.szW40,
          height: AppSizes.szW40,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFF12295E),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onDelete,
              borderRadius: BorderRadius.circular(AppSizes.szR50),
              child: Center(
                child: Image.asset(
                  ImagePath.ivDelete,
                  width: AppSizes.szW20,
                  height: AppSizes.szH20,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
