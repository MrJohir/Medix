import 'package:dermaininstitute/core/common/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../core/common/widgets/custom_admin_drop_dwon.dart';
import '../../controller/add_new_sop_controller.dart';
import '../widget/Tags_item.dart';
import '../../../../../../core/common/widgets/custom_admin_button.dart';
import '../../../../../../core/common/widgets/custom_switch_admin.dart';
import '../../../../../../core/common/widgets/custom_admin_textfied.dart';
import '../widget/jurisdiction_item.dart';
import '../widget/sop_content_section.dart';
import '../../../../sops_section/sops/model/sop_model.dart';

class AddNewSopScreen extends StatelessWidget {
  const AddNewSopScreen({super.key, required this.title, this.sopData});

  final String title;
  final SOPModel? sopData;

  @override
  Widget build(BuildContext context) {
    final AddNewSopController controller = Get.put(AddNewSopController());

    // Initialize controller with SOP data if in edit mode
    if (sopData != null) {
      controller.initializeForEdit(sopData!);
    }

    return Scaffold(
      appBar: AppBarHelper.backWithAvatar(
        title: title,
        onBackPressed: () => Get.back(),

        showConnectionStatus: true,
      ),
      backgroundColor: Color(0xffF9FAFB),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color(0xffFEFEFE),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Color(0xffDFE1E6), width: 1),
              ),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(
                      'Basic Information',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Montserrat',
                        color: Color(0xff141617),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0, bottom: 5),
                      child: Text(
                        'SOP Title',
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w400,
                          color: Color(0xff333333),
                        ),
                      ),
                    ),

                    CustomAdminTextField(
                      controller: controller.sopTitleController,
                      hintText: 'Enter SOP title...',
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 15.0, bottom: 5),
                      child: Text(
                        'Jurisdiction',
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w400,
                          color: Color(0xff333333),
                        ),
                      ),
                    ),
                    JurisdictionItem(controller: controller),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0, bottom: 5),
                      child: Text(
                        'Tags',
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w400,
                          color: Color(0xff333333),
                        ),
                      ),
                    ),
                    TagsItem(controller: controller),
                  ],
                ),
              ),
            ),
            SopContentSection(controller: controller),
            Container(
              decoration: BoxDecoration(
                color: Color(0xffFEFEFE),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Color(0xffDFE1E6), width: 1),
              ),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Settings',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Montserrat',
                        color: Color(0xFF141617),
                      ),
                    ),
                    SizedBox(height: 12),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Emergency/Red Flag Protocol',
                                style: TextStyle(
                                  color: const Color(0xFF141617),
                                  fontSize: 12,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Mark as critical emergency protocol',
                                style: TextStyle(
                                  color: const Color(0xFF141617),
                                  fontSize: 12,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Obx(
                          () => CustomSwitchAdmin(
                            value: controller.settingStatus.value,
                            onChanged: controller.toggleSettingsValue,
                          ),
                        ),
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 15.0, bottom: 5),
                      child: Text(
                        'Publication Status',
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w400,
                          color: Color(0xff333333),
                        ),
                      ),
                    ),

                    CustomAdminDropdown(
                      label: 'Select status',
                      value: controller.publicationStatus,
                      items: controller.publicationStatusOptions,
                      onChanged: (String? newValue) {
                        controller.publicationStatus(newValue);
                      },
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 15.0, bottom: 5),
                      child: Text(
                        'Priority',
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w400,
                          color: Color(0xff333333),
                        ),
                      ),
                    ),

                    CustomAdminDropdown(
                      label: 'Select priority',
                      value: controller.priority,
                      items: controller.priorityOptions,
                      onChanged: (String? newValue) {
                        controller.priority(newValue);
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
            Obx(
              () => CustomAdminButton(
                text: 'Cancel',
                textColor: const Color(0xFF12295E),
                borderColor: const Color(0xff12295E),
                onPressed: controller.isLoading.value
                    ? () {}
                    : controller.onCancel,
              ),
            ),

            Obx(
              () => CustomAdminButton(
                text: 'Save as Draft',
                textColor: const Color(0xFF12295E),
                borderColor: const Color(0xff12295E),
                onPressed: controller.isLoading.value
                    ? () {}
                    : controller.onSaveAsDraft,
              ),
            ),

            Obx(
              () => CustomAdminButton(
                text: sopData != null ? 'Update SOP' : 'Publish SOP',
                textColor: Colors.white,
                borderColor: const Color(0xFFA94907),
                backgroundColor: const Color(0xFFA94907),
                onPressed: controller.isLoading.value
                    ? () {}
                    : sopData != null
                    ? controller.onUpdateSOP
                    : controller.onPublishSOP,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
