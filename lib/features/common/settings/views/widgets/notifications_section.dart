import 'package:dermaininstitute/core/common/styles/global_text_style.dart';
import 'package:dermaininstitute/features/common/settings/controllers/settings_controller.dart';
import 'package:dermaininstitute/features/common/settings/views/widgets/settings_toggle_row.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dermaininstitute/core/common/widgets/custom_note_card.dart';

/// Notifications Section Widget
class NotificationsSection extends StatelessWidget {
  final SettingsController controller;

  const NotificationsSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AppNoteCard(
      color: 'White',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12,
        children: [
          // Section Title
          Text('Notifications', style: getTsSectionTitle()),

          // Notification Settings
          Column(
            spacing: 12,
            children: [
              // Push Notifications Toggle
              Obx(
                () => SettingsToggleRow(
                  title: 'Push Notifications',
                  subtitle: 'Receive alerts and updates',
                  value: controller.user.value?.notification ?? false,
                  onChanged: (val) async {
                    controller.user.value =
                        controller.user.value?.copyWith(notification: val);
                    // controller.isPushNotificationsEnabled.value = val;
                    await controller.updateNotificationSettings(); // call API
                  },
                ),
              ),

              Obx(
                () => SettingsToggleRow(
                  title: 'Emergency Alerts',
                  subtitle: 'Critical safety notifications',
                  value: controller.user.value?.emargencyAlert ?? false,
                  onChanged: (val) async {
                    controller.user.value =
                        controller.user.value?.copyWith(emargencyAlert: val);
                    // controller.isEmergencyAlertsEnabled.value = val;
                    await controller.updateNotificationSettings(); // call API
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
