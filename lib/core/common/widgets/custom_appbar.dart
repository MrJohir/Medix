import 'package:dermaininstitute/core/common/styles/global_text_style.dart';
import 'package:dermaininstitute/core/utils/constants/image_path.dart';
import 'package:dermaininstitute/core/utils/constants/sizer.dart';
import 'package:dermaininstitute/core/utils/helpers/svg_icon_helper.dart';
import 'package:dermaininstitute/core/utils/manager/network_manager.dart';
import 'package:dermaininstitute/features/common/settings/controllers/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

enum AppBarType { logoWithAvatar, backWithAvatar, backWithAction }

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBarType type;
  final String? title;
  final Widget? actionWidget;
  final String? actionText;
  final String? actionIcon;
  final VoidCallback? onActionPressed;
  final VoidCallback? onBackPressed;
  final String? logoImagePath;
  final Color? connectionStatusColor;
  final Widget? customLogo;
  final Color backgroundColor;
  final double elevation;
  final bool showConnectionStatus;

  CustomAppBar({
    super.key,
    required this.type,
    this.title,
    this.actionWidget,
    this.actionText,
    this.actionIcon,
    this.onActionPressed,
    this.onBackPressed,
    this.logoImagePath,
    this.connectionStatusColor,
    this.customLogo,
    this.backgroundColor = const Color(0xFFF9FAFB),
    this.elevation = 0,
    this.showConnectionStatus = true,
  });

  final SettingsController settingsController = Get.put(SettingsController());

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: elevation,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      title: _buildAppBarContent(),
    );
  }

  Widget _buildAppBarContent() {
    return Container(
      width: double.infinity,
      height: kToolbarHeight,
      padding: EdgeInsets.symmetric(horizontal: AppSizes.szW24),
      alignment: Alignment.center,
      child: _buildContentByType(),
    );
  }

  Widget _buildContentByType() {
    switch (type) {
      case AppBarType.logoWithAvatar:
        return _buildLogoWithAvatar();
      case AppBarType.backWithAvatar:
        return _buildBackWithAvatar();
      case AppBarType.backWithAction:
        return _buildBackWithAction();
    }
  }

  Widget _buildLogoWithAvatar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [_buildLogo(), _buildAvatarWithConnectionStatus()],
    );
  }

  Widget _buildBackWithAvatar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildBackButton(),
              SizedBox(width: AppSizes.szW10),
              Flexible(
                child: Text(
                  title ?? '',
                  style: getTsAppBarTitle(lineHeight: 1.0),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: AppSizes.szW40),
        _buildAvatarWithConnectionStatus(),
      ],
    );
  }

  Widget _buildBackWithAction() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildBackButton(),
              SizedBox(width: AppSizes.szW10),
              Flexible(
                child: Text(
                  title ?? '',
                  style: getTsAppBarTitle(lineHeight: 1.0),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: AppSizes.szW40),
        _buildActionButton(),
      ],
    );
  }

  Widget _buildLogo() {
    if (customLogo != null) return customLogo!;

    return SizedBox(
      width: AppSizes.szW80,
      height: AppSizes.szH30,
      child: Image.asset(
        logoImagePath ?? ImagePath.dermaInstituteIconPng,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _buildBackButton() {
    return GestureDetector(
      onTap: onBackPressed ?? () => Get.back(),
      child: Container(
        width: AppSizes.szW24,
        height: AppSizes.szH24,
        alignment: Alignment.center,
        child: Icon(
          Icons.arrow_back_ios,
          color: const Color(0xFF292D32),
          size: AppSizes.szW20,
        ),
      ),
    );
  }

  Widget _buildAvatarWithConnectionStatus() {
    return Obx(() {
      final userImage = settingsController.user.value?.image;
      final connectionStatus = Get.find<NetworkManager>().connectionStatus;

      // Determine status color
      Color statusColor =
          connectionStatusColor ??
          (connectionStatus == ConnectivityResult.none
              ? const Color(0xFFDB0000)
              : const Color(0xFF2A7900));

      return Stack(
        children: [
          CircleAvatar(
            radius: AppSizes.szR16,
            backgroundColor: Colors.grey.shade200,
            backgroundImage: (userImage != null && userImage.isNotEmpty)
                ? NetworkImage(userImage)
                : AssetImage(ImagePath.defaultAvatar),
            child: (userImage == null || userImage.isEmpty)
                ? Icon(Icons.person, size: AppSizes.szW16, color: Colors.white)
                : null,
          ),
          if (showConnectionStatus)
            Positioned(
              right: 1,
              bottom: 1,
              child: Container(
                width: AppSizes.szW8,
                height: AppSizes.szH8,
                decoration: BoxDecoration(
                  color: statusColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 0.5),
                ),
              ),
            ),
        ],
      );
    });
  }

  Widget _buildActionButton() {
    if (actionWidget != null) return actionWidget!;

    return GestureDetector(
      onTap: onActionPressed,
      child: Container(
        constraints: BoxConstraints(minWidth: AppSizes.szW120),
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.szW16,
          vertical: AppSizes.szH10,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFFA94907),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (actionIcon != null) ...[
              SvgIconHelper.buildIcon(
                assetPath: actionIcon!,
                width: AppSizes.szW20,
                height: AppSizes.szH20,
                color: Colors.white,
              ),
              SizedBox(width: AppSizes.szW6),
            ],
            Text(
              actionText ?? 'Action',
              style: getTsAppBarTitle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Optional helper to easily create different AppBar types
class AppBarHelper {
  static PreferredSizeWidget logoWithAvatar({
    String? logoImagePath,
    Color? connectionStatusColor,
    Widget? customLogo,
    Color backgroundColor = const Color(0xFFF9FAFB),
    double elevation = 0,
    bool showConnectionStatus = true,
  }) {
    return CustomAppBar(
      type: AppBarType.logoWithAvatar,
      logoImagePath: logoImagePath,
      connectionStatusColor: connectionStatusColor,
      customLogo: customLogo,
      backgroundColor: backgroundColor,
      elevation: elevation,
      showConnectionStatus: showConnectionStatus,
    );
  }

  static PreferredSizeWidget backWithAvatar({
    required String title,
    VoidCallback? onBackPressed,
    Color? connectionStatusColor,
    Color backgroundColor = const Color(0xFFF9FAFB),
    double elevation = 0,
    bool showConnectionStatus = true,
  }) {
    return CustomAppBar(
      type: AppBarType.backWithAvatar,
      title: title,
      onBackPressed: onBackPressed,
      connectionStatusColor: connectionStatusColor,
      backgroundColor: backgroundColor,
      elevation: elevation,
      showConnectionStatus: showConnectionStatus,
    );
  }

  static PreferredSizeWidget backWithAction({
    required String title,
    VoidCallback? onBackPressed,
    Widget? actionWidget,
    String? actionText,
    String? actionIcon,
    VoidCallback? onActionPressed,
    Color backgroundColor = const Color(0xFFF9FAFB),
    double elevation = 0,
  }) {
    return CustomAppBar(
      type: AppBarType.backWithAction,
      title: title,
      onBackPressed: onBackPressed,
      actionWidget: actionWidget,
      actionText: actionText,
      actionIcon: actionIcon,
      onActionPressed: onActionPressed,
      backgroundColor: backgroundColor,
    );
  }
}
