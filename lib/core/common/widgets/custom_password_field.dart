import 'package:dermaininstitute/core/common/styles/global_text_style.dart';
import 'package:dermaininstitute/features/common/authentication/login/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:dermaininstitute/core/utils/constants/app_texts.dart';
import 'package:dermaininstitute/core/utils/constants/sizer.dart';

class CustomPasswordField extends StatelessWidget {
  const CustomPasswordField({
    super.key,
    required this.controller,
    this.validator,
    this.label,
    this.hintText,
  });

  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String? label;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label ?? AppText.password,
          style: getTsInputLabel(
            lineHeight: 1.6,
            fontSize: AppSizes.szH12,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: AppSizes.spaceBtwItemsH),
        Obx(() {
          return Container(
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
              controller: controller,
              keyboardType: TextInputType.visiblePassword,
              validator: validator,

              obscureText: Get.find<LoginController>().isPasswordVisible.value,
              obscuringCharacter: '*',
              decoration: InputDecoration(
                hintText: hintText ?? AppText.enterPassword,
                hintStyle:
                    getTsInputPlaceholder(), // Same hint style as CustomField
                suffixIcon: IconButton(
                  onPressed: () =>
                      Get.find<LoginController>().togglePasswordVisibility(),
                  icon: Icon(
                    Get.find<LoginController>().isPasswordVisible.value
                        ? Iconsax.eye_slash
                        : Iconsax.eye,
                    color: const Color(0xFFACB5BB),
                  ),
                ),
                contentPadding: EdgeInsets.only(
                  top: AppSizes.szH14,
                  bottom: AppSizes.szH15,
                  left: AppSizes.szW16,
                  right: AppSizes.szW16,
                ),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
              ),
            ),
          );
        }),
      ],
    );
  }
}
