import 'package:flutter/material.dart';

class RecentActivityItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String duration;
  final String buttonText;
  final Color buttonTextColor;
  final Color buttonColor;
  const RecentActivityItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.duration,
    required this.buttonText,
    required this.buttonTextColor,
    required this.buttonColor,
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
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 4,
        children: [
          Expanded(
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
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8,
                  children: [
                    Expanded(
                      child: Text(
                        subtitle,
                        style: TextStyle(
                          color: const Color(0xFF141617),
                          fontSize: 12,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Text(
                      duration,
                      style: TextStyle(
                        color: const Color(0xFF141617),
                        fontSize: 12,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: 16),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: BorderSide(width: 1.5, color: buttonColor),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9999),
              ),
            ),
            onPressed: () {},
            child: Text(
              buttonText,
              style: TextStyle(
                color: buttonTextColor,
                fontSize: 12,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
