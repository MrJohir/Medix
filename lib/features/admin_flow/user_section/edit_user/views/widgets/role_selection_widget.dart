// import 'package:dermaininstitute/core/common/styles/global_text_style.dart';
// import 'package:dermaininstitute/core/utils/constants/sizer.dart';
// import 'package:flutter/material.dart';

// /// Role Selection Widget
// /// Allows users to select between Administrator and Trainee roles
// /// Uses square checkboxes with custom styling to match the Figma design
// class RoleSelectionWidget extends StatelessWidget {
//   final String selectedRole;
//   final ValueChanged<String> onRoleChanged;

//   const RoleSelectionWidget({
//     super.key,
//     required this.selectedRole,
//     required this.onRoleChanged,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // Role label
//         Text(
//           'Role',
//           style: getTsInputLabel(
//             fontSize: 12,
//             fontWeight: FontWeight.w400,
//             color: const Color(0xFF333333),
//           ),
//         ),

//         SizedBox(height: AppSizes.szH8),

//         // Role options in a row
//         Row(
//           children: [
//             // Administrator option
//             Expanded(
//               child: _buildRoleOption(
//                 value: 'Administrator',
//                 label: 'Administrator',
//                 isSelected: selectedRole == 'Administrator',
//               ),
//             ),

//             SizedBox(width: AppSizes.szW8),

//             // Trainee option
//             Expanded(
//               child: _buildRoleOption(
//                 value: 'Trainee',
//                 label: 'Trainee',
//                 isSelected: selectedRole == 'Trainee',
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   /// Build individual role option with square checkbox styling based on Figma design
//   Widget _buildRoleOption({
//     required String value,
//     required String label,
//     required bool isSelected,
//   }) {
//     return GestureDetector(
//       onTap: () => onRoleChanged(value),
//       child: Container(
//         clipBehavior: Clip.antiAlias,
//         decoration: const BoxDecoration(),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Container(
//               padding: EdgeInsets.all(AppSizes.szR8),
//               decoration: ShapeDecoration(
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(AppSizes.szR8),
//                 ),
//               ),
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Square checkbox
//                   Container(
//                     width: AppSizes.szW20,
//                     height: AppSizes.szH20,
//                     decoration: BoxDecoration(
//                       color: isSelected
//                           ? const Color(0xFF12295E)
//                           : Colors.transparent,
//                       border: Border.all(
//                         color: isSelected
//                             ? const Color(0xFF12295E)
//                             : const Color(0xFFDFE1E6),
//                         width: 2,
//                       ),
//                       borderRadius: BorderRadius.circular(AppSizes.szR4),
//                     ),
//                     child: isSelected
//                         ? const Icon(Icons.check, color: Colors.white, size: 14)
//                         : null,
//                   ),
//                 ],
//               ),
//             ),

//             SizedBox(width: AppSizes.szW8),

//             // Role label
//             Expanded(
//               child: Text(
//                 label,
//                 style: getTsRegularText(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w500,
//                   color: const Color(0xFF333333),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
