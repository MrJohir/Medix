import 'package:dermaininstitute/core/common/styles/global_text_style.dart';
import 'package:dermaininstitute/core/common/widgets/custom_appbar.dart';
import 'package:dermaininstitute/core/common/widgets/custom_button.dart';
import 'package:dermaininstitute/core/common/widgets/custom_field.dart';
import 'package:dermaininstitute/core/common/widgets/custom_note_card.dart';
import 'package:dermaininstitute/core/utils/constants/icon_path.dart';
import 'package:dermaininstitute/core/utils/constants/sizer.dart';
import 'package:dermaininstitute/core/utils/helpers/svg_icon_helper.dart';
import 'package:dermaininstitute/features/trainee_flow/bottom_nav_bar/controllers/bottom_nav_bar_controller.dart';
import 'package:dermaininstitute/features/trainee_flow/calculator/controllers/calculator_controller.dart';
import 'package:dermaininstitute/features/trainee_flow/calculator/views/widgets/calculation_result_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CalculatorScreen extends StatelessWidget {
  CalculatorScreen({super.key});

  final CalculatorController controller = Get.put(CalculatorController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBarHelper.backWithAvatar(
        title: 'Calculator',
        onBackPressed: () {
          // Navigate back to home screen via bottom navigation
          final bottomNavController = BottomNavbarController.instance;
          bottomNavController.changeIndex(0); // Index 0 is home screen
        },
      ),
      body: Form(
        key: controller.formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              left: AppSizes.szW20,
              right: AppSizes.szW20,
              top: AppSizes.szH32,
              bottom: AppSizes.szH20,
            ),
            child: Column(
              children: [
                /// -- Critical Safety Notice
                AppNoteCard(
                  color: 'Yellow',
                  radius: AppSizes.szR12,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgIconHelper.buildIcon(
                        assetPath: IconPath.icWarningError,
                        width: AppSizes.szW24,
                        height: AppSizes.szH24,
                      ),
                      SizedBox(height: AppSizes.szH8),
                      Text(
                        'Critical Safety Notice: Always double-check calculations and verify against local protocols. This calculator provides guidance only and should not replace clinical judgment.',
                        style: getTsNotesText(lineHeight: 1.2),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: AppSizes.szH24),

                /// -- Patient Information Section
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(AppSizes.szR14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEFEFE),
                    borderRadius: BorderRadius.circular(AppSizes.szR12),
                    border: Border.all(
                      color: const Color(0xFFDFE1E6),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Patient Information',
                        style: getTsSectionTitle(fontSize: 16),
                      ),
                      SizedBox(height: AppSizes.szH12),

                      /// -- Treatment Area Field
                      CustomField(
                        label: "Treatment Area (body)",
                        hintText:
                            "Enter treatment area (e.g., face, forehead, body)",
                        controller: controller.treatmentAreaController,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Treatment area is required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: AppSizes.szH6),

                      /// -- Age Field
                      CustomField(
                        label: "Age (years)",
                        hintText: "Enter patient age",
                        controller: controller.ageController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Age is required';
                          }
                          final age = int.tryParse(value.trim());
                          if (age == null || age < 1 || age > 120) {
                            return 'Please enter a valid age (1-120 years)';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: AppSizes.szH24),

                /// -- Medication Selection Section
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(AppSizes.szR14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEFEFE),
                    borderRadius: BorderRadius.circular(AppSizes.szR12),
                    border: Border.all(
                      color: const Color(0xFFDFE1E6),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Medication Selection',
                        style: getTsSectionTitle(fontSize: 16),
                      ),
                      SizedBox(height: AppSizes.szH12),

                      /// -- Medication Dropdown Field
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Select Medication', style: getTsInputLabel()),
                          SizedBox(height: AppSizes.szH8),
                          GestureDetector(
                            onTap: () => _showMedicationBottomSheet(context),
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                horizontal: AppSizes.szW16,
                                vertical: AppSizes.szH14,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(
                                  AppSizes.szR10,
                                ),
                                border: Border.all(
                                  color: const Color(0xFFEDF1F3),
                                  width: 1,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0x3DE4E5E7),
                                    blurRadius: 2,
                                    offset: Offset(0, 1),
                                    spreadRadius: 0,
                                  ),
                                ],
                              ),
                              child: Obx(
                                () => Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        controller
                                                .selectedMedication
                                                .value
                                                .isEmpty
                                            ? 'Choose medication for calculation'
                                            : controller
                                                  .selectedMedication
                                                  .value,
                                        style:
                                            controller
                                                .selectedMedication
                                                .value
                                                .isEmpty
                                            ? getTsInputPlaceholder()
                                            : getTsRegularText(fontSize: 14),
                                      ),
                                    ),
                                    Icon(
                                      Icons.keyboard_arrow_down,
                                      color: const Color(0xFF8993A4),
                                      size: AppSizes.szW16,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: AppSizes.szH24),

                /// -- Calculate Button
                Obx(
                  () => ElevButton(
                    text: controller.isCalculating.value
                        ? 'Calculating...'
                        : 'Calculate Safe Dose',
                    backgroundColor: const Color(0xFFA94907),
                    fontSize: 12,
                    paddingHeight: AppSizes.szH10,
                    onPressed: controller.isCalculating.value
                        ? null
                        : controller.calculateSafeDose,
                  ),
                ),
                SizedBox(height: AppSizes.szH24),

                /// -- Calculation Result Display
                /// This section displays the calculation results below the calculate button
                /// Shows either a positive (safe) or negative (review required) result
                /// Only visible after calculation is completed
                CalculationResultWidget(controller: controller),

                /// -- Conditional spacing after result
                Obx(
                  () => controller.showResult.value
                      ? SizedBox(height: AppSizes.szH24)
                      : const SizedBox.shrink(),
                ),

                /// -- Quick Reference Guide Section
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(AppSizes.szR14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEFEFE),
                    borderRadius: BorderRadius.circular(AppSizes.szR12),
                    border: Border.all(
                      color: const Color(0xFFDFE1E6),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Quick Reference Guide',
                        style: getTsSectionTitle(fontSize: 16),
                      ),
                      SizedBox(height: AppSizes.szH12),

                      /// -- Medication Cards
                      Obx(() {
                        if (controller.isLoadingMedicines.value) {
                          return Center(
                            child: Padding(
                              padding: EdgeInsets.all(AppSizes.szR16),
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }

                        if (controller.medicines.isEmpty) {
                          return Center(
                            child: Padding(
                              padding: EdgeInsets.all(AppSizes.szR16),
                              child: Text(
                                'No medicines available',
                                style: getTsRegularText(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          );
                        }

                        return ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.medicines.length,
                          separatorBuilder: (context, index) =>
                              SizedBox(height: AppSizes.szH6),
                          itemBuilder: (context, index) {
                            final medicine = controller.medicines[index];
                            // Cycle through original colors like the hardcoded version
                            final colorData = _getColorForIndex(index);
                            return _buildMedicationReferenceCard(
                              '${medicine.title}:',
                              medicine.description,
                              colorData['cardColor'],
                              colorData['textColor'],
                            );
                          },
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMedicationReferenceCard(
    String medicationName,
    String dosage,
    String cardColor,
    Color textColor,
  ) {
    return AppNoteCard(
      color: cardColor,
      radius: AppSizes.szR6,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            medicationName,
            style: getTsBoldText(
              fontSize: 12,
              color: textColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(width: AppSizes.szW8),
          Expanded(
            child: Text(
              dosage,
              style: getTsNotesText(fontSize: 12, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  /// Get color scheme for medication card based on index
  /// Cycles through original colors: Red, Blue, Blue, Yellow
  Map<String, dynamic> _getColorForIndex(int index) {
    final colorSchemes = [
      {'cardColor': 'Red', 'textColor': const Color(0xFFDB0000)},
      {'cardColor': 'Blue', 'textColor': const Color(0xFF1A4DBE)},
      {'cardColor': 'Blue', 'textColor': const Color(0xFF1A4DBE)},
      {'cardColor': 'Yellow', 'textColor': const Color(0xFFC29403)},
    ];

    // Cycle through the color schemes
    return colorSchemes[index % colorSchemes.length];
  }

  void _showMedicationBottomSheet(BuildContext context) {
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppSizes.szR20),
            topRight: Radius.circular(AppSizes.szR20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(AppSizes.szR16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Select Medication',
                    style: getTsSectionTitle(fontSize: 16),
                  ),
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: Icon(Icons.close),
                  ),
                ],
              ),
            ),
            Divider(height: 1),
            SizedBox(
              height: 300,
              child: ListView.builder(
                itemCount: controller.medications.length,
                itemBuilder: (context, index) {
                  final medication = controller.medications[index];
                  return ListTile(
                    title: Text(
                      medication,
                      style: getTsRegularText(fontSize: 14),
                    ),
                    onTap: () {
                      controller.selectMedication(medication);
                      Get.back();
                    },
                  );
                },
              ),
            ),
            SizedBox(height: AppSizes.szH20),
          ],
        ),
      ),
    );
  }
}
