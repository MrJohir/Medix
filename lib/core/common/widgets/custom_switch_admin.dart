import 'package:flutter/material.dart';

class CustomSwitchAdmin extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color? activeColor;
  final Color? inactiveColor;

  const CustomSwitchAdmin({
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
      child: SizedBox(
        width: 58,
        height: 38,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 50,
              height: 18,
              decoration: BoxDecoration(
                color: value
                    ? (activeColor ?? Color(0xFF1976D2).withValues(alpha: .6))
                    : (inactiveColor ?? Color(0xFFE0E0E0)),
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              left: value ? 28 : 0,
              top: -3,
              child: Container(
                width: 25,
                height: 24,
                decoration: BoxDecoration(
                  color: value
                      ? (activeColor ?? Color(0xFF1976D2))
                      : (inactiveColor ?? Color(0xFFFFFFFF)),
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
          ],
        ),
      ),
    );
  }
}
