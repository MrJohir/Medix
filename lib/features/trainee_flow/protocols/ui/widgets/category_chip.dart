import 'package:dermaininstitute/core/utils/constants/colors.dart';
import 'package:dermaininstitute/core/utils/constants/sizer.dart';
import 'package:dermaininstitute/features/trainee_flow/protocols/controllers/protocols_controller.dart';
import 'package:dermaininstitute/features/trainee_flow/protocols/models/protocol_enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryChip extends StatelessWidget {
  const CategoryChip({
    super.key,
    required this.category,
    required this.controller,
  });

  final ProtocolCategory category;
  final ProtocolsController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isSelected = controller.selectedCategory.value == category;

      return GestureDetector(
        onTap: () => controller.selectCategory(category),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.szW16,
            vertical: AppSizes.szH10,
          ),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(AppSizes.szR50),
            border: !isSelected
                ? Border.all(color: AppColors.black, width: 1)
                : null,
          ),
          child: Text(
            category.value,
            style: TextStyle(
              fontSize: AppSizes.font12,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : const Color(0xFF42526E),
            ),
          ),
        ),
      );
    });
  }
}
