import 'package:dermaininstitute/core/common/styles/global_text_style.dart';
import 'package:dermaininstitute/core/utils/constants/colors.dart';
import 'package:dermaininstitute/core/utils/constants/sizer.dart';
import 'package:flutter/material.dart';

class ProtocolScreenCard extends StatelessWidget {
  const ProtocolScreenCard({
    super.key,
    required this.title,
    required this.subTitle,
    required this.location,
    required this.categoryType,
    required this.priorityType,
    required this.date,
    required this.dotColor,
    required this.categoryTypeBackgroundColor,
    required this.categoryTypeTextColor,
    required this.priorityTypeTextColor,
    this.onTap,
  });

  final String title;
  final String subTitle;
  final String location;
  final String categoryType;
  final Color categoryTypeBackgroundColor;
  final Color categoryTypeTextColor;
  final Color priorityTypeTextColor;
  final String priorityType;
  final String date;
  final Color dotColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.all(AppSizes.szR16),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(AppSizes.szR12),
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.grey.withValues(alpha: 0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // title and location row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    title.isNotEmpty ? title : 'Untitled Protocol',
                    style: getTsSectionTitle(color: AppColors.textHeading),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
                SizedBox(width: AppSizes.szW8),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSizes.szR50),
                    border: Border.all(color: AppColors.primary),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSizes.szW8,
                    vertical: AppSizes.szH4,
                  ),
                  child: Text(
                    location.isNotEmpty ? location : 'Unknown',
                    style: TextStyle(
                      fontSize: AppSizes.font12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: AppSizes.szH8),

            // subtitle/description
            if (subTitle.isNotEmpty) ...[
              Text(
                subTitle,
                style: TextStyle(
                  fontSize: AppSizes.font12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textSecondary,
                  height: 1.4,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: AppSizes.szH12),
            ],

            // category and priority row
            Row(
              children: [
                // category chip
                Flexible(
                  child: Container(
                    decoration: BoxDecoration(
                      color: categoryTypeBackgroundColor,
                      borderRadius: BorderRadius.circular(AppSizes.szR50),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSizes.szW12,
                      vertical: AppSizes.szH6,
                    ),
                    child: Text(
                      categoryType.isNotEmpty ? categoryType : 'Unknown',
                      style: TextStyle(
                        fontSize: AppSizes.font12,
                        fontWeight: FontWeight.w500,
                        color: categoryTypeTextColor,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),

                SizedBox(width: AppSizes.szW12),

                // priority indicator
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: AppSizes.szR4,
                      backgroundColor: dotColor,
                    ),
                    SizedBox(width: AppSizes.szW6),
                    Flexible(
                      child: Text(
                        priorityType.isNotEmpty ? priorityType : 'No Priority',
                        style: TextStyle(
                          fontSize: AppSizes.font12,
                          fontWeight: FontWeight.w500,
                          color: priorityTypeTextColor,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: AppSizes.szH12),

            // updated date
            Text(
              'Updated $date',
              style: TextStyle(
                fontSize: AppSizes.font10,
                fontWeight: FontWeight.w400,
                color: AppColors.placeholderText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
