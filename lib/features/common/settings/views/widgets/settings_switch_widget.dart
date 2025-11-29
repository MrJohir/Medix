import 'package:flutter/material.dart';

/// Custom Settings Switch Widget with Fixed Positioning
/// Properly sized switch without overflow issues
class SettingsSwitchWidget extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color? activeColor;
  final Color? inactiveColor;

  const SettingsSwitchWidget({
    super.key,
    required this.value,
    required this.onChanged,
    this.activeColor,
    this.inactiveColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Container(
        width: 58,
        height: 32, // Reduced height to fix overflow
        decoration: BoxDecoration(
          color: value
              ? (activeColor ?? Color(0xFF1976D2))
              : (inactiveColor ?? Color(0xFFE0E0E0)),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          children: [
            // Animated thumb
            AnimatedPositioned(
              duration: Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              left: value ? 26 : 2, // Adjusted positioning
              top: 2,
              child: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x33000000),
                      blurRadius: 4,
                      offset: Offset(0, 2),
                      spreadRadius: 0,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
