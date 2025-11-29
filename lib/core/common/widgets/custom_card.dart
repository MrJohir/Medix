import 'package:dermaininstitute/core/utils/constants/sizer.dart';
import 'package:flutter/material.dart';

class AppCard extends StatelessWidget {
  const AppCard({super.key, required this.child, this.padding});

  final Widget child;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.szR10),
        border: Border.all(color: const Color(0xFFEDF1F3), width: 1),
        color: Colors.white,
      ),
      child: Padding(
        padding: padding ?? EdgeInsets.all(AppSizes.szH16),
        child: child,
      ),
    );
  }
}
