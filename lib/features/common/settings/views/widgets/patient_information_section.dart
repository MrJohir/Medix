import 'package:dermaininstitute/core/common/styles/global_text_style.dart';
import 'package:dermaininstitute/core/utils/constants/app_texts.dart';
import 'package:dermaininstitute/core/utils/constants/sizer.dart';
import 'package:dermaininstitute/features/common/settings/controllers/settings_controller.dart';
import 'package:dermaininstitute/features/common/settings/views/widgets/settings_dropdown_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dermaininstitute/core/common/widgets/custom_button.dart';
import 'package:dermaininstitute/core/common/widgets/custom_note_card.dart';
import 'package:dermaininstitute/core/common/widgets/custom_field.dart';
import 'package:dermaininstitute/core/utils/validators/app_validator.dart';

/// Patient Information Section Widget
/// Displays user profile information and update functionality
class PatientInformationSection extends StatelessWidget {
  final SettingsController controller;

  const PatientInformationSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AppNoteCard(
      color: 'White',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12,
        children: [
          // Section Title
          Text('Patient Information', style: getTsSectionTitle()),
          SizedBox(height: AppSizes.szH2),

          // Profile Fields
          Column(
            spacing: 24,
            children: [
              Column(
                spacing: 12,
                children: [
                  // Full Name Field (Editable)
                  CustomField(
                    label: 'Full Name',
                    hintText: AppText.enterFullName,
                    controller: controller.fullNameController,
                    validator: (value) =>
                        AppValidator.validateEmptyText("Full Name", value),
                  ),

                  // Email Address Field (Editable)
                  CustomField(
                    label: 'Email Address',
                    controller: controller.emailController,
                    validator: (value) => AppValidator.validateEmail(value),
                    keyboardType: TextInputType.emailAddress,
                  ),

                  // License Number and Specialization Row
                  Row(
                    spacing: 6,
                    children: [
                      Expanded(
                        child: CustomField(
                          label: 'License Number',
                          hintText: "Enter your license number",
                          controller: controller.licenseController,
                          validator: (value) => AppValidator.validateEmptyText(
                            "License Number",
                            value,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Obx(
                          () => SettingsDropdownField(
                            label: 'Specialization',
                            value: controller.specialization.value,
                            dropdownOptions: [
                              'Aesthetic Medicine',
                              'Dermatology',
                              'Plastic Surgery',
                              'Cosmetic Surgery',
                              'General Medicine',
                            ],
                            onDropdownChanged: (value) {
                              controller.specialization.value = value;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              // Update Profile Button
              ElevButton(
                text: 'Update Profile',
                backgroundColor: Color(0xFFA94907),
                onPressed: controller.updateProfile,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                paddingHeight: 14,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
