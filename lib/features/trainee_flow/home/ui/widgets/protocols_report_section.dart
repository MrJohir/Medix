import 'package:dermaininstitute/core/common/styles/global_text_style.dart';
import 'package:dermaininstitute/core/utils/constants/sizer.dart';
import 'package:dermaininstitute/core/utils/helpers/svg_icon_helper.dart';
import 'package:flutter/material.dart';

class ProtocolsReportAndCalculatorSection extends StatelessWidget {
  const ProtocolsReportAndCalculatorSection({
    super.key,
    required this.cardBackgroundColor,
    required this.circleAvatarBackgroundColor,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final Color cardBackgroundColor;
  final Color circleAvatarBackgroundColor;
  final String icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.szW24,
          vertical: AppSizes.szH14,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.szR12),
          color: cardBackgroundColor,
        ),
        child: Column(
          children: [
            CircleAvatar(
              backgroundColor: circleAvatarBackgroundColor,
              radius: AppSizes.szR32,
              child: SvgIconHelper.buildIcon(assetPath: icon),
            ),
            SizedBox(height: AppSizes.szH12),
            Text(title, style: getTsSubTitle(fontSize: AppSizes.font16)),
            SizedBox(height: AppSizes.szH6),
            Text(subtitle, style: getTsSubTitle(lineHeight: 1.5, fontSize: AppSizes.font12), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
