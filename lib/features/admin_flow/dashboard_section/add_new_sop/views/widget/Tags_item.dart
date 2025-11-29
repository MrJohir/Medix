// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/add_new_sop_controller.dart';
import 'check_box_admin.dart';

class TagsItem extends StatelessWidget {
  const TagsItem({super.key, required this.controller});

  final AddNewSopController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: Obx(
        () => Column(
          children: [
            CheckboxAdmin(
              title: 'Emergency',
              isSelected: controller.selectedTags.contains('Emergency'),
              onTap: () => controller.toggleTag('Emergency'),
            ),
            const SizedBox(height: 8),
            CheckboxAdmin(
              title: 'Botulinum Toxin',
              isSelected: controller.selectedTags.contains('Botulinum Toxin'),
              onTap: () => controller.toggleTag('Botulinum Toxin'),
            ),
            const SizedBox(height: 8),
            CheckboxAdmin(
              title: 'Allergic Reactions',
              isSelected: controller.selectedTags.contains(
                'Allergic Reactions',
              ),
              onTap: () => controller.toggleTag('Allergic Reactions'),
            ),
            const SizedBox(height: 8),
            CheckboxAdmin(
              title: 'Dermal Fillers',
              isSelected: controller.selectedTags.contains('Dermal Fillers'),
              onTap: () => controller.toggleTag('Dermal Fillers'),
            ),
            const SizedBox(height: 8),
            CheckboxAdmin(
              title: 'Anesthetics',
              isSelected: controller.selectedTags.contains('Anesthetics'),
              onTap: () => controller.toggleTag('Anesthetics'),
            ),
            const SizedBox(height: 8),
            CheckboxAdmin(
              title: 'Vascular Complications',
              isSelected: controller.selectedTags.contains(
                'Vascular Complications',
              ),
              onTap: () => controller.toggleTag('Vascular Complications'),
            ),
            const SizedBox(height: 8),
            CheckboxAdmin(
              title: 'Post-Procedure Care',
              isSelected: controller.selectedTags.contains(
                'Post-Procedure Care',
              ),
              onTap: () => controller.toggleTag('Post-Procedure Care'),
            ),
          ],
        ),
      ),
    );
  }
}
