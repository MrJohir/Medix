import 'package:dermaininstitute/core/utils/constants/sizer.dart';
import 'package:dermaininstitute/features/trainee_flow/create_report/controllers/create_report_controller.dart';
import 'package:dermaininstitute/features/trainee_flow/create_report/views/widgets/custom_dropdown.dart';
import 'package:dermaininstitute/features/trainee_flow/create_report/views/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PatientInformationWidget extends StatelessWidget {
  final CreateReportController controller;

  const PatientInformationWidget({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSizes.szW14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSizes.szR12),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Patient Information',
            style: TextStyle(
              fontSize: AppSizes.font16,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF111827),
            ),
          ),
          SizedBox(height: AppSizes.szH16),

          Row(
            children: [
              // Age field
              Expanded(
                child: CustomTextField(
                  label: 'Age',
                  hintText: 'Patient age',
                  controller: controller.patientAgeController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Age is required';
                    }
                    final age = int.tryParse(value.trim());
                    if (age == null || age < 0 || age > 150) {
                      return 'Please enter a valid age';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(width: AppSizes.szW16),

              // Sex dropdown
              Expanded(
                child: Obx(() => CustomDropdown(
                  isRequired: true,
                  label: 'Sex',
                  hintText: 'Select sex',
                  value: controller.selectedPatientSex.value,
                  items: controller.sexOptions,
                  onChanged: (value) => controller.updatePatientSex(value ?? ''),
                )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
