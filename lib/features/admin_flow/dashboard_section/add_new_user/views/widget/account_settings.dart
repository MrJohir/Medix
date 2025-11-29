import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../core/common/widgets/custom_admin_drop_dwon.dart';
import '../../../../../../core/common/widgets/custom_switch_admin.dart';
import '../../controller/add_new_user_controller.dart';

class AccountSettings extends StatelessWidget {
  const AccountSettings({super.key, required this.controller});

  final AddNewUserController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Container(
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
                'Account Settings',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Montserrat',
                  color: Color(0xff141617),
                ),
              ),
              Text(
                'Role',
                style: TextStyle(
                  color: const Color(0xFF333333),
                  fontSize: 14,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w400,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 15),
                child: CustomAdminDropdown(
                  label: 'Select role',
                  value: controller.roleStatus,
                  items: controller.roleStatusItem,
                  onChanged: (String? newValue) {
                    controller.roleStatus(newValue);
                  },
                ),
              ),
              Text(
                'Jurisdiction',
                style: TextStyle(
                  color: const Color(0xFF333333),
                  fontSize: 14,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w400,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: CustomAdminDropdown(
                  label: 'Select jurisdiction',
                  value: controller.jurisdictionStatus,
                  items: controller.jurisdictionStatusItem,
                  onChanged: (String? value) {
                    controller.jurisdictionStatus(value);
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Account Status',
                        style: TextStyle(
                          color: const Color(0xFF141617),
                          fontSize: 12,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Obx(
                        () => Text(
                          controller.accountStatus.value
                              ? 'Account is active'
                              : 'Account is inactive',
                          style: TextStyle(
                            color: controller.accountStatus.value
                                ? const Color(0xFF22C55E)
                                : const Color(0xFFEF4444),
                            fontSize: 12,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 18),
                        child: Obx(
                          () => CustomSwitchAdmin(
                            value: controller.accountStatus.value,
                            onChanged: controller.toggleAccountStatus,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
