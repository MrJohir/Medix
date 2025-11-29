import 'package:dermaininstitute/core/common/widgets/custom_field.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/common/widgets/custom_admin_button.dart';
import '../../../../../../core/utils/constants/colors.dart';
import '../../controller/dashboard_controller.dart';

class ReferenceGuide extends StatelessWidget {
  const ReferenceGuide({super.key, required this.controller});

  final DashboardController controller;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text('Manage Reference Guide'),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Column(
            children: [
              CustomField(
                labelStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                label: 'Medication Name',
                hintText: 'medication name',
                controller: controller.medicationNameController,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: CustomField(
                  labelStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  label: 'Medication Dose & Description',
                  hintText: 'medication dose & description',
                  controller: controller.medicationDoseController,
                ),
              ),

              CustomAdminButton(
                backgroundColor: AppColors.primary,
                text: 'Save',
                textColor: Colors.white,
                borderColor: Colors.transparent,
                onPressed: () {
                  controller.saveMedicine();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
