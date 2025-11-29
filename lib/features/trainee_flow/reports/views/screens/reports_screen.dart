// lib/features/trainee_flow/reports/views/reports_screen.dart
import 'package:dermaininstitute/core/utils/constants/sizer.dart';
import 'package:dermaininstitute/features/trainee_flow/reports/controllers/reports_controller.dart';
import 'package:dermaininstitute/features/trainee_flow/reports/views/widgets/priority_filter_tabs.dart';
import 'package:dermaininstitute/features/trainee_flow/reports/views/widgets/reports_app_bar.dart';
import 'package:dermaininstitute/features/trainee_flow/reports/views/widgets/reports_incidents_list.dart';
import 'package:dermaininstitute/features/trainee_flow/reports/views/widgets/reports_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ReportsController());

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: const ReportsAppBar(),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.szW20),
      child: Container(
        padding: EdgeInsets.only(top: AppSizes.szH32, bottom: AppSizes.szH28),
        child: Column(
          children: [
            const ReportsSearchBar(),
            SizedBox(height: AppSizes.szH26),
            PriorityFilterTabs(),
            SizedBox(height: AppSizes.szH24),
            const Expanded(child: ReportsIncidentsList()),
          ],
        ),
      ),
    );
  }
}
