import 'package:dermaininstitute/core/utils/constants/api_constants.dart';
import 'package:dermaininstitute/core/utils/logging/logger.dart';
import 'package:dermaininstitute/features/trainee_flow/protocols/models/all_sop_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';

class SopService {
  /// fetch all SOPs from API
  Future<List<Sop>> fetchAllSop() async {
    try {
      final uri = Uri.parse('$baseUrl/sop');
      final response = await http.get(
        uri,
        headers: {HttpHeaders.acceptHeader: 'application/json'},
      );

      AppLoggerHelper.info('Fetching SOPs - Status: ${response.statusCode}');

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => Sop.fromJson(json)).toList();
      } else {
        AppLoggerHelper.error('Failed to fetch SOPs: ${response.statusCode}');
        throw HttpException('Failed to load SOPs (${response.statusCode})');
      }
    } catch (error) {
      AppLoggerHelper.error('Error fetching SOPs: $error');
      EasyLoading.showError('Failed to load protocols: ${error.toString()}');
      rethrow;
    }
  }

  /// search SOPs with query parameters
  Future<List<Sop>> searchSop({
    String? jurisdiction,
    String? title,
    String? status,
  }) async {
    try {
      // Build query parameters
      Map<String, String> queryParams = {};
      if (jurisdiction != null && jurisdiction.isNotEmpty) {
        queryParams['jurisdiction'] = jurisdiction;
      }
      if (title != null && title.isNotEmpty) {
        queryParams['title'] = title;
      }
      if (status != null && status.isNotEmpty) {
        queryParams['status'] = status;
      }

      AppLoggerHelper.info('Searching SOPs with params: $queryParams');

      final uri = Uri.parse(
        '$baseUrl/sop',
      ).replace(queryParameters: queryParams);
      final response = await http.get(
        uri,
        headers: {HttpHeaders.acceptHeader: 'application/json'},
      );

      if (kDebugMode) {
        debugPrint('Search response: ${response.body}');
      }

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => Sop.fromJson(json)).toList();
      } else {
        AppLoggerHelper.error('Failed to search SOPs: ${response.statusCode}');
        throw HttpException('Failed to search SOPs (${response.statusCode})');
      }
    } catch (error) {
      AppLoggerHelper.error('Error searching SOPs: $error');
      EasyLoading.showError('Failed to search protocols: ${error.toString()}');
      rethrow;
    }
  }
}
