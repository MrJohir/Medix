// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:dermaininstitute/core/common/widgets/custom_appbar.dart';
// import 'package:dermaininstitute/core/common/widgets/custom_note_card.dart';
// import 'package:dermaininstitute/core/common/widgets/custom_button.dart';
// import 'package:dermaininstitute/core/common/widgets/custom_outline_button.dart';
// import 'package:dermaininstitute/core/utils/constants/sizer.dart';
// import '../../controller/edit_user_controller.dart';
// import '../widgets/basic_information_section.dart';
// import '../widgets/user_content_section.dart';

// /// Edit User Screen
// /// Allows administrators to edit or create user profiles
// /// Features form validation, responsive design, and clean UI
// /// Uses GetX for state management and custom reusable widgets
// class EditUserScreen extends StatelessWidget {
//   const EditUserScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // Initialize controller
//     final controller = Get.put(EditUserController());

//     return Scaffold(
//       backgroundColor: const Color(0xFFF9FAFB),

//       // Custom AppBar with back button, title, and avatar with connection status
//       appBar: AppBarHelper.backWithAvatar(
//         title: controller.pageTitle,
//         showConnectionStatus: true,
//         onBackPressed: controller.onCancel,
//       ),

//       body: SafeArea(
//         child: Form(
//           key: controller.formKey,
//           child: SingleChildScrollView(
//             padding: EdgeInsets.all(AppSizes.szW20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Basic Information Section
//                 AppNoteCard(
//                   color: 'White',
//                   child: Obx(
//                     () => BasicInformationSection(
//                       nameController: controller.nameController,
//                       selectedRole: controller.selectedRole.value,
//                       selectedTag: controller.selectedTag.value,
//                       onRoleChanged: controller.onRoleChanged,
//                       onTagChanged: controller.onTagChanged,
//                     ),
//                   ),
//                 ),

//                 SizedBox(height: AppSizes.szH24),

//                 // User Content Section
//                 AppNoteCard(
//                   color: 'White',
//                   child: UserContentSection(
//                     institutionController: controller.institutionController,
//                     jurisdictionController: controller.jurisdictionController,
//                   ),
//                 ),

//                 SizedBox(height: AppSizes.szH24),

//                 // Bottom Action Buttons Section (now scrollable)
//                 _buildBottomActions(controller),

//                 // Add bottom safe area padding
//                 SizedBox(height: MediaQuery.of(Get.context!).padding.bottom),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   /// Build bottom action buttons (Cancel and Done/Update) - now scrollable
//   Widget _buildBottomActions(EditUserController controller) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         // Cancel button (Outline style)
//         OutButton(
//           onPressed: controller.onCancel,
//           text: 'Cancel',
//           color: const Color(0xFF12295E),
//           backgroundColor: Colors.transparent,
//           fontWeight: FontWeight.w600,
//           fontSize: 14,
//           paddingHeight: AppSizes.szH12,
//         ),

//         SizedBox(height: AppSizes.szH12),

//         // Save button (Filled style with loading state)
//         Obx(
//           () => ElevButton(
//             onPressed: controller.isLoading.value ? null : controller.saveUser,
//             text: controller.isLoading.value
//                 ? 'Saving...'
//                 : controller.saveButtonText,
//             backgroundColor: const Color(0xFFA94907),
//             color: Colors.white,
//             fontWeight: FontWeight.w600,
//             fontSize: 14,
//             paddingHeight: AppSizes.szH12,
//             preIcon: controller.isLoading.value
//                 ? SizedBox(
//                     width: AppSizes.szW16,
//                     height: AppSizes.szH16,
//                     child: const CircularProgressIndicator(
//                       strokeWidth: 2,
//                       valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//                     ),
//                   )
//                 : null,
//           ),
//         ),
//       ],
//     );
//   }
// }
