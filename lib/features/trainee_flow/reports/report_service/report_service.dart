// lib/services/api_service.dart
import 'dart:convert';
import 'package:dermaininstitute/core/utils/constants/api_constants.dart';
import 'package:dermaininstitute/features/trainee_flow/reports/models/insident_api_model.dart';
import 'package:http/http.dart' as http;

class ReportService {
  Future<List<Report>> getReports({String? situation, String? title}) async {
    try {
      // Build query parameters
      final Map<String, String> queryParams = {};
      if (situation != null && situation.isNotEmpty) {
        queryParams['situation'] = situation;
      }
      if (title != null && title.isNotEmpty) {
        queryParams['title'] = title;
      }

      // Construct the URL
      final uri = Uri.parse(
        "$baseUrl/report",
      ).replace(queryParameters: queryParams);
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Report.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load reports: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching reports: $e');
    }
  }
}
