import 'package:dermaininstitute/core/utils/constants/icon_path.dart';
import 'package:dermaininstitute/core/utils/constants/sizer.dart' show AppSizes;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

// ignore: must_be_immutable
class CustomFilterButton extends StatelessWidget {
  CustomFilterButton({
    super.key,
    required this.onTap,
    this.height,
    this.width,
    this.padding,
  });

  final VoidCallback onTap;
  double? height = AppSizes.szW40;
  double? width = AppSizes.szW40;
  double? padding = AppSizes.szR12;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding != null ? EdgeInsets.all(padding!): EdgeInsets.all(AppSizes.szR12),
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: const Color(0xFFF2F2F2),
          borderRadius: BorderRadius.circular(AppSizes.szR12),
        ),
        child: SvgPicture.asset(IconPath.filterIcon, width: 15.w, height: 10.h),
      ),
    );
  }
}
