import 'package:dermaininstitute/core/common/styles/global_text_style.dart';
import 'package:dermaininstitute/core/common/widgets/custom_note_card.dart';
import 'package:dermaininstitute/core/common/widgets/custom_appbar.dart';
import 'package:dermaininstitute/core/utils/constants/sizer.dart';
import 'package:dermaininstitute/core/utils/constants/colors.dart';
import 'package:dermaininstitute/features/admin_flow/sops_section/sop_view/controllers/details_view_controller.dart';
import 'package:dermaininstitute/features/admin_flow/sops_section/sop_view/views/widgets/details_shimmer.dart';
import 'package:dermaininstitute/features/admin_flow/sops_section/sop_view/views/widgets/jurisdiction_tag.dart';
import 'package:dermaininstitute/features/admin_flow/sops_section/sop_view/views/widgets/medication_info_card.dart';
import 'package:dermaininstitute/features/admin_flow/sops_section/sop_view/views/widgets/protocol_step_card.dart';
import 'package:dermaininstitute/features/admin_flow/sops_section/sop_view/views/widgets/section_header.dart';
import 'package:dermaininstitute/features/admin_flow/sops_section/sop_view/views/widgets/status_badge.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailsViewScreen extends StatelessWidget {
  final String sopId;

  DetailsViewScreen({super.key, required this.sopId});

  /// GetX controller for managing screen state
  final DetailsViewController controller = Get.put(DetailsViewController());

  @override
  Widget build(BuildContext context) {
    // Initialize controller with SOP ID
    controller.initializeWithSopId(sopId);

    return Scaffold(
      backgroundColor: AppColors.universalBackground, // Light gray background
      // CustomAppBar with back arrow, title and avatar
      appBar: AppBarHelper.backWithAvatar(
        title: 'View',
        onBackPressed: () => Get.back(),
        showConnectionStatus: true,
      ),

      body: Obx(() {
        // Show loading shimmer while data is being fetched
        if (controller.loading) {
          return const DetailsShimmer();
        }

        // Show error state if there's an error
        if (controller.error.isNotEmpty && controller.sop == null) {
          return _buildErrorState();
        }

        // Show empty state if no SOP data
        if (controller.sop == null) {
          return _buildEmptyState();
        }

        // Main content
        return RefreshIndicator(
          onRefresh: controller.refreshData,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(
              horizontal: AppSizes.szW20,
              vertical: AppSizes.szH20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Main SOP information card
                _buildMainInfoCard(),
                SizedBox(height: AppSizes.szH16),

                // Indications section
                _buildIndicationsSection(),
                SizedBox(height: AppSizes.szH16),

                // Contraindications section
                _buildContraindicationsSection(),
                SizedBox(height: AppSizes.szH16),

                // Required equipment section
                _buildRequiredEquipmentSection(),
                SizedBox(height: AppSizes.szH16),

                // Protocol steps section
                _buildProtocolStepsSection(),
                SizedBox(height: AppSizes.szH16),

                // Medications section
                _buildMedicationsSection(),
                SizedBox(height: AppSizes.szH80),
              ],
            ),
          ),
        );
      }),
    );
  }

  /// Build the main information card containing SOP header details
  Widget _buildMainInfoCard() {
    return AppNoteCard(
      color: 'White',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SOP Title and Basic Info
          _buildSOPHeader(),
          SizedBox(height: AppSizes.szH14),

          // Status Badges (Critical, Published)
          _buildStatusBadges(),
          SizedBox(height: AppSizes.szH14),

          // Category and Created Date Fields
          _buildCategoryAndDateFields(),
          SizedBox(height: AppSizes.szH14),

          // Jurisdiction Tags
          _buildJurisdictionSection(),
          SizedBox(height: AppSizes.szH16),

          // Overview Section
          _buildOverviewSection(),
        ],
      ),
    );
  }

  /// Build SOP header with title, author, and date
  Widget _buildSOPHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // SOP Title
        Text(
          controller.sopTitle,
          style: getTsSubTitle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            lineHeight: 1.5,
            color: const Color(0xFF141617),
          ),
        ),
        SizedBox(height: AppSizes.szH6),

        // Author and Date Row
        Row(
          children: [
            // Author
            Expanded(
              child: Text(
                'by ${controller.sopAuthor}',
                style: getTsRegularText(
                  fontSize: 12,
                  color: const Color(0xFF42526E),
                ),
              ),
            ),

            // Date
            Expanded(
              child: Text(
                controller.sopDate,
                style: getTsRegularText(
                  fontSize: 12,
                  color: const Color(0xFF42526E),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// Build status badges row (Critical, Published)
  Widget _buildStatusBadges() {
    return Row(
      children: [
        StatusBadge(
          text: controller.criticalStatus,
          colorType: controller.getStatusColor(controller.criticalStatus),
        ),
        SizedBox(width: AppSizes.szW12),
        StatusBadge(
          text: controller.publishedStatus,
          colorType: controller.getStatusColor(controller.publishedStatus),
        ),
      ],
    );
  }

  /// Build category and created date input fields
  Widget _buildCategoryAndDateFields() {
    return Row(
      children: [
        // Category Field
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Category',
                style: getTsRegularText(
                  fontSize: 12,
                  color: const Color(0xFF42526E),
                ),
              ),
              SizedBox(height: AppSizes.szH6),
              _buildReadOnlyField(controller.sopCategory),
            ],
          ),
        ),
        SizedBox(width: AppSizes.szW12),

        // Created Date Field
        SizedBox(
          width: 112,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Created',
                style: getTsRegularText(
                  fontSize: 12,
                  color: const Color(0xFF42526E),
                ),
              ),
              SizedBox(height: AppSizes.szH6),

              _buildReadOnlyField(controller.sopCreatedDate),
            ],
          ),
        ),
      ],
    );
  }

  /// Build read-only field with consistent styling
  Widget _buildReadOnlyField(String value) {
    return Container(
      width: double.infinity,
      height: AppSizes.szH48,
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.szR14,
        vertical: AppSizes.szR14,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSizes.szR10),
        border: Border.all(color: const Color(0xFFEDF1F3), width: 1),
        boxShadow: [
          BoxShadow(
            color: const Color(0x3DE4E5E7),
            blurRadius: 2,
            offset: const Offset(0, 1),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          value,
          style: getTsRegularText(fontSize: 14, color: const Color(0xFF1A1C1E)),
        ),
      ),
    );
  }

  /// Build jurisdiction tags section
  Widget _buildJurisdictionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(title: 'Jurisdiction'),
        SizedBox(height: AppSizes.szH6),
        Wrap(
          spacing: AppSizes.szW12,
          children: controller.jurisdictions
              .map(
                (jurisdiction) => JurisdictionTag(jurisdiction: jurisdiction),
              )
              .toList(),
        ),
      ],
    );
  }

  /// Build overview section
  Widget _buildOverviewSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(title: 'Overview'),
        SizedBox(height: AppSizes.szH6),
        Text(
          controller.overview,
          style: getTsRegularText(
            fontSize: 12,
            lineHeight: 1.33,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF42526E),
          ),
        ),
      ],
    );
  }

  /// Build indications section card
  Widget _buildIndicationsSection() {
    return AppNoteCard(
      color: 'White',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(title: 'Indications'),
          SizedBox(height: AppSizes.szH12),

          // list of indications with icon as leading and text as title
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.indications.length,
            itemBuilder: (context, index) {
              final indication = controller.indications[index];
              return Padding(
                padding: EdgeInsets.only(bottom: AppSizes.szH8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: AppSizes.szH8,
                        right: AppSizes.szH8,
                      ),
                      child: Container(
                        width: AppSizes.szW6,
                        height: AppSizes.szW6,
                        decoration: const BoxDecoration(
                          color: Color(0xFF8993A4),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        indication,
                        style: getTsRegularText(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,

                          lineHeight: 1.70,
                          color: const Color(0xFF42526E),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  /// Build contraindications section card
  Widget _buildContraindicationsSection() {
    return AppNoteCard(
      color: 'White',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(title: 'Contraindications'),
          SizedBox(height: AppSizes.szH12),

          // list of contraindications with icon as leading and text as title
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.contraindications.length,
            itemBuilder: (context, index) {
              final contraindication = controller.contraindications[index];
              return Padding(
                padding: EdgeInsets.only(bottom: AppSizes.szH8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: AppSizes.szH8,
                        right: AppSizes.szH8,
                      ),
                      child: Container(
                        width: AppSizes.szW6,
                        height: AppSizes.szW6,
                        decoration: const BoxDecoration(
                          color: Color(0xFF8993A4),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        contraindication,
                        style: getTsRegularText(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,

                          lineHeight: 1.70,
                          color: const Color(0xFF42526E),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  /// Build required equipment section card
  Widget _buildRequiredEquipmentSection() {
    return AppNoteCard(
      color: 'White',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(title: 'Required Equipment'),
          SizedBox(height: AppSizes.szH12),

          // list of required equipment with icon as leading and text as title
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.requiredEquipment.length,
            itemBuilder: (context, index) {
              final equipment = controller.requiredEquipment[index];
              return Padding(
                padding: EdgeInsets.only(bottom: AppSizes.szH8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: AppSizes.szH8,
                        right: AppSizes.szH8,
                      ),
                      child: Container(
                        width: AppSizes.szW6,
                        height: AppSizes.szW6,
                        decoration: const BoxDecoration(
                          color: Color(0xFF8993A4),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        equipment,
                        style: getTsRegularText(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,

                          lineHeight: 1.70,
                          color: const Color(0xFF42526E),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  /// Build protocol steps section card
  Widget _buildProtocolStepsSection() {
    return AppNoteCard(
      color: 'White',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(title: 'Protocol Steps'),
          SizedBox(height: AppSizes.szH12),

          // Protocol steps list
          Column(
            children: controller.protocolStepsMap.asMap().entries.map((entry) {
              final index = entry.key;
              final step = entry.value;
              return Column(
                children: [
                  ProtocolStepCard(
                    stepNumber: step['step']!,
                    title: step['title']!,
                    description: step['description']!,
                    timeframe: step['timeframe']!,
                  ),
                  if (index < controller.protocolStepsMap.length - 1)
                    SizedBox(height: AppSizes.szH8),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  /// Build medications section card
  Widget _buildMedicationsSection() {
    return AppNoteCard(
      color: 'White',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(title: 'Medications'),
          SizedBox(height: AppSizes.szH12),

          // Medications list
          Column(
            children: controller.medicationsMap.asMap().entries.map((entry) {
              final index = entry.key;
              final medication = entry.value;
              return Column(
                children: [
                  MedicationInfoCard(
                    medicationName: medication['name'],
                    dose: medication['dose'],
                    route: medication['route'],
                    repeat: medication['repeat'],
                  ),
                  if (index < controller.medicationsMap.length - 1)
                    SizedBox(height: AppSizes.szH18),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  /// Build error state widget
  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppSizes.szW20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: AppSizes.szW80,
              color: const Color(0xFFDB7906),
            ),
            SizedBox(height: AppSizes.szH16),
            Text(
              'Failed to Load SOP',
              style: getTsSectionTitle(
                fontSize: 18,
                color: const Color(0xFFDB7906),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppSizes.szH8),
            Text(
              controller.error,
              style: getTsRegularText(
                fontSize: 14,
                color: const Color(0xFF8993A4),
              ),
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: AppSizes.szH20),
            ElevatedButton(
              onPressed: controller.refreshData,
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  /// Build empty state widget
  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppSizes.szW20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.description_outlined,
              size: AppSizes.szW80,
              color: const Color(0xFF8993A4),
            ),
            SizedBox(height: AppSizes.szH16),
            Text(
              'SOP Not Found',
              style: getTsSectionTitle(
                fontSize: 18,
                color: const Color(0xFF8993A4),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppSizes.szH8),
            Text(
              'The requested SOP could not be found',
              style: getTsRegularText(
                fontSize: 14,
                color: const Color(0xFF8993A4),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
