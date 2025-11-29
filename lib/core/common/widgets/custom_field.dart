import 'package:dermaininstitute/core/common/styles/global_text_style.dart';
import 'package:dermaininstitute/core/utils/constants/app_texts.dart';
import 'package:dermaininstitute/core/utils/constants/colors.dart';
import 'package:dermaininstitute/core/utils/constants/sizer.dart';
import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  const CustomField({
    super.key,
    required this.controller,
    this.validator,
    this.label,
    this.hintText,
    this.keyboardType,
    this.onChanged,
    this.decoration,
    this.maxLines,
    this.minLines,
    this.prefixIcon,
    this.hintStyle,
    this.labelStyle,
    this.suffixIcon,
    this.readonly = false,
  });

  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String? label;
  final String? hintText;
  final BoxDecoration? decoration;
  final TextInputType? keyboardType;
  final int? maxLines;
  final int? minLines;
  final ValueChanged<String>? onChanged;
  final Widget? prefixIcon;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final Widget? suffixIcon;
  final bool? readonly;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label ?? AppText.email, style: labelStyle ?? getTsInputLabel()),
        SizedBox(height: AppSizes.szH8),

        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppSizes.szR10),
            border: Border.all(color: const Color(0xFFEDF1F3), width: 1),
            boxShadow: [
              BoxShadow(
                color: Color(0x3DE4E5E7),
                blurRadius: 2,
                offset: Offset(0, 1),
                spreadRadius: 0,
              ),
            ],
          ),
          child: TextFormField(
            readOnly: readonly ?? false,
            controller: controller,
            keyboardType: keyboardType ?? TextInputType.text,
            validator: validator,
            minLines: minLines,
            maxLines: maxLines ?? 1,
            // Disable context menu and selection for readonly fields
            enableInteractiveSelection: !(readonly ?? false),
            contextMenuBuilder: (readonly ?? false)
                ? (_, __) => const SizedBox.shrink()
                : null,
            decoration: InputDecoration(
              hintText: hintText ?? AppText.enterEmail,
              hintStyle: hintStyle ?? getTsInputPlaceholder(),
              errorMaxLines: 1,
              errorStyle: TextStyle(color: AppColors.error),
              contentPadding: EdgeInsets.only(
                top: AppSizes.szH14,
                bottom: AppSizes.szH15,
                left: AppSizes.szW16,
                right: AppSizes.szW16,
              ),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
            ),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
