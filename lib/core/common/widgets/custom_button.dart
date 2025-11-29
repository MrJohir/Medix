import 'package:dermaininstitute/core/common/styles/global_text_style.dart';
import 'package:dermaininstitute/core/utils/constants/colors.dart';
import 'package:dermaininstitute/core/utils/constants/sizer.dart';
import 'package:flutter/material.dart';

class ElevButton extends StatelessWidget {
  const ElevButton({
    super.key,
    this.onPressed,
    required this.text,
    this.backgroundColor,
    this.color,
    this.preIcon,
    this.icon,
    this.textStyle,
    this.radius,
    this.paddingHeight,
    this.lineHeight,
    this.fontSize, this.fontWeight,
  });

  final VoidCallback? onPressed;
  final String text;
  final double? paddingHeight;
  final double? radius;
  final double? lineHeight;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Color? backgroundColor;
  final Color? color;
  final Widget? preIcon;
  final Widget? icon;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          side: BorderSide.none,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? AppSizes.szR50),
          ),
          elevation: 0,
          backgroundColor: backgroundColor ?? AppColors.primary,
          shadowColor: Colors.transparent,
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.szW20,
            vertical: paddingHeight ?? AppSizes.szH16,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        onPressed: onPressed,
        child: Container(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (preIcon != null) ...[
                preIcon!,
                SizedBox(width: AppSizes.szW8),
              ],
              Text(
                text,
                style:
                    textStyle ??
                    getTsBoldText(
                      fontWeight: fontWeight ?? FontWeight.w500,
                      fontSize: fontSize ?? 12,
                      color: color ?? AppColors.textWhite,
                    ),
              ),
              if (icon != null) ...[SizedBox(width: AppSizes.szW8), icon!],
            ],
          ),
        ),
      ),
    );
  }
}