import 'package:dermaininstitute/core/utils/constants/icon_path.dart';
import 'package:dermaininstitute/core/utils/constants/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgIconHelper {
  static Widget buildIcon({
    required String assetPath,
    double? width,
    double? height,
    Color? color,
    BoxFit fit = BoxFit.contain,
    VoidCallback? onTap,
  }) {
    return SvgPicture.asset(
      assetPath,
      width: width ?? AppSizes.szW24,
      height: height ?? AppSizes.szH24,
      colorFilter: color != null
          ? ColorFilter.mode(color, BlendMode.srcIn)
          : null,
      fit: fit,
    );
  }

  // Enhanced version with tap handler
  static Widget buildIconWithTap({
    required String assetPath,
    double? width,
    double? height,
    Color? color,
    VoidCallback? onTap,
    BoxFit fit = BoxFit.contain,
  }) {
    final iconWidget = buildIcon(
      assetPath: assetPath,
      width: width ?? AppSizes.szW24,
      height: height ?? AppSizes.szH24,
      color: color,
      fit: fit,
    );

    if (onTap != null) {
      return GestureDetector(onTap: onTap, child: iconWidget);
    }

    return iconWidget;
  }

  // Specific icon builders for common use cases
  static Widget notificationIcon({
    double? width,
    double? height,
    Color? color,
  }) {
    return buildIcon(
      assetPath: IconPath.notificationsActiveIcon,
      width: width ?? AppSizes.szW24,
      height: height ?? AppSizes.szH24,
      color: color,
    );
  }

  static Widget backIcon({
    double? width,
    double? height,
    Color? color,
  }) {
    return buildIcon(
      assetPath: IconPath.icBack,
      width: width ?? AppSizes.szW24,
      height: height ?? AppSizes.szH24,
      color: color,
    );
  }

  static Widget searchIcon({
    double? width,
    double? height,
    Color? color,
  }) {
    return buildIcon(
      assetPath: IconPath.searchIcon,
      width: width ?? AppSizes.szW20,
      height: height ?? AppSizes.szH20,
      color: color,
    );
  }

  static Widget filterIcon({
    double? width,
    double? height,
    Color? color,
  }) {
    return buildIcon(
      assetPath: IconPath.icFilter,
      width: width ?? AppSizes.szW20,
      height: height ?? AppSizes.szH20,
      color: color,
    );
  }
}