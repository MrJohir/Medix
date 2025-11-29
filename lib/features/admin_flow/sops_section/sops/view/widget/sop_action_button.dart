import 'package:dermaininstitute/core/common/styles/global_text_style.dart';
import 'package:dermaininstitute/core/utils/constants/sizer.dart';
import 'package:flutter/material.dart';

/// Custom action button widget for SOP card actions
/// Supports both outline and filled button styles
class SOPActionButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isOutlined;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final Widget? icon;
  final bool isIconOnly;
  final double? width;

  const SOPActionButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isOutlined = false,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.icon,
    this.isIconOnly = false,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    // Icon-only button (for delete)
    if (isIconOnly && icon != null) {
      return GestureDetector(
        onTap: onPressed,
        child: Container(
          width: AppSizes.szW40,
          height: AppSizes.szH40,
          decoration: BoxDecoration(
            color: backgroundColor ?? const Color(0xFF12295E),
            borderRadius: BorderRadius.circular(AppSizes.szR50),
          ),
          child: Center(child: icon!),
        ),
      );
    }

    // Regular button (View/Edit)
    return SizedBox(
      width: width,
      height: AppSizes.szH40,
      child: isOutlined ? _buildOutlinedButton() : _buildFilledButton(),
    );
  }

  /// Build outlined button style
  Widget _buildOutlinedButton() {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: BorderSide(
          color: borderColor ?? const Color(0xFF12295E),
          width: 1,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.szR50),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.szW16,
          vertical: AppSizes.szH10,
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: getTsBoldText(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: textColor ?? const Color(0xFF12295E),
        ),
      ),
    );
  }

  /// Build filled button style
  Widget _buildFilledButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? const Color(0xFF12295E),
        elevation: 0,
        shadowColor: Colors.transparent,
        side: BorderSide.none,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.szR50),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.szW16,
          vertical: AppSizes.szH10,
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: getTsBoldText(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: textColor ?? Colors.white,
        ),
      ),
    );
  }
}
