import 'package:dermaininstitute/core/utils/constants/sizer.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// Shimmer loading widget for SOP details screen
/// Mimics the layout of the actual details screen while loading
class DetailsShimmer extends StatelessWidget {
  const DetailsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.szW20,
        vertical: AppSizes.szH20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Main info card shimmer
          _buildMainInfoCardShimmer(),
          SizedBox(height: AppSizes.szH16),

          // Indications section shimmer
          _buildSectionCardShimmer(),
          SizedBox(height: AppSizes.szH16),

          // Contraindications section shimmer
          _buildSectionCardShimmer(),
          SizedBox(height: AppSizes.szH16),

          // Required equipment section shimmer
          _buildSectionCardShimmer(),
          SizedBox(height: AppSizes.szH16),

          // Protocol steps section shimmer
          _buildProtocolStepsShimmer(),
          SizedBox(height: AppSizes.szH16),

          // Medications section shimmer
          _buildMedicationsShimmer(),
          SizedBox(height: AppSizes.szH80),
        ],
      ),
    );
  }

  /// Build main info card shimmer
  Widget _buildMainInfoCardShimmer() {
    return Container(
      padding: EdgeInsets.all(AppSizes.szR16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSizes.szR12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title shimmer
            Container(
              width: double.infinity,
              height: AppSizes.szH20,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppSizes.szR4),
              ),
            ),
            SizedBox(height: AppSizes.szH8),

            // Author and date row shimmer
            Row(
              children: [
                Container(
                  width: AppSizes.szW120,
                  height: AppSizes.szH14,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(AppSizes.szR4),
                  ),
                ),
                const Spacer(),
                Container(
                  width: AppSizes.szW80,
                  height: AppSizes.szH14,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(AppSizes.szR4),
                  ),
                ),
              ],
            ),
            SizedBox(height: AppSizes.szH14),

            // Status badges shimmer
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
                SizedBox(width: AppSizes.szW12),
                Container(
                  width: AppSizes.szW100,
                  height: AppSizes.szH24,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(AppSizes.szR12),
                  ),
                ),
              ],
            ),
            SizedBox(height: AppSizes.szH14),

            // Category and date fields shimmer
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: AppSizes.szH48,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(AppSizes.szR10),
                    ),
                  ),
                ),
                SizedBox(width: AppSizes.szW12),
                SizedBox(
                  width: 112,
                  child: Container(
                    height: AppSizes.szH48,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(AppSizes.szR10),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: AppSizes.szH14),

            // Jurisdiction tags shimmer
            Wrap(
              spacing: AppSizes.szW8,
              children: List.generate(3, (index) {
                return Container(
                  width: AppSizes.szW80 + (index * 10),
                  height: AppSizes.szH24,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(AppSizes.szR12),
                  ),
                );
              }),
            ),
            SizedBox(height: AppSizes.szH14),

            // Overview text shimmer
            Column(
              children: List.generate(3, (index) {
                return Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: AppSizes.szH12,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(AppSizes.szR4),
                      ),
                    ),
                    SizedBox(height: AppSizes.szH4),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  /// Build section card shimmer
  Widget _buildSectionCardShimmer() {
    return Container(
      padding: EdgeInsets.all(AppSizes.szR16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSizes.szR12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section header shimmer
            Container(
              width: AppSizes.szW100,
              height: AppSizes.szH16,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppSizes.szR4),
              ),
            ),
            SizedBox(height: AppSizes.szH12),

            // Content lines shimmer
            Column(
              children: List.generate(4, (index) {
                return Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: AppSizes.szH12,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(AppSizes.szR4),
                      ),
                    ),
                    SizedBox(height: AppSizes.szH4),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  /// Build protocol steps shimmer
  Widget _buildProtocolStepsShimmer() {
    return Container(
      padding: EdgeInsets.all(AppSizes.szR16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSizes.szR12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section header shimmer
            Container(
              width: AppSizes.szW120,
              height: AppSizes.szH16,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppSizes.szR4),
              ),
            ),
            SizedBox(height: AppSizes.szH12),

            // Protocol steps shimmer
            Column(
              children: List.generate(3, (index) {
                return Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(AppSizes.szR12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(AppSizes.szR8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: AppSizes.szW24,
                                height: AppSizes.szH24,
                                decoration: BoxDecoration(
                                  color: Colors.grey[400],
                                  shape: BoxShape.circle,
                                ),
                              ),
                              SizedBox(width: AppSizes.szW12),
                              Container(
                                width: AppSizes.szW140,
                                height: AppSizes.szH16,
                                decoration: BoxDecoration(
                                  color: Colors.grey[400],
                                  borderRadius: BorderRadius.circular(
                                    AppSizes.szR4,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: AppSizes.szH8),
                          Container(
                            width: double.infinity,
                            height: AppSizes.szH12,
                            decoration: BoxDecoration(
                              color: Colors.grey[400],
                              borderRadius: BorderRadius.circular(
                                AppSizes.szR4,
                              ),
                            ),
                          ),
                          SizedBox(height: AppSizes.szH4),
                          Container(
                            width: AppSizes.szW100,
                            height: AppSizes.szH10,
                            decoration: BoxDecoration(
                              color: Colors.grey[400],
                              borderRadius: BorderRadius.circular(
                                AppSizes.szR4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (index < 2) SizedBox(height: AppSizes.szH8),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  /// Build medications shimmer
  Widget _buildMedicationsShimmer() {
    return Container(
      padding: EdgeInsets.all(AppSizes.szR16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSizes.szR12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section header shimmer
            Container(
              width: AppSizes.szW100,
              height: AppSizes.szH16,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppSizes.szR4),
              ),
            ),
            SizedBox(height: AppSizes.szH12),

            // Medication cards shimmer
            Column(
              children: List.generate(2, (index) {
                return Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(AppSizes.szR12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(AppSizes.szR8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: AppSizes.szW120,
                            height: AppSizes.szH16,
                            decoration: BoxDecoration(
                              color: Colors.grey[400],
                              borderRadius: BorderRadius.circular(
                                AppSizes.szR4,
                              ),
                            ),
                          ),
                          SizedBox(height: AppSizes.szH8),
                          Container(
                            width: double.infinity,
                            height: AppSizes.szH12,
                            decoration: BoxDecoration(
                              color: Colors.grey[400],
                              borderRadius: BorderRadius.circular(
                                AppSizes.szR4,
                              ),
                            ),
                          ),
                          SizedBox(height: AppSizes.szH4),
                          Container(
                            width: AppSizes.szW140,
                            height: AppSizes.szH12,
                            decoration: BoxDecoration(
                              color: Colors.grey[400],
                              borderRadius: BorderRadius.circular(
                                AppSizes.szR4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (index < 1) SizedBox(height: AppSizes.szH8),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
