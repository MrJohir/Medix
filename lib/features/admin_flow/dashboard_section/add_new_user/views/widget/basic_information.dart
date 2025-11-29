import 'package:flutter/material.dart';

import '../../../../../../core/common/widgets/custom_admin_textfied.dart';
import '../../controller/add_new_user_controller.dart';

class BasicInformation extends StatelessWidget {
  const BasicInformation({super.key, required this.controller});

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
              'Basic Information',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                fontFamily: 'Montserrat',
                color: Color(0xff141617),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'First name',
                          style: TextStyle(
                            color: const Color(0xFF333333),
                            fontSize: 14,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 5),
                        CustomAdminTextField(
                          readOnly: true,
                          controller: controller.firstNameController,
                          hintText: 'First Name',
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Last Name',
                          style: TextStyle(
                            color: const Color(0xFF333333),
                            fontSize: 14,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 5),
                        CustomAdminTextField(
                          readOnly: true,
                          controller: controller.lastNameController,
                          hintText: 'Last Name',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Text(
              'Email Address',
              style: TextStyle(
                color: const Color(0xFF333333),
                fontSize: 14,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w400,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 12),
              child: CustomAdminTextField(
                readOnly: true,
                controller: controller.emailController,
                hintText: 'user@example.com',
              ),
            ),
            Text(
              'Phone Number',
              style: TextStyle(
                color: const Color(0xFF333333),
                fontSize: 14,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w400,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 5),
              child: CustomAdminTextField(
                readOnly: true,
                controller: controller.phoneNumberController,
                hintText: '+1 (555) 123-4567',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
