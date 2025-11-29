import 'package:dermaininstitute/core/utils/constants/sizer.dart';
import 'package:dermaininstitute/features/trainee_flow/protocols/controllers/protocols_controller.dart';
import 'package:dermaininstitute/features/trainee_flow/protocols/models/protocol_enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocationTab extends StatelessWidget {
  const LocationTab({
    super.key,
    required this.location,
    required this.controller,
  });

  final ProtocolLocation location;
  final ProtocolsController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GestureDetector(
        onTap: () => controller.selectLocation(location),
        child: Container(
          margin: EdgeInsets.all(AppSizes.szR2),
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 14),
          decoration: BoxDecoration(
            color: controller.selectedLocation.value == location
                ? Colors.white
                : Colors.transparent,
            borderRadius: BorderRadius.circular(AppSizes.szR6),
            boxShadow: controller.selectedLocation.value == location
                ? [
                    BoxShadow(
                      color: Color(0x3DE4E5E7),
                      blurRadius: 2,
                      offset: Offset(0, 1),
                      spreadRadius: 0,
                    ),
                  ]
                : null,
          ),
          child: Text(
            location.value,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: controller.selectedLocation.value == location
                  ? AppSizes.font14
                  : AppSizes.font12,
              color: controller.selectedLocation.value == location
                  ? Colors.black
                  : const Color(0xFF42526E),
            ),
          ),
        ),
      );
    });
  }
}
