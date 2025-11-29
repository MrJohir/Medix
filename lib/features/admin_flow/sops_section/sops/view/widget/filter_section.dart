import 'package:dermaininstitute/core/common/styles/global_text_style.dart';
import 'package:dermaininstitute/core/common/widgets/custom_field.dart';
import 'package:dermaininstitute/core/common/widgets/custom_note_card.dart';
import 'package:dermaininstitute/core/utils/constants/sizer.dart';
import 'package:dermaininstitute/features/admin_flow/sops_section/sops/controller/manage_sops_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Filter section widget containing search and filter controls
/// Used in the Manage SOPs screen for filtering SOP list
class FilterSection extends StatelessWidget {
  const FilterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ManageSOPsController>();

    return AppNoteCard(
      color: 'White',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SOPs count header
          Obx(
            () => Text(
              'SOPs (${controller.filteredSOPs.length})',
              style: getTsSectionTitle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          SizedBox(height: AppSizes.szH12),

          // Search SOPs field
          CustomField(
            controller: controller.searchController,
            label: 'Search SOPs',
            hintText: 'Search by title or author...',
            keyboardType: TextInputType.text,
            onChanged: (_) => controller.filterSOPs(),
          ),

          SizedBox(height: AppSizes.szH12),

          // Jurisdiction dropdown field - reactive to changes
          Obx(
            () => _buildDropdownField(
              controller: controller.jurisdictionController,
              label: 'Jurisdiction',
              items: _getJurisdictionItems(controller),
              onChanged: controller.onJurisdictionChanged,
            ),
          ),

          SizedBox(height: AppSizes.szH12),

          // Status dropdown field
          _buildDropdownField(
            controller: controller.statusController,
            label: 'Status',
            items: controller.getAvailableStatuses(),
            onChanged: controller.onStatusChanged,
          ),
        ],
      ),
    );
  }

  /// Get jurisdiction items dynamically from current SOPs data
  List<String> _getJurisdictionItems(ManageSOPsController controller) {
    final Set<String> jurisdictions = {'All'};
    // Directly access the sops list to trigger reactivity
    for (final sop in controller.sops) {
      jurisdictions.addAll(sop.jurisdiction);
    }
    return jurisdictions.toList();
  }

  /// Build custom dropdown field
  Widget _buildDropdownField({
    required TextEditingController controller,
    required String label,
    required List<String> items,
    required Function(String) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: getTsInputLabel()),
        SizedBox(height: AppSizes.szH8),

        Container(
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
          child: DropdownButtonFormField<String>(
            initialValue: controller.text.isEmpty ? items.first : controller.text,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(
                top: AppSizes.szH14,
                bottom: AppSizes.szH15,
                left: AppSizes.szW16,
              ),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
            ),
            icon: Padding(
              padding: EdgeInsets.only(right: AppSizes.szW12),
              child: Icon(
                Icons.keyboard_arrow_down,
                size: AppSizes.szW16,
                color: const Color(0xFF8993A4),
              ),
            ),
            style: getTsInputPlaceholder(),
            dropdownColor: Colors.white,
            items: items.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: getTsRegularText(
                    fontSize: 14,
                    color: const Color(0xFF1A1C1E),
                  ),
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              if (newValue != null) {
                onChanged(newValue);
              }
            },
          ),
        ),
      ],
    );
  }
}
