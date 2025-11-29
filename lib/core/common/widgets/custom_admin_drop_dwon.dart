import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAdminDropdown<T> extends StatelessWidget {
  final RxString value; 
  final List<String> items; 
  final void Function(String?) onChanged; 
  final String label;

  const CustomAdminDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(8),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            hint:  Text(
              label,
              style: TextStyle(
                color: const Color(0xFF1A1C1E),
                fontSize: 14,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w400,
              ),
            ),
            value: value.value.isNotEmpty ? value.value : null,
            isExpanded: true,
            icon: const Icon(
              Icons.keyboard_arrow_down,
              size: 28,
              color: Color(0xFFACB5BB),
            ),
            items: items.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(
                    color: Color(0xFF1A1C1E),
                    fontSize: 14,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }
}
