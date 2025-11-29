import 'package:dermaininstitute/core/common/styles/global_text_style.dart';
import 'package:dermaininstitute/core/utils/constants/sizer.dart';
import 'package:flutter/material.dart';

class RecentActivityCard extends StatelessWidget {
  const RecentActivityCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.place,
  });

  final String title;
  final String subtitle;
  final String place;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.szW14,
        vertical: AppSizes.szH12,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(AppSizes.szR6),
        border: Border.all(color: const Color(0xFFDFE1E6)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: getTsSectionTitle(fontWeight: FontWeight.w500),
                ),
                SizedBox(height: AppSizes.szH6),
                Text(subtitle, style: getTsSubTitle(fontSize: AppSizes.font12)),
              ],
            ),
          ),
          Text(place, style: getTsSubTitle(fontSize: AppSizes.font12)),
        ],
      ),
    );
  }
}
