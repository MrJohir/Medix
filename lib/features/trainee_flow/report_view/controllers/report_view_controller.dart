import 'dart:convert';
import 'package:dermaininstitute/core/utils/constants/api_constants.dart';
import 'package:dermaininstitute/features/trainee_flow/report_view/models/report_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

/// controller for report view screen
/// manages the report data and screen state
class ReportViewController extends GetxController {
  // loading state for api calls
  var isLoading = false.obs;

  // current report data
  var currentReport = Rx<ReportModel?>(null);

  // error message for displaying errors
  var errorMessage = ''.obs;


  /// load report data from api
  /// [reportId] - id of the report to load
  Future<void> loadReport(String reportId) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      EasyLoading.show(status: 'Loading report...');

      final response = await http.get(
        Uri.parse("$baseUrl$getReportByIdEndpoint/$reportId"),
        headers: {
          "Content-Type": "application/json",
          // Add authorization if needed
          // "Authorization": "Bearer $token",
        },
      );

      debugPrint('Report API Response: ${response.statusCode}');
      debugPrint('Report API Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        currentReport.value = ReportModel.fromJson(data);
        EasyLoading.dismiss();
      } else {
        throw Exception('Failed to load report: ${response.statusCode}');
      }
    } catch (e) {
      errorMessage.value = 'Failed to load report: ${e.toString()}';
      debugPrint('Error loading report: $e');
      EasyLoading.showError('Failed to load report');
    } finally {
      isLoading.value = false;
    }
  }

  /// refresh report data
  Future<void> refreshReport() async {
    if (currentReport.value != null) {
      await loadReport(currentReport.value!.id);
    }
  }

  /// get priority color based on priority level
  String getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return '#1A4DBE';
      case 'medium':
        return '#FF8C00';
      case 'low':
        return '#32CD32';
      default:
        return '#1A4DBE';
    }
  }

  /// get priority background color based on priority level
  String getPriorityBackgroundColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return '#D2DAF6';
      case 'medium':
        return '#FFE4B5';
      case 'low':
        return '#E6FFE6';
      default:
        return '#D2DAF6';
    }
  }

  /// get status color based on status
  String getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'submitted':
        return '#2A7900';
      case 'pending':
        return '#FF8C00';
      case 'draft':
        return '#6B7280';
      default:
        return '#2A7900';
    }
  }

  /// get status background color based on status
  String getStatusBackgroundColor(String status) {
    switch (status.toLowerCase()) {
      case 'submitted':
        return '#E4F6D2';
      case 'pending':
        return '#FFE4B5';
      case 'draft':
        return '#F3F4F6';
      default:
        return '#E4F6D2';
    }
  }
}
