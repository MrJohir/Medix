import 'package:dermaininstitute/core/utils/constants/sizer.dart';
import 'package:dermaininstitute/features/trainee_flow/create_report/controllers/create_report_controller.dart';
import 'package:dermaininstitute/features/trainee_flow/create_report/views/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class IncidentDetailsWidget extends StatelessWidget {
  final CreateReportController controller;

  const IncidentDetailsWidget({
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
            'Incident Details',
            style: TextStyle(
              fontSize: AppSizes.font16,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF111827),
            ),
          ),
          SizedBox(height: AppSizes.szH16),

          // Description of Incident
          CustomTextField(
            label: 'Description of Incident',
            hintText: 'Detailed description of what happened...',
            controller: controller.incidentDescriptionController,
            maxLines: 4,
            isRequired: true,
            contentPadding: EdgeInsets.symmetric(
              horizontal: AppSizes.szW12,
              vertical: AppSizes.szH10,
            ),
          ),
          SizedBox(height: AppSizes.szH20),

          // Actions Taken
          CustomTextField(
            label: 'Actions Taken',
            hintText: 'What immediate actions were taken to...',
            controller: controller.actionsTakenController,
            maxLines: 4,
            isRequired: true,
            contentPadding: EdgeInsets.symmetric(
              horizontal: AppSizes.szW12,
              vertical: AppSizes.szH10,
            ),
          ),
          SizedBox(height: AppSizes.szH20),

          // Outcome
          CustomTextField(
            label: 'Outcome',
            hintText: 'Final outcome and patient status...',
            controller: controller.outcomeController,
            maxLines: 4,
            isRequired: true,
            contentPadding: EdgeInsets.symmetric(
              horizontal: AppSizes.szW12,
              vertical: AppSizes.szH10,
            ),
          ),
          SizedBox(height: AppSizes.szH20),

          // Lessons Learned
          CustomTextField(
            label: 'Lessons Learned',
            hintText: 'What could be done differently in the f...',
            controller: controller.lessonsLearnedController,
            maxLines: 4,
            isRequired: true,
            contentPadding: EdgeInsets.symmetric(
              horizontal: AppSizes.szW12,
              vertical: AppSizes.szH10,
            ),
          ),
        ],
      ),
    );
  }
}
