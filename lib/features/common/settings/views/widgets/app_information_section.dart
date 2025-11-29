import 'package:dermaininstitute/core/common/styles/global_text_style.dart';
import 'package:dermaininstitute/core/utils/constants/sizer.dart';
import 'package:dermaininstitute/features/common/settings/controllers/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dermaininstitute/core/common/widgets/custom_note_card.dart';
import 'package:dermaininstitute/core/common/widgets/custom_outline_button.dart';

/// App Information Section Widget
class AppInformationSection extends StatelessWidget {
  final SettingsController controller;

  const AppInformationSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AppNoteCard(
      color: 'White',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12,
        children: [
          // Section Title
          Text('App Information', style: getTsSectionTitle()),
          SizedBox(height: AppSizes.szH2),

          // App Info Details
          Column(
            spacing: 14,
            children: [
              // Version Information
              Obx(() => _buildInfoRow('Version', controller.appVersion.value)),

              // Last Updated Information
              // Obx(
              //   () =>
              //       _buildInfoRow('Last Updated', controller.lastUpdated.value),
              // ),

              // Storage Used Information
              Obx(
                () =>
                    _buildInfoRow('Storage Used', controller.storageUsed.value),
              ),
            ],
          ),
          SizedBox(height: AppSizes.szH2),

          // Action Buttons
          Column(
            spacing: 12,
            children: [
              // // Terms of Service Button
              // OutButton(
              //   text: 'Terms of Service',
              //   onPressed: controller.openTermsOfService,
              //   fontWeight: FontWeight.w600,
              //   paddingHeight: 14,
              // ),

              // Privacy Policy Button
              OutButton(
                text: 'Privacy Policy',
                color: Color(0xFF12295E),
                onPressed: controller.openPrivacyPolicy,
                fontWeight: FontWeight.w600,
                paddingHeight: 14,
              ),

              // // Contact Support Button
              // OutButton(
              //   text: 'Contact Support',
              //   color: Color(0xFF12295E),
              //   onPressed: controller.contactSupport,
              //   fontWeight: FontWeight.w600,
              //   paddingHeight: 14,
              // ),
            ],
          ),
        ],
      ),
    );
  }

  /// Build information row for app details
  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: getTsBoldText(color: const Color(0xFF141617))),
        Text(value, style: getTsBoldText(color: const Color(0xFF141617))),
      ],
    );
  }
}
