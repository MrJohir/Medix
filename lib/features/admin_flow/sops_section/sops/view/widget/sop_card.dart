import 'package:dermaininstitute/core/common/styles/global_text_style.dart';
import 'package:dermaininstitute/core/common/widgets/custom_note_card.dart';
import 'package:dermaininstitute/core/utils/constants/image_path.dart';
import 'package:dermaininstitute/core/utils/constants/sizer.dart';
import 'package:dermaininstitute/features/admin_flow/sops_section/sops/controller/manage_sops_controller.dart';
import 'package:dermaininstitute/features/admin_flow/sops_section/sops/view/widget/sop_action_button.dart';
import 'package:flutter/material.dart';

import '../../model/sop_model.dart';

/// Individual SOP card widget
/// Displays SOP information with action buttons
class SOPCard extends StatelessWidget {
  final SOPModel sop;
  final ManageSOPsController controller;

  const SOPCard({super.key, required this.sop, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AppNoteCard(
      color: 'White',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SOP title and info section
          _buildSOPInfo(),

          SizedBox(height: AppSizes.szH12),

          // Jurisdiction tags
          _buildJurisdictionTags(),

          SizedBox(height: AppSizes.szH12),

          // Action buttons
          _buildActionButtons(),
        ],
      ),
    );
  }

  /// Build SOP information section
  Widget _buildSOPInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title and status row
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title and author info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // SOP title
                  Text(
                    sop.title,
                    style: getTsSectionTitle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  SizedBox(height: AppSizes.szH6),

                  // Author and date
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'by ${sop.user.fullName}',
                          style: getTsRegularText(
                            fontSize: 12,
                            color: const Color(0xFF141617),
                          ),
                        ),
                      ),
                      Text(
                        sop.formattedDate,
                        style: getTsRegularText(
                          fontSize: 12,
                          color: const Color(0xFF141617),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),

        SizedBox(height: AppSizes.szH6),

        // Status badge
        _buildStatusBadge(),
      ],
    );
  }

  /// Build status badge based on SOP status
  Widget _buildStatusBadge() {
    final bool isPublished = sop.displayStatus == 'Published';

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.szW12,
        vertical: AppSizes.szH6,
      ),
      decoration: BoxDecoration(
        color: isPublished
            ? const Color(0xFFE6F4EF) // Green background for published
            : const Color(0xFFF8E7D4), // Orange background for draft
        borderRadius: BorderRadius.circular(AppSizes.szR50),
      ),
      child: Text(
        sop.displayStatus,
        style: getTsBoldText(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: isPublished
              ? const Color(0xFF048E5C) // Green text for published
              : const Color(0xFFDB7906), // Orange text for draft
        ),
      ),
    );
  }

  /// Build jurisdiction tags
  Widget _buildJurisdictionTags() {
    return Wrap(
      spacing: AppSizes.szW12,
      runSpacing: AppSizes.szH8,
      children: sop.jurisdiction.map((jurisdiction) {
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.szW12,
            vertical: AppSizes.szH6,
          ),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFDFE1E6), width: 1),
            borderRadius: BorderRadius.circular(AppSizes.szR50),
          ),
          child: Text(
            jurisdiction,
            style: getTsBoldText(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF141617),
            ),
          ),
        );
      }).toList(),
    );
  }

  /// Build action buttons (View, Edit, Delete)
  Widget _buildActionButtons() {
    return Row(
      children: [
        // View and Edit buttons
        Expanded(
          child: Row(
            children: [
              // View button
              Expanded(
                child: SOPActionButton(
                  text: 'View',
                  isOutlined: true,
                  onPressed: () => controller.onViewSOP(sop),
                ),
              ),

              SizedBox(width: AppSizes.szW12),

              // Edit button
              Expanded(
                child: SOPActionButton(
                  text: 'Edit',
                  backgroundColor: const Color(0xFF12295E),
                  onPressed: () => controller.onEditSOP(sop),
                ),
              ),
            ],
          ),
        ),

        SizedBox(width: AppSizes.szW12),

        // Delete button
        SOPActionButton(
          text: 'Delete',
          isIconOnly: true,
          backgroundColor: const Color(0xFF12295E),
          icon: Image.asset(
            ImagePath.ivDelete,
            width: AppSizes.szW20,
            height: AppSizes.szH20,
            color: Colors.white,
          ),
          onPressed: () => controller.onDeleteSOP(sop),
        ),
      ],
    );
  }
}
