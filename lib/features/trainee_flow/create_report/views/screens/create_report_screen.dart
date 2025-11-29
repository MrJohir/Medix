import 'package:dermaininstitute/core/utils/constants/sizer.dart';
import 'package:dermaininstitute/features/trainee_flow/create_report/controllers/create_report_controller.dart';
import 'package:dermaininstitute/features/trainee_flow/create_report/views/widgets/basic_information_widget.dart';
import 'package:dermaininstitute/features/trainee_flow/create_report/views/widgets/incident_details_widget.dart';
import 'package:dermaininstitute/features/trainee_flow/create_report/views/widgets/patient_information_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateReportScreen extends StatelessWidget {
  const CreateReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CreateReportController controller = Get.put(CreateReportController());

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF9FAFB),
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.only(left: AppSizes.szW20),
          child: IconButton(
            onPressed: () {
              // Close any open snackbars before going back
              if (Get.isSnackbarOpen == true) {
                Get.closeCurrentSnackbar();
              }
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          ),
        ),
        title: Padding(
          padding: EdgeInsets.only(left: AppSizes.szW20),
          child: Text(
            'Create Reports',
            style: TextStyle(
              fontSize: AppSizes.font18,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF111827),
            ),
          ),
        ),
        titleSpacing: 0,
      ),
      body: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: controller.formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.szW20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: AppSizes.szH30),

              // Information Note
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(AppSizes.szR14),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(AppSizes.szR12),
                  border: Border.all(color: const Color(0xFF3B82F6), width: 1),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.warning_amber_rounded,
                      color: const Color(0xFF3B82F6),
                      size: AppSizes.szW20,
                    ),
                    SizedBox(width: AppSizes.szW12),
                    Expanded(
                      child: Text(
                        'Complete incident documentation is required for regulatory compliance and quality assurance.',
                        style: TextStyle(
                          fontSize: AppSizes.font14,
                          color: const Color(0xFF1E40AF),
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: AppSizes.szH24),

              // Basic Information Section
              BasicInformationWidget(controller: controller),
              SizedBox(height: AppSizes.szH24),

              // Patient Information Section
              PatientInformationWidget(controller: controller),
              SizedBox(height: AppSizes.szH24),

              // Incident Details Section
              IncidentDetailsWidget(controller: controller),
              SizedBox(height: AppSizes.szH32),

              // Action Buttons
              Row(
                children: [
                  // Save as Draft Button
                  Expanded(
                    child: Obx(
                      () => OutlinedButton(
                        onPressed:
                            controller.isSavingDraft.value ||
                                controller.isSubmitting.value
                            ? null
                            : () => controller.saveAsDraft(),
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            vertical: AppSizes.szH16,
                          ),
                          side: const BorderSide(
                            color: Color(0xFFD1D5DB),
                            width: 1,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppSizes.szR50),
                          ),
                        ),
                        child: controller.isSavingDraft.value
                            ? SizedBox(
                                height: AppSizes.szH20,
                                width: AppSizes.szW20,
                                child: const CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Color(0xFF6B7280),
                                ),
                              )
                            : Text(
                                'Save as Draft',
                                style: TextStyle(
                                  fontSize: AppSizes.font16,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF374151),
                                ),
                              ),
                      ),
                    ),
                  ),
                  SizedBox(width: AppSizes.szW16),

                  // Submit Log Button
                  Expanded(
                    child: Obx(
                      () => ElevatedButton(
                        onPressed:
                            controller.isSubmitting.value ||
                                controller.isSavingDraft.value
                            ? null
                            : () => controller.submitReport(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFA94907),
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                            vertical: AppSizes.szH16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppSizes.szR50),
                          ),
                          elevation: 0,
                        ),
                        child: controller.isSubmitting.value
                            ? SizedBox(
                                height: AppSizes.szH20,
                                width: AppSizes.szW20,
                                child: const CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                'Submit Log',
                                style: TextStyle(
                                  fontSize: AppSizes.font16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppSizes.szH32),
            ],
          ),
        ),
      ),
    );
  }
}
