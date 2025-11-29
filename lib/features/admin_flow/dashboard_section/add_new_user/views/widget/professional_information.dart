import 'package:flutter/material.dart';

import '../../../../../../core/common/widgets/custom_admin_drop_dwon.dart';
import '../../../../../../core/common/widgets/custom_admin_textfied.dart';
import '../../controller/add_new_user_controller.dart';

class ProfessionalInformation extends StatelessWidget {
  const ProfessionalInformation({super.key, required this.controller});

  final AddNewUserController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
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
              'Professional Information',
              style: TextStyle(
                color: const Color(0xFF141617),
                fontSize: 16,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
                height: 1.50,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12.0, bottom: 5),
              child: Text(
                'Institution',
                style: TextStyle(
                  color: const Color(0xFF333333),
                  fontSize: 14,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            CustomAdminTextField(
              controller: controller.institutionController,
              hintText: 'Medical institution',
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12.0, bottom: 5),
              child: Text(
                'Department',
                style: TextStyle(
                  color: const Color(0xFF333333),
                  fontSize: 14,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            CustomAdminTextField(
              controller: controller.departmentController,
              hintText: 'Department name',
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12.0, bottom: 5),
              child: Text(
                'Specialization',
                style: TextStyle(
                  color: const Color(0xFF333333),
                  fontSize: 14,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            CustomAdminDropdown(
              label: 'Select specialization',
              value: controller.specilizationStatus,
              items: controller.specilizationStatusItem,
              onChanged: (String? value) {
                controller.specilizationStatus(value);
              },
            ),
          ],
        ),
      ),
    );
  }
}
