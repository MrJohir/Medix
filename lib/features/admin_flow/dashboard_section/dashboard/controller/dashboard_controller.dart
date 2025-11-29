import 'dart:convert';
import 'package:dermaininstitute/core/api_service/NetworkCaller.dart';
import 'package:dermaininstitute/core/utils/constants/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../models/recent_activity_model.dart';

/// dashboard controller manages dashboard summary data and recent activity
/// fetches data from admin API and exposes it for UI
class DashboardController extends GetxController {
  // loading states for shimmer
  RxBool isLoading = false.obs;
  RxBool isRecentActivityLoading = false.obs;
  // error messages
  RxString errorMessage = ''.obs;
  RxString recentActivityErrorMessage = ''.obs;

  // dashboard data from API
  RxInt totalCredentials = 0.obs;
  RxInt totalSOPs = 0.obs;
  RxInt totalIncidentReports = 0.obs;

  // insights data from API
  RxString growthPercentage = ''.obs;
  RxInt sopsThisWeek = 0.obs;
  RxInt incidentReportsLast30Days = 0.obs;

  // recent activity data
  Rx<RecentActivityResponse?> recentActivityData = Rx<RecentActivityResponse?>(
    null,
  );

  final medicationNameController = TextEditingController();
  final medicationDoseController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchDashboardSummary();
    fetchRecentActivity();
  }

  /// fetch dashboard summary data from API
  Future<void> fetchDashboardSummary() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final response = await NetworkCaller.getRequest(
        endpoint: dashboardSummaryEndpoint,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);

        if (json['statusCode'] == 200 && json['data'] != null) {
          final data = json['data'];

          // parse totals data
          final totals = data['totals'];
          totalCredentials.value = totals['totalCredentials'] ?? 0;
          totalSOPs.value = totals['totalSOPs'] ?? 0;
          totalIncidentReports.value = totals['totalIncidentReports'] ?? 0;

          // parse insights data
          final insights = data['insights'];
          growthPercentage.value =
              insights['users']['growthPercentage'] ?? '0%';
          sopsThisWeek.value = insights['sopsThisWeek'] ?? 0;
          incidentReportsLast30Days.value =
              insights['incidentReportsLast30Days'] ?? 0;
        } else {
          errorMessage.value = json['message'] ?? 'Unknown error';
          EasyLoading.showError(errorMessage.value);
        }
      } else {
        errorMessage.value = 'Failed to load dashboard data';
        EasyLoading.showError(errorMessage.value);
      }
    } catch (e) {
      errorMessage.value = e.toString();
      EasyLoading.showError(errorMessage.value);
    } finally {
      isLoading.value = false;
    }
  }

  /// fetch recent activity data from API
  Future<void> fetchRecentActivity() async {
    isRecentActivityLoading.value = true;
    recentActivityErrorMessage.value = '';

    try {
      final response = await NetworkCaller.getRequest(
        endpoint: recentActivityEndpoint,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);

        if (json['statusCode'] == 200) {
          recentActivityData.value = RecentActivityResponse.fromJson(json);
        } else {
          recentActivityErrorMessage.value = json['message'] ?? 'Unknown error';
          EasyLoading.showError(recentActivityErrorMessage.value);
        }
      } else {
        recentActivityErrorMessage.value = 'Failed to load recent activity';
        EasyLoading.showError(recentActivityErrorMessage.value);
      }
    } catch (e) {
      recentActivityErrorMessage.value = e.toString();
      EasyLoading.showError(recentActivityErrorMessage.value);
    } finally {
      isRecentActivityLoading.value = false;
    }
  }

  /// get formatted time difference for recent activity
  String getTimeDifference(DateTime createdAt) {
    final now = DateTime.now();
    final difference = now.difference(createdAt);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    }
  }

  /// get button color and text based on activity type
  Map<String, dynamic> getActivityButtonStyle(String type) {
    switch (type.toLowerCase()) {
      case 'sop':
        return {'text': 'SOPs', 'color': const Color(0xff007E1B)};
      case 'user':
      case 'credential':
        return {'text': 'User', 'color': const Color(0xff1A4DBE)};
      case 'incident':
        return {'text': 'Emergency', 'color': const Color(0xffDB0000)};
      default:
        return {'text': 'Activity', 'color': const Color(0xff1A4DBE)};
    }
  }

  /// get combined recent activity list for UI
  List<Map<String, dynamic>> getCombinedActivityList() {
    if (recentActivityData.value == null) return [];

    final recentData = recentActivityData.value!;
    List<Map<String, dynamic>> activities = [];

    // add SOP activities
    for (var sop in recentData.sopActivity) {
      final buttonStyle = getActivityButtonStyle('sop');
      activities.add({
        'title': sop.title,
        'subtitle': sop.author,
        'duration': getTimeDifference(sop.updatedAt),
        'buttonText': buttonStyle['text'],
        'buttonColor': buttonStyle['color'],
        'createdAt': sop.updatedAt,
        'type': 'sop',
      });
    }

    // add credentials activities
    for (var credential in recentData.credentialsActivity) {
      final buttonStyle = getActivityButtonStyle('user');
      activities.add({
        'title':
            'New user registered: ${credential.firstName} ${credential.lastName}',
        'subtitle': credential.email,
        'duration': getTimeDifference(credential.createdAt),
        'buttonText': buttonStyle['text'],
        'buttonColor': buttonStyle['color'],
        'createdAt': credential.createdAt,
        'type': 'user',
      });
    }

    // add incident activities (if any)
    for (var incident in recentData.incidentReportActivity) {
      final buttonStyle = getActivityButtonStyle('incident');
      activities.add({
        'title': incident.title,
        'subtitle': 'System',
        'duration': getTimeDifference(incident.createdAt),
        'buttonText': buttonStyle['text'],
        'buttonColor': buttonStyle['color'],
        'createdAt': incident.createdAt,
        'type': 'incident',
      });
    }

    // sort by creation date (most recent first) and take only first 4
    activities.sort(
      (a, b) =>
          (b['createdAt'] as DateTime).compareTo(a['createdAt'] as DateTime),
    );
    return activities.take(4).toList();
  }

  /// save medicine reference guide to API
  Future<void> saveMedicine() async {
    // validation check
    if (medicationNameController.text.trim().isEmpty ||
        medicationDoseController.text.trim().isEmpty) {
      EasyLoading.showError('Please fill all fields');
      return;
    }

    EasyLoading.show(status: 'Saving...');

    try {
      final response = await NetworkCaller.postRequest(
        endpoint: createMedicineEndpoint,
        body: {
          'title': medicationNameController.text.trim(),
          'description': medicationDoseController.text.trim(),
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> json = jsonDecode(response.body);

        if (json['statusCode'] == 200) {
          EasyLoading.showSuccess(
            json['message'] ?? 'Medicine created successfully',
          );

          // clear text fields
          medicationNameController.clear();
          medicationDoseController.clear();

          // close dialog
          Get.back();
        } else {
          EasyLoading.showError(json['message'] ?? 'Failed to create medicine');
        }
      } else {
        EasyLoading.showError('Failed to save medicine');
      }
    } catch (e) {
      EasyLoading.showError(e.toString());
    }
  }
}
