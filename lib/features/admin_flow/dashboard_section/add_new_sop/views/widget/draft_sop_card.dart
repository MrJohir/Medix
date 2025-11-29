import 'package:dermaininstitute/core/common/styles/global_text_style.dart';
import 'package:dermaininstitute/core/common/widgets/custom_note_card.dart';
import 'package:dermaininstitute/core/utils/constants/image_path.dart';
import 'package:dermaininstitute/core/utils/constants/sizer.dart';
import 'package:dermaininstitute/features/admin_flow/dashboard_section/add_new_sop/models/simple_draft_sop_model.dart';
import 'package:flutter/material.dart';

/// Draft SOP card widget for displaying saved draft SOPs
/// Shows SOP information with only delete and publish buttons
class DraftSOPCard extends StatelessWidget {
  final SimpleDraftSOPModel draftSOP;
  final VoidCallback onDelete;
  final VoidCallback onPublish;

  const DraftSOPCard({
    super.key,
    required this.draftSOP,
    required this.onDelete,
    required this.onPublish,
  });

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

          // Action buttons (Delete and Publish only)
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
                    draftSOP.title,
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
                          'by ${draftSOP.author}',
                          style: getTsRegularText(
                            fontSize: 12,
                            color: const Color(0xFF141617),
                          ),
                        ),
                      ),
                      Text(
                        draftSOP.formattedDate,
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

        // Draft status badge
        _buildDraftStatusBadge(),
      ],
    );
  }

  /// Build draft status badge
  Widget _buildDraftStatusBadge() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.szW12,
        vertical: AppSizes.szH6,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF8E7D4), // Orange background for draft
        borderRadius: BorderRadius.circular(AppSizes.szR50),
      ),
      child: Text(
        'Draft',
        style: getTsBoldText(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: const Color(0xFFDB7906), // Orange text for draft
        ),
      ),
    );
  }

  /// Build jurisdiction tags
  Widget _buildJurisdictionTags() {
    return Wrap(
      spacing: AppSizes.szW12,
      runSpacing: AppSizes.szH8,
      children: draftSOP.jurisdiction.map((jurisdiction) {
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

  /// Build action buttons (Delete and Publish only)
  Widget _buildActionButtons() {
    return Row(
      children: [
        // Publish button
        Expanded(
          child: _DraftActionButton(
            text: 'Publish',
            backgroundColor: const Color(0xFF12295E),
            textColor: Colors.white,
            onPressed: onPublish,
          ),
        ),

        SizedBox(width: AppSizes.szW12),

        // Delete button
        _DraftActionButton(
          text: 'Delete',
          isIconOnly: true,
          backgroundColor: const Color(0xFFDC3545),
          icon: Image.asset(
            ImagePath.ivDelete,
            width: AppSizes.szW20,
            height: AppSizes.szH20,
            color: Colors.white,
          ),
          onPressed: onDelete,
        ),
      ],
    );
  }
}

/// Custom action button for draft SOP card
class _DraftActionButton extends StatelessWidget {
  final String text;
  final Color? backgroundColor;
  final Color? textColor;
  final Widget? icon;
  final bool isIconOnly;
  final VoidCallback onPressed;

  const _DraftActionButton({
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.icon,
    this.isIconOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSizes.szH40,
      width: isIconOnly ? AppSizes.szW40 : null,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? Colors.transparent,
          foregroundColor: textColor ?? const Color(0xFF12295E),
          elevation: 0,
          side: BorderSide(
            color: backgroundColor ?? const Color(0xFF12295E),
            width: 1,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.szR8),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: isIconOnly ? 0 : AppSizes.szW16,
            vertical: AppSizes.szH8,
          ),
        ),
        child: isIconOnly
            ? (icon ?? const SizedBox.shrink())
            : Text(
                text,
                style: getTsBoldText(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: textColor ?? const Color(0xFF12295E),
                ),
              ),
      ),
    );
  }
}
