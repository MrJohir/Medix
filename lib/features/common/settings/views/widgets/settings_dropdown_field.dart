import 'package:dermaininstitute/core/common/styles/global_text_style.dart';
import 'package:dermaininstitute/core/utils/constants/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Minimal Settings Dropdown Field Widget
/// Handles dropdown fields with bottom sheet selection only
class SettingsDropdownField extends StatelessWidget {
  final String? label;
  final String value;
  final List<String> dropdownOptions;
  final ValueChanged<String> onDropdownChanged;

  const SettingsDropdownField({
    super.key,
    this.label,
    required this.value,
    required this.dropdownOptions,
    required this.onDropdownChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 2,
      children: [
        // Field Label
        Text(label ?? "Jurisdction", style: getTsInputLabel()),
        SizedBox(height: AppSizes.szH8),

        // Field Container
        GestureDetector(
          onTap: () => _showBottomSheet(context),
          child: Container(
            width: double.infinity,
            constraints: BoxConstraints(minHeight: 46),
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
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
            child: Padding(
              padding: EdgeInsets.all(8.r),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      value.isNotEmpty
                          ? value
                          : "Select $label", // ✅ fallback if empty
                      style: getTsInputPlaceholder(
                        color: value.isNotEmpty
                            ? Colors.black
                            : Colors.grey, // ✅ grey for placeholder
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: Color(0xFF8993A4),
                    size: 16,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Show bottom sheet with dropdown options
  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Bottom sheet header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: AppSizes.szW12),
                      child: Text('Select $label', style: getTsSectionTitle()),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.close),
                    ),
                  ],
                ),

                SizedBox(height: 20),

                // Options list
                ...dropdownOptions.map(
                  (option) => ListTile(
                    title: Text(
                      option,
                      style: TextStyle(
                        color: Color(0xFF1A1C1E),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    trailing: value == option
                        ? Icon(Icons.check, color: Color(0xFF1976D2))
                        : null,
                    onTap: () {
                      onDropdownChanged(option);
                      Navigator.pop(context);
                    },
                  ),
                ),

                SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}
