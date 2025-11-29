import 'package:dermaininstitute/core/common/styles/global_text_style.dart';
import 'package:dermaininstitute/core/utils/constants/sizer.dart';
import 'package:dermaininstitute/features/common/settings/controllers/settings_controller.dart';
import 'package:dermaininstitute/features/common/settings/views/widgets/settings_toggle_row.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dermaininstitute/core/common/widgets/custom_note_card.dart';
import 'package:dermaininstitute/core/common/widgets/custom_outline_button.dart';

/// Data & Sync Section Widget
class DataSyncSection extends StatelessWidget {
  final SettingsController controller;

  const DataSyncSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AppNoteCard(
      color: 'White',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12,
        children: [
          // Section Title
          Text('Data & Sync', style: getTsSectionTitle()),

          // Data Settings Toggles
          Column(
            spacing: 12,
            children: [
              // Offline Sync Toggle
              Obx(
                () => SettingsToggleRow(
                  title: 'Offline Sync',
                  subtitle: 'Sync data when online',
                  value: controller.isOfflineSyncEnabled.value,
                  onChanged: controller.toggleOfflineSync,
                ),
              ),

              // Auto Backup Toggle
              Obx(
                () => SettingsToggleRow(
                  title: 'Auto Backup',
                  subtitle: 'Backup incident logs and data',
                  value: controller.isAutoBackupEnabled.value,
                  onChanged: controller.toggleAutoBackup,
                ),
              ),
            ],
          ),

          // Divider
          Container(
            height: 1,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.black.withValues(alpha: 0.12),
                  width: 1,
                ),
              ),
            ),
          ),

          // Sync Status Display
          Obx(
            () => Padding(
              padding: EdgeInsets.only(right: AppSizes.szW8),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 6,
                      children: [
                        Text(
                          'Sync Status',
                          style: getTsSubTitle(
                            color: Color(0xFF141617),
                            lineHeight: 1.2,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          controller.syncStatus.value,
                          style: getTsRegularText(color: Color(0xFF8993A4)),
                        ),
                      ],
                    ),
                  ),
                  // Sync status indicator with check icon
                  Container(
                    width: 18,
                    height: 18,
                    decoration: BoxDecoration(
                      color: controller.isDataSynced.value
                          ? Color(0xFF2A7900)
                          : Color(0xFFFF8484),
                      shape: BoxShape.circle,
                    ),
                    child: controller.isDataSynced.value
                        ? Icon(Icons.check, color: Colors.white, size: 12)
                        : Icon(Icons.close, color: Colors.white, size: 12),
                  ),
                ],
              ),
            ),
          ),

          // Sync Now Button
          OutButton(
            text: 'Sync Now',
            fontWeight: FontWeight.w600,
            onPressed: controller.syncNow,
            paddingHeight: 14,
          ),
        ],
      ),
    );
  }
}
