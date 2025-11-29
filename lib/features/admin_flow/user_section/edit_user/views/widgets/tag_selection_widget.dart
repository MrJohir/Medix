// import 'package:dermaininstitute/core/common/styles/global_text_style.dart';
// import 'package:dermaininstitute/core/utils/constants/sizer.dart';
// import 'package:flutter/material.dart';

// /// Tag Selection Widget
// /// Allows users to select between Active and Inactive status tags
// /// Uses square checkboxes with custom styling to match the Figma design
// class TagSelectionWidget extends StatelessWidget {
//   final String selectedTag;
//   final ValueChanged<String> onTagChanged;

//   const TagSelectionWidget({
//     super.key,
//     required this.selectedTag,
//     required this.onTagChanged,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // Tags label
//         Text(
//           'Tags',
//           style: getTsInputLabel(
//             fontSize: 12,
//             fontWeight: FontWeight.w400,
//             color: const Color(0xFF333333),
//           ),
//         ),

//         SizedBox(height: AppSizes.szH8),

//         // Tag options
//         Column(
//           children: [
//             // Active tag option
//             _buildTagOption(
//               value: 'Active',
//               label: 'Active',
//               isSelected: selectedTag == 'Active',
//             ),

//             SizedBox(height: AppSizes.szH8),

//             // Inactive tag option
//             _buildTagOption(
//               value: 'Inactive',
//               label: 'Inactive',
//               isSelected: selectedTag == 'Inactive',
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   /// Build individual tag option with square checkbox styling based on Figma design
//   Widget _buildTagOption({
//     required String value,
//     required String label,
//     required bool isSelected,
//   }) {
//     return GestureDetector(
//       onTap: () => onTagChanged(value),
//       child: Container(
//         width: double.infinity,
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

//             SizedBox(width: AppSizes.szW12),

//             // Tag label
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
