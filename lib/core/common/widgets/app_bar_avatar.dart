import 'package:dermaininstitute/core/utils/constants/sizer.dart';
import 'package:flutter/material.dart';

class AppBarAvatar extends StatelessWidget {
  const AppBarAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSizes.szW32, // Adjust size as needed
      height: AppSizes.szW32,
      decoration: BoxDecoration(
        shape: BoxShape.circle,

        border: Border.all(color: Colors.white, width: 1), // Optional border

      ),
      child: Stack(
        children: [
          // Main avatar image

          CircleAvatar(radius: AppSizes.szR32),

          // Green status dot - positioned at bottom right
          Positioned(
            right: 1,
            bottom: 2,
            child: Container(
              width: AppSizes.szW8,
              height: AppSizes.szH8,
              decoration: BoxDecoration(
                color: Color(0xFF2A7900),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: .1),
                    blurRadius: 2,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
