import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:dermaininstitute/core/utils/constants/sizer.dart';

class IncidentCardShimmer extends StatelessWidget {
  const IncidentCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(AppSizes.szW14),
        decoration: ShapeDecoration(
          color: const Color(0xFFFEFEFE),
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: Color(0xFFDFE1E6)),
            borderRadius: BorderRadius.circular(AppSizes.szR12),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title and ID Row
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: AppSizes.font16,
                    width: double.infinity,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: AppSizes.szW10),
                Container(
                  height: AppSizes.szH24,
                  width: 60,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSizes.szR50),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: AppSizes.szH6),

            // Description
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: AppSizes.font12,
                  width: double.infinity,
                  color: Colors.white,
                ),
                SizedBox(height: AppSizes.szH4),
                Container(
                  height: AppSizes.font12,
                  width: double.infinity * 0.7,
                  color: Colors.white,
                ),
              ],
            ),

            SizedBox(height: AppSizes.szH12),

            // Divider
            Container(width: double.infinity, height: 1, color: Colors.white),

            SizedBox(height: AppSizes.szH12),

            // Priority and Status Tags
            Row(
              children: [
                Container(
                  height: AppSizes.szH24,
                  width: 60,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSizes.szR50),
                    ),
                  ),
                ),
                SizedBox(width: AppSizes.szW8),
                Container(
                  height: AppSizes.szH24,
                  width: AppSizes.szW80,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSizes.szR50),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: AppSizes.szH8),

            // Date and Time
            Row(
              children: [
                Container(
                  height: AppSizes.szH18,
                  width: AppSizes.szW18,
                  color: Colors.white,
                ),
                SizedBox(width: AppSizes.szW4),
                Container(
                  height: AppSizes.font10,
                  width: AppSizes.szW100,
                  color: Colors.white,
                ),
              ],
            ),

            SizedBox(height: AppSizes.szH8),

            // Procedure
            Row(
              children: [
                Container(
                  height: AppSizes.font12,
                  width: AppSizes.szW80,
                  color: Colors.white,
                ),
                SizedBox(width: AppSizes.szW4),
                Container(
                  height: AppSizes.font12,
                  width: AppSizes.szW120,
                  color: Colors.white,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class IncidentCardShimmerList extends StatelessWidget {
  const IncidentCardShimmerList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(AppSizes.szW16),
      itemCount: 10,
      separatorBuilder: (context, index) => SizedBox(height: AppSizes.szH16),
      itemBuilder: (context, index) => const IncidentCardShimmer(),
    );
  }
}
