import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:dermaininstitute/core/utils/constants/sizer.dart';

/// user card shimmer widget for loading state
class UserCardShimmer extends StatelessWidget {
  const UserCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // user header shimmer
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // profile image shimmer
              Container(
                width: AppSizes.szW52,
                height: AppSizes.szH52,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(AppSizes.szR8),
                ),
              ),

              SizedBox(width: AppSizes.szW12),

              // user info shimmer
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // name shimmer
                    Container(
                      width: double.infinity,
                      height: AppSizes.szH16,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(AppSizes.szR4),
                      ),
                    ),

                    SizedBox(height: AppSizes.szH8),

                    // email shimmer
                    Container(
                      width: double.infinity,
                      height: AppSizes.szH14,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(AppSizes.szR4),
                      ),
                    ),

                    SizedBox(height: AppSizes.szH12),

                    // role and status badges shimmer
                    Row(
                      children: [
                        Container(
                          width: AppSizes.szW80,
                          height: AppSizes.szH24,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(AppSizes.szR12),
                          ),
                        ),

                        SizedBox(width: AppSizes.szW8),

                        Container(
                          width: AppSizes.szW52,
                          height: AppSizes.szH24,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(AppSizes.szR12),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: AppSizes.szH12),

          // user details shimmer
          Row(
            children: [
              // institution shimmer
              Expanded(
                child: Container(
                  height: AppSizes.szH14,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(AppSizes.szR4),
                  ),
                ),
              ),

              SizedBox(width: AppSizes.szW16),

              // jurisdiction shimmer
              Expanded(
                child: Container(
                  height: AppSizes.szH14,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(AppSizes.szR4),
                  ),
                ),
              ),

              SizedBox(width: AppSizes.szW16),

              // created date shimmer
              Expanded(
                child: Container(
                  height: AppSizes.szH14,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(AppSizes.szR4),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: AppSizes.szH12),

          // action buttons shimmer
          Row(
            children: [
              // edit button shimmer
              Container(
                width: AppSizes.szW80,
                height: AppSizes.szH32,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(AppSizes.szR6),
                ),
              ),

              SizedBox(width: AppSizes.szW12),

              // delete button shimmer
              Container(
                width: AppSizes.szW80,
                height: AppSizes.szH32,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(AppSizes.szR6),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// user card shimmer list widget
class UserCardShimmerList extends StatelessWidget {
  const UserCardShimmerList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 5,
      separatorBuilder: (context, index) => SizedBox(height: AppSizes.szH16),
      itemBuilder: (context, index) => const UserCardShimmer(),
    );
  }
}
