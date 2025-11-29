import 'dart:io';
import 'package:dermaininstitute/core/common/styles/global_text_style.dart';
import 'package:dermaininstitute/core/common/widgets/custom_button.dart';
import 'package:dermaininstitute/core/common/widgets/custom_field.dart';
import 'package:dermaininstitute/core/utils/constants/icon_path.dart';
import 'package:dermaininstitute/core/utils/constants/image_path.dart';
import 'package:dermaininstitute/core/utils/helpers/svg_icon_helper.dart';
import 'package:dermaininstitute/core/utils/validators/app_validator.dart';
import 'package:dermaininstitute/features/common/settings/controllers/settings_controller.dart';
import 'package:dermaininstitute/features/common/settings/views/widgets/jurisdiction_section.dart';
import 'package:dermaininstitute/features/common/settings/views/widgets/settings_dropdown_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Info Update Section Widget
/// Displays role-based user profile information and update functionality
/// - For Admin: Shows "Admin Information" with Full Name, Email, Profile Picture
/// - For Trainee: Shows "Trainee Information" with Full Name, Email, License Number, Specialization, Profile Picture
class InfoUpdateSection extends StatelessWidget {
  final SettingsController controller;
  final String role; // "Admin" or "Trainee"

  const InfoUpdateSection({
    super.key,
    required this.controller,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: ShapeDecoration(
        color: const Color(0xFFFEFEFE),
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0xFFDFE1E6)),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title - Dynamic based on role
          Text(
            role == "Admin" ? 'Admin Information' : 'Trainee Information',
            style: getTsSectionTitle(),
          ),
          const SizedBox(height: 12),

          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Picture and Upload Button Row
              Row(
                children: [
                  // Profile Picture Avatar
                  Obx(() {
                    final path = controller.profileImagePath.value;
                    ImageProvider imageProvider;

                    if (path.isEmpty) {
                      imageProvider = AssetImage(ImagePath.defaultAvatar);
                    } else if (path.startsWith('http')) {
                      imageProvider = NetworkImage(path);
                    } else {
                      imageProvider = FileImage(File(path));
                    }

                    return Container(
                      width: 74,
                      height: 74,
                      decoration: ShapeDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                        shape: const OvalBorder(),
                      ),
                    );
                  }),

                  const SizedBox(width: 12),

                  // Upload Photo Button
                  GestureDetector(
                    onTap: () => controller.pickProfileImage(),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            width: 1,
                            color: Color(0xFF12295E),
                          ),
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Upload Icon
                          SvgIconHelper.buildIcon(
                            assetPath: IconPath.icUpload,
                            width: 20,
                            height: 20,
                            color: const Color(0xFF12295E),
                          ),
                          const SizedBox(width: 6),
                          // Upload Text
                          const Text(
                            'Upload photo',
                            style: TextStyle(
                              color: Color(0xFF12295E),
                              fontSize: 12,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Form Fields Section
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Form Fields Container
                  Column(
                    children: [
                      // Full Name Field
                      _buildFormField(
                        label: 'Full Name',
                        controller: controller.fullNameController,
                        placeholder: 'Dr. Alex Thompson',
                      ),
                      const SizedBox(height: 12),

                      // Email Address Field
                      _buildFormField(
                        readonly: true,
                        label: 'Email Address',
                        controller: controller.emailController,
                        placeholder: 'alex.thompson@clinic.com',
                      ),

                      // Additional fields for Trainee role
                      if (role == "Trainee") ...[
                        const SizedBox(height: 12),
                        // License Number and Specialization Row
                        Row(
                          children: [
                            // License Number Field
                            Expanded(
                              child: _buildFormField(
                                label: 'License Number',
                                controller: controller.licenseController,
                                placeholder: 'GM123LS',
                              ),
                            ),
                            const SizedBox(width: 6),
                            // Specialization Dropdown
                            Obx(() {
                              return Expanded(
                                child: SettingsDropdownField(
                                  label: 'Specialization',
                                  value: controller.specialization.value,
                                  dropdownOptions: const [
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
                              );
                            }),
                          ],
                        ),
                      ],
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: JurisdictionSection(controller: controller),
                  ),
                  const SizedBox(height: 24),

                  // Update Profile Button
                  ElevButton(
                    onPressed: () => controller.updateProfile(),

                    text: 'Update Profile',
                    backgroundColor: Color(0xFFA94907),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    paddingHeight: 14,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Helper method to build form fields with consistent styling
  Widget _buildFormField({
    required String label,
    required TextEditingController controller,
    required String placeholder,
    bool readonly = false,
  }) {
    return CustomField(
      readonly: readonly,
      label: label,
      hintText: placeholder,
      controller: controller,
      validator: (value) => AppValidator.validateEmptyText(label, value),
      keyboardType: TextInputType.emailAddress,
    );
  }
}
