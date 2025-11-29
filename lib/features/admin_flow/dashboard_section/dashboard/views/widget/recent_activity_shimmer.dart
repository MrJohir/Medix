import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// shimmer widget for recent activity items loading state
class RecentActivityShimmer extends StatelessWidget {
  const RecentActivityShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.only(bottom: 24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 16,
                    width: double.infinity,
                    color: Colors.white,
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Container(height: 12, width: 80, color: Colors.white),
                      SizedBox(width: 16),
                      Container(height: 12, width: 60, color: Colors.white),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 16),
            Container(
              height: 32,
              width: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
