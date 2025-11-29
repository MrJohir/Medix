import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dermaininstitute/core/common/styles/global_text_style.dart';
import 'package:dermaininstitute/core/utils/constants/sizer.dart';
import 'package:dermaininstitute/core/utils/constants/icon_path.dart';

/// Custom search field widget for user management
/// Includes search icon and placeholder text
class CustomSearchField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final ValueChanged<String>? onChanged;

  const CustomSearchField({
    super.key,
    required this.controller,
    required this.hintText,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.szW10,
        vertical: AppSizes.szH8,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(AppSizes.szR12),
        border: Border.all(color: const Color(0xFFDFE1E6), width: 1),
      ),
      child: Row(
        children: [
          // Search input field
          Expanded(
            child: TextFormField(
              controller: controller,
              style: getTsRegularText(
                fontSize: 12,
                color: const Color(0xFF333333),
              ),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: getTsRegularText(
                  fontSize: 12,
                  color: const Color(0xFF333333),
                ),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
              onChanged: onChanged,
            ),
          ),

          SizedBox(width: AppSizes.szW10),

          // Search icon
          SvgPicture.asset(
            IconPath.searchIcon,
            width: AppSizes.szW24,
            height: AppSizes.szH24,
          ),
        ],
      ),
    );
  }
}
