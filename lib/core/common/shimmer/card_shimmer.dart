import 'package:dermaininstitute/core/common/styles/global_text_style.dart';
import 'package:dermaininstitute/core/utils/constants/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ProtocolScreenCardShimmer extends StatelessWidget {
  const ProtocolScreenCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 8, // how many shimmer cards to show
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(
            vertical: AppSizes.szH8,
            horizontal: AppSizes.szW16,
          ),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              padding: EdgeInsets.all(AppSizes.szR16),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFDFE1E6)),
                borderRadius: BorderRadius.circular(AppSizes.szR12),
                color: const Color(0xFFFEFEFE),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title + Location row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          height:
                              getTsSectionTitle(
                                color: const Color(0xFF141617),
                              ).fontSize ??
                              AppSizes.font16,
                          color: Colors.grey[300],
                        ),
                      ),
                      SizedBox(width: AppSizes.szW8),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppSizes.szR50),
                          border: Border.all(color: const Color(0xFF12295E)),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSizes.szW8,
                          vertical: AppSizes.szH4,
                        ),
                        child: Container(
                          height: AppSizes.font12,
                          width: AppSizes.szW40,
                          color: Colors.grey[300],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: AppSizes.szH8),
                  // Subtitle
                  Container(
                    height: AppSizes.font12 * 2,
                    width: double.infinity,
                    color: Colors.grey[300],
                  ),
                  SizedBox(height: AppSizes.szH12),
                  // Category + Priority row
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(AppSizes.szR50),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSizes.szW12,
                          vertical: AppSizes.szH6,
                        ),
                        child: Container(
                          height: AppSizes.font12,
                          width: 50.w,
                          color: Colors.grey[300],
                        ),
                      ),
                      SizedBox(width: AppSizes.szW12),
                      CircleAvatar(
                        radius: AppSizes.szR4,
                        backgroundColor: Colors.grey[300],
                      ),
                      SizedBox(width: AppSizes.szW4),
                      Expanded(
                        child: Container(
                          height: AppSizes.font12,
                          color: Colors.grey[300],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: AppSizes.szH8),
                  // Date
                  Container(
                    height: AppSizes.font10,
                    width: AppSizes.szW80,
                    color: Colors.grey[300],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
