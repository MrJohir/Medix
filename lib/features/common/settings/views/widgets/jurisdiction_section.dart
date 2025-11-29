import 'package:dermaininstitute/core/common/styles/global_text_style.dart';
import 'package:dermaininstitute/core/utils/constants/sizer.dart';
import 'package:dermaininstitute/features/common/settings/controllers/settings_controller.dart';
import 'package:dermaininstitute/features/common/settings/views/widgets/settings_dropdown_field.dart';
import 'package:flutter/material.dart';
import 'package:dermaininstitute/core/common/widgets/custom_note_card.dart';
import 'package:get/get.dart';

class JurisdictionSection extends StatelessWidget {
  final SettingsController controller;

  const JurisdictionSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AppNoteCard(
      color: 'White',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12,
        children: [
          // Section Title
          Text('Jurisdiction & Protocols', style: getTsSectionTitle()),
          SizedBox(height: AppSizes.szH2),

          // // Normal Dropdown
          // DropdownButtonFormField<String>(
          //   value: controller.primaryJurisdiction.value.isNotEmpty
          //       ? controller.primaryJurisdiction.value
          //       : null, // show hint if empty
          //   decoration: InputDecoration(
          //     border: OutlineInputBorder(
          //       borderRadius: BorderRadius.circular(AppSizes.szR10),
          //       borderSide: BorderSide(color: Color(0xFFEDF1F3)),
          //     ),
          //     contentPadding: EdgeInsets.symmetric(
          //       horizontal: 14,
          //       vertical: 12,
          //     ),
          //   ),
          //   hint: Text('Select Jurisdiction'),
          //   items: [
          //     'UK',
          //     'US',
          //     'ME',
          //     'EU',
          //     'Canada',
          //     'Australia',
          //   ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          //   onChanged: (value) {
          //     if (value != null) {
          //       controller.updateJurisdiction(value);
          //     }
          //   },
          // ),
          Obx(
            () => SettingsDropdownField(
              value: controller.primaryJurisdiction.value,
              dropdownOptions: ['UK', 'US', 'ME', 'EU', 'Canada', 'Australia'],
              onDropdownChanged: (value) {
                controller.primaryJurisdiction.value = value;
              },
            ),
          ),

          // Information Note
          AppNoteCard(
            color: 'Blue',
            child: Text(
              'Changing jurisdiction will update available protocols and dosing guidelines to match local regulations.',
              style: getTsNotesText(color: const Color(0xFF1A4DBE)),
            ),
          ),
        ],
      ),
    );
  }
}
