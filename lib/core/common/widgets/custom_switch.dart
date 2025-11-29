import 'package:flutter/material.dart';

/// Custom Switch Widget for Settings Toggles
/// Matches the design from Figma with proper styling and animations
class CustomSettingsSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color? activeColor;
  final Color? inactiveColor;

  const CustomSettingsSwitch({
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
        height: 38,
        padding: EdgeInsets.all(12),
        child: Stack(
          children: [
            // Track background
            Container(
              width: 34,
              height: 14,
              decoration: BoxDecoration(
                color: value
                    ? (activeColor ?? Color(0xFF1976D2))
                    : (inactiveColor ?? Color(0xFFE0E0E0)),
                borderRadius: BorderRadius.circular(100),
              ),
            ),

            // Thumb (moving circle)
            AnimatedPositioned(
              duration: Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              left: value ? 20 : 0,
              top: 0,
              child: Container(
                padding: EdgeInsets.all(9),
                child: Container(
                  width: 20,
                  height: 20,
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
                      BoxShadow(
                        color: Color(0x23000000),
                        blurRadius: 2,
                        offset: Offset(0, 1),
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
