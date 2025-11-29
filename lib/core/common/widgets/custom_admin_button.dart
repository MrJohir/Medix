import 'package:flutter/material.dart';

class CustomAdminButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color borderColor;
  final Color? backgroundColor;
  final VoidCallback onPressed;

  const CustomAdminButton({
    super.key,
    required this.text,
    required this.textColor,
    required this.borderColor,
    this.backgroundColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: backgroundColor,
          minimumSize: Size(double.infinity, 42),
          side: BorderSide(color: borderColor, width: 1.7),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: 14,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
