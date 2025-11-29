// lib/features/trainee_flow/reports/controllers/reports_controller.dart
import 'package:dermaininstitute/features/trainee_flow/reports/models/incident_model.dart';
import 'package:dermaininstitute/features/trainee_flow/reports/models/insident_api_model.dart';
import 'package:dermaininstitute/features/trainee_flow/reports/report_service/report_service.dart';
import 'package:dermaininstitute/features/trainee_flow/create_report/models/simple_draft_report_model.dart';
import 'package:dermaininstitute/core/api_service/NetworkCaller.dart';
import 'package:dermaininstitute/core/utils/constants/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'dart:convert';

class ReportsController extends GetxController {
  // Observable variables
  final RxList<Report> _allReports = <Report>[].obs;
  final RxList<Report> _filteredReports = <Report>[].obs;
  final RxList<IncidentModel> _allIncidents = <IncidentModel>[].obs;
  final RxList<IncidentModel> _filteredIncidents = <IncidentModel>[].obs;
  final Rx<Priority> _selectedPriority = Priority.all.obs;
  final RxString _searchQuery = ''.obs;
  final RxBool _isLoading = false.obs;
  final RxBool _hasError = false.obs;
  final RxString _errorMessage = ''.obs;

  // Getters
  List<Report> get allReports => _allReports;
  List<Report> get filteredReports => _filteredReports;
  List<IncidentModel> get allIncidents => _allIncidents;
  List<IncidentModel> get filteredIncidents => _filteredIncidents;
  Priority get selectedPriority => _selectedPriority.value;
  String get searchQuery => _searchQuery.value;
  bool get isLoading => _isLoading.value;
  bool get hasError => _hasError.value;
  String get errorMessage => _errorMessage.value;

  final ReportService apiService = ReportService();

  @override
  void onInit() {
    super.onInit();
    _loadReportsFromApi();
  }

  Future<void> _loadReportsFromApi() async {
    try {
      _isLoading.value = true;
      _hasError.value = false;

      final reports = await apiService.getReports(
        situation: _selectedPriority.value != Priority.all
            ? _mapPriorityToSituation(_selectedPriority.value)
            : null,
        title: _searchQuery.value.isNotEmpty ? _searchQuery.value : null,
      );

      _allReports.value = reports;

      // Convert reports to incidents without additional filtering
      // since API already filters based on priority and search
      _allIncidents.value = reports
          .map(
            (report) => IncidentModel.fromJson({
              'id': report.id, // Fixed: Use actual report ID
              'title': report.incidentTitle,
              'description': report.descriptionOfIncident,
              'procedure': report.procedure,
              'priority': report.situation,
              'status': report.status,
              'dateTime': report.updatedAt.toIso8601String(),
              'patientSex':
                  report.patientSex, // Fixed: Include patientSex from API
            }),
          )
          .toList();

      // Sort by date (newest first)
      _allIncidents.sort((a, b) => b.dateTime.compareTo(a.dateTime));

      // Set filtered incidents to all incidents since API already applied filters
      _filteredIncidents.value = List.from(_allIncidents);
    } catch (e) {
      _hasError.value = true;
      _errorMessage.value = 'Failed to load reports';
      debugPrint('Error loading reports: $e');
      Get.snackbar('Error', 'Failed to load reports');
    } finally {
      _isLoading.value = false;
    }
  }

  void updateSearchQuery(String query) {
    _searchQuery.value = query;
    _loadReportsFromApi();
  }

  void updatePriorityFilter(Priority priority) {
    _selectedPriority.value = priority;
    _loadReportsFromApi();
  }

  /// Clear all filters and reload data
  void clearAllFilters() {
    _searchQuery.value = '';
    _selectedPriority.value = Priority.all;
    _loadReportsFromApi();
  }

  Future<void> refreshData() async {
    try {
      _hasError.value = false;
      await _loadReportsFromApi();
    } catch (e) {
      _hasError.value = true;
      _errorMessage.value = 'Refresh failed';
      Get.snackbar('Error', 'Refresh failed');
    }
  }

  // Placeholder for future POST API
  Future<void> addReport(Report report) async {
    try {
      _isLoading.value = true;
      _hasError.value = false;

      // Todo: Implement actual API call to create report
      await Future.delayed(const Duration(milliseconds: 500));

      _allReports.add(report);
      _allIncidents.add(
        IncidentModel.fromJson({
          'id': report.id,
          'title': report.incidentTitle,
          'description': report.descriptionOfIncident,
          'procedure': report.procedure,
          'priority': report.situation,
          'status': report.status,
          'dateTime': report.updatedAt.toIso8601String(),
          'patientSex': report.patientSex,
        }),
      );

      // Sort and update filtered incidents
      _allIncidents.sort((a, b) => b.dateTime.compareTo(a.dateTime));
      _filteredIncidents.value = List.from(_allIncidents);

      Get.snackbar('Success', 'Report logged successfully');
    } catch (e) {
      _hasError.value = true;
      _errorMessage.value = 'Failed to add report';
      Get.snackbar('Error', 'Failed to log report');
    } finally {
      _isLoading.value = false;
    }
  }

  // Kept as provided, using IncidentModel
  Future<void> updateIncidentStatus(String incidentId, Status newStatus) async {
    try {
      _isLoading.value = true;
      _hasError.value = false;

      // Todo: Implement actual API call to update incident
      // Example: await ApiService.updateIncidentStatus(incidentId, newStatus);
      await Future.delayed(const Duration(milliseconds: 500));

      // Update local data
      final index = _allIncidents.indexWhere(
        (incident) => incident.id == incidentId,
      );
      if (index != -1) {
        final updatedIncident = IncidentModel(
          id: _allIncidents[index].id,
          title: _allIncidents[index].title,
          description: _allIncidents[index].description,
          procedure: _allIncidents[index].procedure,
          priority: _allIncidents[index].priority,
          patientSex: _allIncidents[index].patientSex,
          status: newStatus,
          dateTime: _allIncidents[index].dateTime,
        );
        _allIncidents[index] = updatedIncident;

        // Update filtered incidents
        _filteredIncidents.value = List.from(_allIncidents);
      }
    } catch (e) {
      _hasError.value = true;
      _errorMessage.value = 'Failed to update incident';
      Get.snackbar('Error', 'Failed to update incident');
    } finally {
      _isLoading.value = false;
    }
  }

  void clearError() {
    _hasError.value = false;
    _errorMessage.value = '';
  }

  String getPriorityColor(Priority priority) {
    switch (priority) {
      case Priority.low:
        return '#D2DAF6';
      case Priority.medium:
        return '#FFF4E6';
      case Priority.high:
        return '#D2DAF6';
      case Priority.critical:
        return '#FDECEC';
      default:
        return '#F5F6F9';
    }
  }

  String getPriorityTextColor(Priority priority) {
    switch (priority) {
      case Priority.low:
        return '#1A4DBE';
      case Priority.medium:
        return '#B7791F';
      case Priority.high:
        return '#1A4DBE';
      case Priority.critical:
        return '#DB0000';
      default:
        return '#42526E';
    }
  }

  String getStatusColor(Status status) {
    switch (status) {
      case Status.completed:
        return '#E4F6D1';
      case Status.submitted:
        return '#E4F6D1';
    }
  }

  String getStatusTextColor(Status status) {
    switch (status) {
      case Status.completed:
        return '#2A7900';
      case Status.submitted:
        return '#2A7900';
    }
  }

  String? _mapPriorityToSituation(Priority priority) {
    switch (priority) {
      case Priority.low:
        return 'Low';
      case Priority.medium:
        return 'Medium';
      case Priority.high:
        return 'High';
      case Priority.critical:
        return 'Critical'; // Fixed: Map critical to Critical
      default:
        return null;
    }
  }

  /// Submit draft report to API
  /// [draftReport] - The draft report to submit
  /// Returns: true if submitted successfully, false otherwise
  Future<bool> submitDraftReport(SimpleDraftReportModel draftReport) async {
    try {
      EasyLoading.show(status: 'Submitting report...');

      // Convert draft to API format
      final response = await NetworkCaller.postRequest(
        endpoint: createReportEndpoint,
        body: draftReport.toApiJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        debugPrint(
          'Draft report submitted successfully: ${responseData['id']}',
        );

        EasyLoading.showSuccess('Report submitted successfully!');

        // Refresh reports list
        await _loadReportsFromApi();

        return true;
      } else {
        final errorData = jsonDecode(response.body);
        String errorMessage = 'Failed to submit report';

        if (errorData['message'] != null) {
          if (errorData['message'] is List) {
            final messages = errorData['message'] as List;
            errorMessage = messages.join(', ');
          } else {
            errorMessage = errorData['message'];
          }
        }

        EasyLoading.showError(errorMessage);
        return false;
      }
    } catch (e) {
      debugPrint('Error submitting draft report: $e');
      EasyLoading.showError('Failed to submit report. Please try again.');
      return false;
    } finally {
      EasyLoading.dismiss();
    }
  }
}
