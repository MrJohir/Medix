import 'package:flutter/material.dart';
import 'package:dermaininstitute/core/common/styles/global_text_style.dart';
import 'package:dermaininstitute/core/utils/constants/sizer.dart';

/// Bottom navigation widget for the app
/// Shows Dashboard, SOPs, Users, and Settings tabs
class AppBottomNavigation extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AppBottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSizes.szH80 + AppSizes.szH24, // Navigation height + safe area
      decoration: const BoxDecoration(
        color: Color(0xFFF5F6F7),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: AppSizes.szH8),

          // Navigation items
          Container(
            height: AppSizes.szH48,
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: AppSizes.szW12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNavItem(0, 'Dashboard'),
                _buildNavItem(1, 'SOPs'),
                _buildNavItem(2, 'Users'),
                _buildNavItem(3, 'Settings'),
              ],
            ),
          ),

          // Safe area and home indicator
          Container(
            height: AppSizes.szH24,
            color: Colors.white,
            child: Center(
              child: Container(
                width: AppSizes.szW140,
                height: AppSizes.szH4,
                decoration: BoxDecoration(
                  color: const Color(0xFFB8BFC8),
                  borderRadius: BorderRadius.circular(AppSizes.szR50),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build individual navigation item
  Widget _buildNavItem(int index, String label) {
    final isSelected = currentIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(index),
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon placeholder (24x24)
            Container(
              width: AppSizes.szW24,
              height: AppSizes.szH24,
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFFA94907) : Colors.grey[400],
                borderRadius: BorderRadius.circular(AppSizes.szR4),
              ),
            ),

            SizedBox(height: AppSizes.szH6),

            // Label
            Text(
              label,
              style: getTsRegularText(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
                color: isSelected
                    ? const Color(0xFFA94907)
                    : const Color(0xFF212934),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
