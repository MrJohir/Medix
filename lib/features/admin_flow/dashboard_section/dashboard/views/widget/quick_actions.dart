import 'package:flutter/material.dart';

class QuickActionsItem extends StatelessWidget {
  final String title;
  final String subtitle;

  const QuickActionsItem({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: ShapeDecoration(
        color: const Color(0xFFFEFEFE),
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: const Color(0xFFDFE1E6)),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 4,
        children: [
          Text(
            title,
            style: TextStyle(
              color: const Color(0xFF141617),
              fontSize: 16,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w500,
              height: 1.50,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              color: const Color(0xFF141617),
              fontSize: 12,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
