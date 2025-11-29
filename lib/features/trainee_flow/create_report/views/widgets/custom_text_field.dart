import 'package:dermaininstitute/core/utils/constants/sizer.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? label;
  final String? hintText;
  final TextEditingController? controller;
  final int maxLines;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool isRequired;
  final EdgeInsetsGeometry? contentPadding;

  const CustomTextField({
    super.key,
    this.label,
    this.hintText,
    this.controller,
    this.maxLines = 1,
    this.validator,
    this.keyboardType,
    this.isRequired = false,
    this.contentPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: TextStyle(
              fontSize: AppSizes.font14,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF374151),
            ),
          ),
          SizedBox(height: AppSizes.szH8),
        ],
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          validator: validator ??
              (isRequired
                  ? (value) {
                      if (value == null || value.trim().isEmpty) {
                        return '${label ?? 'This field'} is required';
                      }
                      return null;
                    }
                  : null),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: AppSizes.font14,
              color: const Color(0xFF9CA3AF),
            ),
            contentPadding: contentPadding ??
                EdgeInsets.symmetric(
                  horizontal: AppSizes.szW16,
                  vertical: AppSizes.szH16,
                ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.szR8),
              borderSide: const BorderSide(
                color: Color(0xFFD1D5DB),
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.szR8),
              borderSide: const BorderSide(
                color: Color(0xFFD1D5DB),
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.szR8),
              borderSide: const BorderSide(
                color: Color(0xFFD1D5DB),
                width: 1,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.szR8),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 1,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.szR8),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 2,
              ),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
      ],
    );
  }
}
