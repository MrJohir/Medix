import 'package:flutter/material.dart';

class CheckboxAdmin extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const CheckboxAdmin({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(top: 12),
        child: Row(
          children: [
            SizedBox(
              width: 20,
              height: 20,
              child: Checkbox(
                value: isSelected,
                onChanged: (value) => onTap(),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2),
                ),
                side: const BorderSide(color: Color(0xff141617), width: 2),
                activeColor: Colors.blue,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff333333),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
