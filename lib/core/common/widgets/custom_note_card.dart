import 'package:dermaininstitute/core/utils/constants/sizer.dart';
import 'package:flutter/material.dart';

class AppNoteCard extends StatelessWidget {
  final String? color;
  final Widget child;
  final double? radius;

  const AppNoteCard({super.key, this.color, required this.child, this.radius});

  @override
  Widget build(BuildContext context) {
    switch (color) {
      case 'Red':
        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFFFFDDDD), // Light red background
            borderRadius: BorderRadius.circular(radius ?? AppSizes.szR8),
            border: Border.all(
              color: const Color(0xFFFF8484), // Orange border
              width: 1,
            ),
          ),
          child: Padding(padding: EdgeInsets.all(AppSizes.szR14), child: child),
        );
      case 'Yellow':
        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFFFFF6DD), // Light yellow background
            borderRadius: BorderRadius.circular(radius ?? AppSizes.szR8),
            border: Border.all(
              color: const Color(0xFFEAB308), // Orange border
              width: 1,
            ),
          ),
          child: Padding(padding: EdgeInsets.all(AppSizes.szR14), child: child),
        );
      case 'Blue':
        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFFEFF6FF), // Light blue background
            borderRadius: BorderRadius.circular(radius ?? AppSizes.szR8),
            border: Border.all(
              color: const Color(0xFF97C4FD), // Blue border
              width: 1,
            ),
          ),
          child: Padding(padding: EdgeInsets.all(AppSizes.szR14), child: child),
        );
      case 'Green':
        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFFEDF6F4), // Light green background
            borderRadius: BorderRadius.circular(radius ?? AppSizes.szR8),
            border: Border.all(
              color: const Color(0xFF00CB0E), // Green border
              width: 1,
            ),
          ),
          child: Padding(padding: EdgeInsets.all(AppSizes.szR14), child: child),
        );
      case 'White':
        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFFFEFEFE), // White background
            borderRadius: BorderRadius.circular(radius ?? AppSizes.szR12),
            border: Border.all(
              color: const Color(0xFFDFE1E6), // Light gray border
              width: 1,
            ),
          ),
          child: Padding(padding: EdgeInsets.all(AppSizes.szR14), child: child),
        );
    }
    // Default case if text doesn't match any known value
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(radius ?? AppSizes.szR8),
        border: Border.all(color: Colors.grey, width: 1),
      ),
      child: Padding(padding: EdgeInsets.all(AppSizes.szR14), child: child),
    );
  }
}
