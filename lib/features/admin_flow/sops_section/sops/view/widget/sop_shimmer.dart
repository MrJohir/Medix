import 'package:dermaininstitute/core/utils/constants/sizer.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// Shimmer loading widget for SOP cards
/// Shows a skeleton loading animation while SOPs are being fetched
class SOPCardShimmer extends StatelessWidget {
  const SOPCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        margin: EdgeInsets.only(bottom: AppSizes.szH12),
        padding: EdgeInsets.all(AppSizes.szW16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppSizes.szR12),
          border: Border.all(color: const Color(0xFFE5E7EB)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title shimmer
            Container(
              height: AppSizes.szH18,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(AppSizes.szR4),
              ),
            ),

            SizedBox(height: AppSizes.szH8),

            // Author and date row shimmer
            Row(
              children: [
                Container(
                  height: AppSizes.szH14,
                  width: AppSizes.szW80,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(AppSizes.szR4),
                  ),
                ),
                SizedBox(width: AppSizes.szW8),
                Container(
                  height: AppSizes.szH14,
                  width: AppSizes.szW58,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(AppSizes.szR4),
                  ),
                ),
              ],
            ),

            SizedBox(height: AppSizes.szH12),

            // Status and jurisdiction row shimmer
            Row(
              children: [
                Container(
                  height: AppSizes.szH20,
                  width: AppSizes.szW80,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(AppSizes.szR12),
                  ),
                ),
                SizedBox(width: AppSizes.szW8),
                Container(
                  height: AppSizes.szH20,
                  width: AppSizes.szW100,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(AppSizes.szR12),
                  ),
                ),
              ],
            ),

            SizedBox(height: AppSizes.szH12),

            // Action buttons row shimmer
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: AppSizes.szH32,
                  width: AppSizes.szW32,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(AppSizes.szR8),
                  ),
                ),
                SizedBox(width: AppSizes.szW8),
                Container(
                  height: AppSizes.szH32,
                  width: AppSizes.szW32,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(AppSizes.szR8),
                  ),
                ),
                SizedBox(width: AppSizes.szW8),
                Container(
                  height: AppSizes.szH32,
                  width: AppSizes.szW32,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(AppSizes.szR8),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Shimmer loading widget for SOPs list
/// Shows multiple skeleton loading cards
class SOPsListShimmer extends StatelessWidget {
  final int itemCount;

  const SOPsListShimmer({super.key, this.itemCount = 5});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return const SOPCardShimmer();
      },
    );
  }
}
