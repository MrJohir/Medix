import 'package:dermaininstitute/core/common/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dermaininstitute/features/trainee_flow/emergency_protocols/controllers/emergency_protocols_controller.dart';
import 'package:dermaininstitute/features/trainee_flow/emergency_protocols/views/widgets/protocol_item.dart';
import 'package:dermaininstitute/features/trainee_flow/emergency_protocols/views/widgets/progress_header.dart';

class EmergencyProtocolsScreen extends StatelessWidget {
  const EmergencyProtocolsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final EmergencyProtocolsController controller = Get.put(
      EmergencyProtocolsController(),
    );

    return Scaffold(
      appBar: AppBarHelper.backWithAvatar(
        title: 'Emergency Protocols',
        onBackPressed: () => Get.back(),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            // Progress Header
            ProgressHeader(),

            SizedBox(height: 24.h),

            // Protocols List
            Expanded(
              child: Obx(
                () => controller.isLoading.value
                    ? Center(child: CircularProgressIndicator())
                    : RefreshIndicator(
                        onRefresh: controller.refreshProtocols,
                        child: ListView.builder(
                          itemCount: controller.protocols.length,
                          itemBuilder: (context, index) {
                            final protocol = controller.protocols[index];
                            return ProtocolItem(
                              protocol: protocol,
                              onToggle: () => controller
                                  .toggleProtocolCompletion(protocol.id),
                            );
                          },
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
