// import 'package:dermaininstitute/core/common/styles/global_text_style.dart';
// import 'package:dermaininstitute/core/common/widgets/custom_field.dart';
// import 'package:dermaininstitute/core/utils/constants/sizer.dart';
// import 'package:flutter/material.dart';
// import 'role_selection_widget.dart';
// import 'tag_selection_widget.dart';

// /// Basic Information Section Widget
// /// Contains user name input, role selection, and tag selection
// /// Organized in a clean card layout with proper spacing
// class BasicInformationSection extends StatelessWidget {
//   final TextEditingController nameController;
//   final String selectedRole;
//   final String selectedTag;
//   final ValueChanged<String> onRoleChanged;
//   final ValueChanged<String> onTagChanged;

//   const BasicInformationSection({
//     super.key,
//     required this.nameController,
//     required this.selectedRole,
//     required this.selectedTag,
//     required this.onRoleChanged,
//     required this.onTagChanged,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // Section title
//         Text(
//           'Basic Information',
//           style: getTsSectionTitle(
//             fontSize: 16,
//             fontWeight: FontWeight.w500,
//             color: const Color(0xFF141617),
//           ),
//         ),

//         SizedBox(height: AppSizes.szH12),

//         // User name input field
//         CustomField(
//           controller: nameController,
//           label: 'Search by Name',
//           hintText: 'Enter user name',
//           validator: (value) {
//             if (value == null || value.trim().isEmpty) {
//               return 'Please enter user name';
//             }
//             return null;
//           },
//         ),

//         SizedBox(height: AppSizes.szH16),

//         // Role selection
//         RoleSelectionWidget(
//           selectedRole: selectedRole,
//           onRoleChanged: onRoleChanged,
//         ),

//         SizedBox(height: AppSizes.szH16),

//         // Tag selection
//         TagSelectionWidget(
//           selectedTag: selectedTag,
//           onTagChanged: onTagChanged,
//         ),
//       ],
//     );
//   }
// }
