import 'package:dermaininstitute/core/utils/constants/colors.dart';
import 'package:dermaininstitute/core/utils/constants/image_path.dart';
import 'package:dermaininstitute/features/common/settings/controllers/settings_controller.dart';
import 'package:dermaininstitute/features/trainee_flow/triage/views/screens/emargency_protocal_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dermaininstitute/core/utils/constants/sizer.dart';
import 'package:dermaininstitute/features/trainee_flow/triage/controllers/triage_controller.dart';
import 'package:dermaininstitute/features/trainee_flow/triage/views/widgets/message_bubble.dart';
import 'package:dermaininstitute/features/trainee_flow/triage/views/widgets/emergency_categories.dart';

class TriageScreen extends StatelessWidget {
  const TriageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TriageController controller = Get.put(TriageController());
    final SettingsController settingsController = Get.put(SettingsController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        // leading: Builder(
        //   builder: (context) {
        //     return IconButton(
        //       icon: Icon(Icons.menu, color: Colors.black),
        //       onPressed: () {
        //         Scaffold.of(context).openDrawer();
        //       },
        //     );
        //   },
        // ),
        title: Text(
          "Triage",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),

        actions: [
          Padding(
            padding: EdgeInsets.only(right: AppSizes.szW20),
            child: GestureDetector(
              onTap: () {
                controller.startNewChat();
              },
              child: Container(
                width: AppSizes.szW30, // adjust size
                height: AppSizes.szW30,
                decoration: BoxDecoration(
                  color: AppColors.secondary,
                  shape: BoxShape.circle, // makes it round
                ),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: AppSizes.szW24,
                ),
              ),
            ),
          ),
        ],
      ),
      // drawer: CustomDrawer(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSizes.szW20),
        child: Column(
          children: [
            // Chat messages area
            Expanded(
              child: Obx(
                () => controller.messages.isEmpty
                    ? Center(
                        child: Text(
                          'Whats you want to know?',
                          style: TextStyle(
                            fontSize: AppSizes.font16,
                            color: Color(0xFF12295E),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                    : ListView.builder(
                        controller: controller.scrollController,
                        padding: EdgeInsets.only(top: AppSizes.szH16),
                        itemCount: controller.messages.length,
                        itemBuilder: (context, index) {
                          final message = controller.messages[index];
                          debugPrint(
                            'Rendering message at index $index: ${message.complicationDetected}',
                          );
                          return MessageBubble(message: message);
                        },
                      ),
              ),
            ),

            // View Emergency Protocols Button
            // View Emergency Protocols Button - show only if complication detected
            Obx(() {
              final hasComplication = controller.messages.any(
                (msg) => msg.complicationDetected == true,
              );

              if (!hasComplication) {
                return SizedBox.shrink(); // Hide button if no complication
              }

              return Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(vertical: AppSizes.szH16),
                child: ElevatedButton(
                  onPressed: () {
                    final jurisdiction =
                        settingsController.user.value?.jurisdiction ?? '';
                    controller.callEmergencyProtocol(jurisdiction).then((_) {
                      Get.to(() => EmergencyProtocolScreen());
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Color(0xFF12295E),
                    side: BorderSide(color: Color(0xFF12295E)),
                    padding: EdgeInsets.symmetric(
                      vertical: AppSizes.szH10,
                      horizontal: AppSizes.szW16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSizes.szR50),
                    ),
                    elevation: 0,
                  ),
                  child: controller.isLoading.value
                      ? Center(
                          child: Text(
                            'Loading...',
                            style: TextStyle(
                              fontSize: AppSizes.font12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      : Text(
                          'View Emergency Protocols',
                          style: TextStyle(
                            fontSize: AppSizes.font12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              );
            }),

            // Only show Emergency Categories if no emergency protocol fetched yet
            Obx(() {
              final hasComplication = controller.messages.any(
                (msg) => msg.id.isNotEmpty,
              );
              if (hasComplication) return SizedBox.shrink();
              return EmergencyCategories();
            }),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image preview if any
                Obx(() {
                  final file = controller.selectedImage.value;
                  if (file == null) return SizedBox.shrink();
                  return Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 8),
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Image.file(
                          file,
                          height: 80,
                          width: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () => controller.selectedImage.value = null,
                          child: CircleAvatar(
                            radius: 12,
                            backgroundColor: Colors.black54,
                            child: Icon(
                              Icons.close,
                              size: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),

                // Text field with buttons
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(bottom: AppSizes.szR20),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(AppSizes.szR12),
                  ),
                  child: Stack(
                    children: [
                      TextField(
                        controller: controller.messageController,
                        maxLines: 5,
                        minLines: 1,
                        decoration: InputDecoration(
                          hintText: 'Describe what you want to see',
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Inter',
                            color: Colors.grey.shade500,
                            fontSize: AppSizes.font14,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                            top: AppSizes.szW20,
                            left: AppSizes.szW20,
                            right: AppSizes.szW100, // Space for buttons
                            bottom: AppSizes.szW20,
                          ),
                        ),
                        onSubmitted: (value) {
                          final jurisdiction =
                              settingsController.user.value?.jurisdiction ?? '';
                          controller.sendMessageWithOptionalImage(jurisdiction);
                        },
                      ),

                      // Camera and Send buttons
                      Positioned(
                        bottom: AppSizes.szH8,
                        right: AppSizes.szW8,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: () {
                                controller.showCameraOptions();
                              },
                              child: Icon(
                                Icons.camera_alt_outlined,
                                color: Colors.black,
                                size: AppSizes.szR20,
                              ),
                            ),
                            SizedBox(width: AppSizes.szW8),

                            Obx(
                              () => GestureDetector(
                                onTap: controller.isSendingMessage.value
                                    ? null
                                    : () {
                                        final jurisdiction =
                                            settingsController
                                                .user
                                                .value
                                                ?.jurisdiction ??
                                            '';
                                        controller.sendMessageWithOptionalImage(
                                          jurisdiction,
                                        );
                                      },
                                child: Container(
                                  padding: EdgeInsets.all(AppSizes.szR8),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    shape: BoxShape.circle,
                                  ),
                                  child: controller.isSendingMessage.value
                                      ? SizedBox(
                                          width: AppSizes.szW16,
                                          height: AppSizes.szH16,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                  Colors.white,
                                                ),
                                          ),
                                        )
                                      : Icon(
                                          Icons.arrow_upward,
                                          color: Colors.white,
                                          size: AppSizes.szR20,
                                        ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.white),
            child: Center(
              child: Image.asset(
                ImagePath.adminProfile,
                width: 120,
                height: 120,
                fit: BoxFit.contain,
              ),
            ),
          ),

          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: 50,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Icon(Icons.history, color: Colors.black),
                title: Text(
                  "history ${index + 1}",
                  style: TextStyle(
                    fontSize: AppSizes.font14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                onTap: () {
                  // Handle About Us tap
                  Navigator.pop(context); // Close the drawer
                },
              );
            },
          ), // Example with one item
        ],
      ),
    );
  }
}
