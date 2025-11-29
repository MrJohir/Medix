import 'package:dermaininstitute/core/utils/constants/sizer.dart';
import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  final String? label;
  final String? hintText;
  final String? value;
  final List<String> items;
  final Function(String?) onChanged;
  final String? Function(String?)? validator;
  final bool isRequired;

  const CustomDropdown({
    super.key,
    this.label,
    this.hintText,
    this.value,
    required this.items,
    required this.onChanged,
    this.validator,
    this.isRequired = false,
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
        DropdownButtonFormField<String>(
          initialValue: value?.isEmpty == true ? null : value,
          isExpanded: true, // This prevents overflow
          hint: Text(
            hintText ?? 'Select option',
            style: TextStyle(
              fontSize: AppSizes.font14,
              color: const Color(0xFF9CA3AF),
            ),
            overflow: TextOverflow.ellipsis, // Handle text overflow
          ),
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: TextStyle(
                  fontSize: AppSizes.font14,
                  color: const Color(0xFF374151),
                ),
                overflow: TextOverflow.ellipsis, // Handle text overflow
              ),
            );
          }).toList(),
          onChanged: onChanged,
          validator: validator ??
              (isRequired
                  ? (value) {
                      if (value == null || value.isEmpty) {
                        return '${label ?? 'This field'} is required';
                      }
                      return null;
                    }
                  : null),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
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
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: const Color(0xFF9CA3AF),
            size: AppSizes.szW20,
          ),
          // Add dropdown positioning properties
          menuMaxHeight: 200, // Limit dropdown height
          dropdownColor: Colors.white,
          borderRadius: BorderRadius.circular(AppSizes.szR8),
        ),
      ],
    );
  }
}
