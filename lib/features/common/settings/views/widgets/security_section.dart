import 'package:dermaininstitute/core/common/styles/global_text_style.dart';
import 'package:dermaininstitute/core/utils/constants/sizer.dart';
import 'package:dermaininstitute/features/common/settings/controllers/settings_controller.dart';
import 'package:dermaininstitute/features/common/settings/views/widgets/change_pass.dart';
import 'package:flutter/material.dart';
import 'package:dermaininstitute/core/common/widgets/custom_note_card.dart';
import 'package:dermaininstitute/core/common/widgets/custom_outline_button.dart';
import 'package:get/get.dart';

/// Security & Privacy Section Widget
class SecuritySection extends StatelessWidget {
  final SettingsController controller;

  const SecuritySection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AppNoteCard(
      color: 'White',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12,
        children: [
          // Section Title
          Text('Security & Privacy', style: getTsSectionTitle()),
          SizedBox(height: AppSizes.szW2),

          // Change Password Button
          OutButton(
            text: 'Change Password',
            onPressed: () {
              Get.to(() => ChangePasswordScreen());
            },
            fontSize: 12,
            fontWeight: FontWeight.w600,
            paddingHeight: 14,
          ),

          // // Data Export Button
          // OutButton(
          //   text: 'Data Export',
          //   onPressed: controller.exportData,
          //   fontSize: 12,
          //   fontWeight: FontWeight.w600,
          //   paddingHeight: 14,
          // ),

          // Security Information Note
          // AppNoteCard(
          //   color: 'Yellow',
          //   child: Row(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     spacing: 8,
          //     children: [
          //       // Warning icon
          //       SvgIconHelper.buildIcon(
          //         assetPath: IconPath.icWarningError,
          //         width: AppSizes.szW24,
          //         height: AppSizes.szH24,
          //       ),
          //       Expanded(
          //         child: Text(
          //           'All data is encrypted and stored securely. Patient information is anonymized in logs.',
          //           style: getTsNotesText(color: Color(0xFF856500)),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
