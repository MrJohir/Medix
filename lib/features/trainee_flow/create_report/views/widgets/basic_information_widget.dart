import 'package:dermaininstitute/core/utils/constants/sizer.dart';
import 'package:dermaininstitute/features/trainee_flow/create_report/controllers/create_report_controller.dart';
import 'package:dermaininstitute/features/trainee_flow/create_report/views/widgets/custom_dropdown.dart';
import 'package:dermaininstitute/features/trainee_flow/create_report/views/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BasicInformationWidget extends StatelessWidget {
  final CreateReportController controller;

  const BasicInformationWidget({
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
            'Basic Information',
            style: TextStyle(
              fontSize: AppSizes.font16,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF111827),
            ),
          ),
          SizedBox(height: AppSizes.szH16),

          // Incident Title
          CustomTextField(
            label: 'Incident Title',
            hintText: 'Brief description of the incident',
            controller: controller.incidentTitleController,
            isRequired: true,
          ),
          SizedBox(height: AppSizes.szH16),

          // Procedure Dropdown
          Obx(() => CustomDropdown(
            label: 'Procedure',
            hintText: 'Select procedure',
            value: controller.selectedProcedure.value,
            items: controller.procedureOptions,
            onChanged: (value) => controller.updateProcedure(value ?? ''),
            isRequired: true,
          )),
          SizedBox(height: AppSizes.szH16),

          // Severity Dropdown
          Obx(() => CustomDropdown(
            label: 'Severity',
            hintText: 'Select severity',
            value: controller.selectedSeverity.value,
            items: controller.severityOptions,
            onChanged: (value) => controller.updateSeverity(value ?? ''),
            isRequired: true,
          )),
        ],
      ),
    );
  }
}
