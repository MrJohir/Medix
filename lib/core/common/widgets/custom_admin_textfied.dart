import 'package:dermaininstitute/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomAdminTextField extends StatelessWidget {
  const CustomAdminTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.readOnly,
  });

  final TextEditingController controller;
  final String hintText;
  final bool? readOnly;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.text,
      readOnly: readOnly ?? false,
      controller: controller,
      // disable context menu and selection for readonly fields
      enableInteractiveSelection: !(readOnly ?? false),
      contextMenuBuilder: (readOnly ?? false)
          ? (_, __) => const SizedBox.shrink()
          : null,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: const Color(0xFF1A1C1E),
          fontSize: 14,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w400,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xffEDF1F3)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xffEDF1F3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xffEDF1F3)),
        ),
        filled: true,
        fillColor: AppColors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 14,
        ),
      ),
    );
  }
}
