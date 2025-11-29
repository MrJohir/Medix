import 'package:flutter/material.dart';
import 'package:dermaininstitute/core/common/styles/global_text_style.dart';
import 'package:dermaininstitute/core/utils/constants/sizer.dart';
import 'package:dermaininstitute/core/utils/constants/icon_path.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Custom dropdown field widget for filters
/// Supports generic type T for dropdown items
class CustomDropdownField<T> extends StatelessWidget {
  final String label;
  final String hintText;
  final T? value;
  final List<T> items;
  final String Function(T) itemText;
  final ValueChanged<T?> onChanged;

  const CustomDropdownField({
    super.key,
    required this.label,
    required this.hintText,
    required this.value,
    required this.items,
    required this.itemText,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Text(label, style: getTsInputLabel()),
        SizedBox(height: AppSizes.szH8),

        // Dropdown Container
        Container(
          width: double.infinity,
          height: AppSizes.szH48,
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.szW14,
            vertical: AppSizes.szH14,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppSizes.szR10),
            border: Border.all(color: const Color(0xFFEDF1F3), width: 1),
            boxShadow: const [
              BoxShadow(
                color: Color(0x3DE4E5E7),
                blurRadius: 2,
                offset: Offset(0, 1),
                spreadRadius: 0,
              ),
            ],
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              value: value,
              hint: Text(hintText, style: getTsInputPlaceholder()),
              isExpanded: true,
              icon: SvgPicture.asset(
                IconPath.icDown,
                width: AppSizes.szW16,
                height: AppSizes.szH16,
              ),
              style: getTsRegularText(
                fontSize: 14,
                color: const Color(0xFF333333),
              ),
              onChanged: onChanged,
              items: [
                // Add "All" option
                DropdownMenuItem<T>(
                  value: null,
                  child: Text(
                    'All',
                    style: getTsRegularText(
                      fontSize: 14,
                      color: const Color(0xFF333333),
                    ),
                  ),
                ),
                // Add actual items
                ...items.map((T item) {
                  return DropdownMenuItem<T>(
                    value: item,
                    child: Text(
                      itemText(item),
                      style: getTsRegularText(
                        fontSize: 14,
                        color: const Color(0xFF333333),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
