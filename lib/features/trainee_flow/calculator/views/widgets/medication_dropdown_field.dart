import 'package:dermaininstitute/core/common/styles/global_text_style.dart';
import 'package:dermaininstitute/core/utils/constants/colors.dart';
import 'package:dermaininstitute/core/utils/constants/sizer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MedicationDropdownField extends StatelessWidget {
  final String label;
  final String hintText;
  final String selectedValue;
  final List<String> options;
  final Function(String) onChanged;

  const MedicationDropdownField({
    super.key,
    required this.label,
    required this.hintText,
    required this.selectedValue,
    required this.options,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: getTsInputLabel()),
        SizedBox(height: AppSizes.szH8),
        GestureDetector(
          onTap: () => _showMedicationBottomSheet(context),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: AppSizes.szW16,
              vertical: AppSizes.szH14,
            ),
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    selectedValue.isEmpty ? hintText : selectedValue,
                    style: selectedValue.isEmpty
                        ? getTsInputPlaceholder()
                        : getTsRegularText(fontSize: 14),
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: AppColors.lightGrey,
                  size: AppSizes.szW16,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showMedicationBottomSheet(BuildContext context) {
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppSizes.szR20),
            topRight: Radius.circular(AppSizes.szR20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(AppSizes.szR16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Select Medication',
                    style: getTsSectionTitle(fontSize: 16),
                  ),
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: Icon(Icons.close),
                  ),
                ],
              ),
            ),
            Divider(height: 1),
            ...options.map(
              (medication) => ListTile(
                title: Text(medication, style: getTsRegularText(fontSize: 14)),
                onTap: () {
                  onChanged(medication);
                  Get.back();
                },
              ),
            ),
            SizedBox(height: AppSizes.szH20),
          ],
        ),
      ),
    );
  }
}
