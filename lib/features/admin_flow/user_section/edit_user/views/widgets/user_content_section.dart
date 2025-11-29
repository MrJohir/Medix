// import 'package:dermaininstitute/core/common/styles/global_text_style.dart';
// import 'package:dermaininstitute/core/common/widgets/custom_field.dart';
// import 'package:dermaininstitute/core/utils/constants/sizer.dart';
// import 'package:flutter/material.dart';

// /// User Content Section Widget
// /// Contains institution and jurisdiction input fields
// /// Organized in a clean card layout with proper spacing
// class UserContentSection extends StatelessWidget {
//   final TextEditingController institutionController;
//   final TextEditingController jurisdictionController;

//   const UserContentSection({
//     super.key,
//     required this.institutionController,
//     required this.jurisdictionController,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // Section title
//         Text(
//           'User Content',
//           style: getTsSectionTitle(
//             fontSize: 16,
//             fontWeight: FontWeight.w500,
//             color: const Color(0xFF141617),
//           ),
//         ),

//         SizedBox(height: AppSizes.szH12),

//         // Institution input field
//         CustomField(
//           controller: institutionController,
//           label: 'Institution',
//           hintText: 'Enter institution name',
//           validator: (value) {
//             if (value == null || value.trim().isEmpty) {
//               return 'Please enter institution name';
//             }
//             return null;
//           },
//         ),

//         SizedBox(height: AppSizes.szH16),

//         // Jurisdiction input field
//         CustomField(
//           controller: jurisdictionController,
//           label: 'Jurisdiction',
//           hintText: 'Enter jurisdiction',
//           validator: (value) {
//             if (value == null || value.trim().isEmpty) {
//               return 'Please enter jurisdiction';
//             }
//             return null;
//           },
//         ),
//       ],
//     );
//   }
// }
