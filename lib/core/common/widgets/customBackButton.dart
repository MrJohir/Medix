// ignore_for_file: file_names

import 'package:dermaininstitute/core/utils/constants/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    super.key,
    required this.icon,
    required this.backgroundColor,
    required this.onTap,

  });

  final String icon;
  final Color backgroundColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(icon, height: AppSizes.szH24, width: AppSizes.szW24,);
  }
}
