import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../controller/add_new_sop_controller.dart';
import 'check_box_admin.dart';

class JurisdictionItem extends StatelessWidget {
  const JurisdictionItem({super.key, required this.controller});

  final AddNewSopController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0),
      child: Obx(()=>
         Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: CheckboxAdmin(
                    title: 'United Kingdom',
                    isSelected: controller.selectedJurisdictions.contains(
                      'United Kingdom',
                    ),
                    onTap: () => controller.toggleJurisdiction('United Kingdom'),
                  ),
                ),
                Expanded(
                  child: CheckboxAdmin(
                    title: 'United States',
                    isSelected: controller.selectedJurisdictions.contains(
                      'United States',
                    ),
                    onTap: () => controller.toggleJurisdiction('United States'),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 12),
              child: Row(
                children: [
                  Expanded(
                    child: CheckboxAdmin(
                      title: 'Canada',
                      isSelected: controller.selectedJurisdictions.contains(
                        'Canada',
                      ),
                      onTap: () => controller.toggleJurisdiction('Canada'),
                    ),
                  ),
                  Expanded(
                    child: CheckboxAdmin(
                      title: 'Australia',
                      isSelected: controller.selectedJurisdictions.contains(
                        'Australia',
                      ),
                      onTap: () => controller.toggleJurisdiction('Australia'),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: CheckboxAdmin(
                    title: 'Middle East',
                    isSelected: controller.selectedJurisdictions.contains(
                      'Middle East',
                    ),
                    onTap: () => controller.toggleJurisdiction('Middle East'),
                  ),
                ),
                Expanded(
                  child: CheckboxAdmin(
                    title: 'New Zealand',
                    isSelected: controller.selectedJurisdictions.contains(
                      'New Zealand',
                    ),
                    onTap: () => controller.toggleJurisdiction('New Zealand'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
