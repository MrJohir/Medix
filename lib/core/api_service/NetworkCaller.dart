// ignore_for_file: file_names

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:get_storage/get_storage.dart';
import '../utils/constants/api_constants.dart';

class NetworkCaller {
  static final Logger _logger = Logger();
  static final GetStorage _storage = GetStorage();

  /// Get auth token from storage
  static String? get _authToken => _storage.read('authToken');

  /// Get common headers for API requests
  static Map<String, String> get _headers {
    final headers = {'Content-Type': 'application/json', 'Accept': '*/*'};

    // Add auth token if available
    if (_authToken != null && _authToken!.isNotEmpty) {
      headers['Authorization'] = 'Bearer $_authToken';
    }

    return headers;
  }

  /// Generic POST request method
  static Future<http.Response> postRequest({
    required String endpoint,
    Map<String, dynamic>? body,
  }) async {
    try {
      final url = Uri.parse('$baseUrl$endpoint');

      _logger.i('POST Request to: $url');
      _logger.i('Headers: $_headers');
      _logger.i('Body: ${body != null ? jsonEncode(body) : 'null'}');

      final response = await http.post(
        url,
        headers: _headers,
        body: body != null ? jsonEncode(body) : null,
      );

      _logger.i('Response Status: ${response.statusCode}');
      _logger.i('Response Body: ${response.body}');

      return response;
    } on SocketException catch (e) {
      _logger.e('Network error: $e');
      throw Exception('No internet connection. Please check your network.');
    } on http.ClientException catch (e) {
      _logger.e('Client error: $e');
      throw Exception('Request failed. Please try again.');
    } catch (e) {
      _logger.e('Unexpected error: $e');
      throw Exception('Something went wrong. Please try again.');
    }
  }

  /// Generic GET request method
  static Future<http.Response> getRequest({
    required String endpoint,
    Map<String, String>? queryParams,
  }) async {
    try {
      var url = Uri.parse('$baseUrl$endpoint');

      // Add query parameters if provided
      if (queryParams != null && queryParams.isNotEmpty) {
        url = url.replace(queryParameters: queryParams);
      }

      _logger.i('GET Request to: $url');
      _logger.i('Headers: $_headers');

      final response = await http.get(url, headers: _headers);

      _logger.i('Response Status: ${response.statusCode}');
      _logger.i('Response Body: ${response.body}');

      return response;
    } on SocketException catch (e) {
      _logger.e('Network error: $e');
      throw Exception('No internet connection. Please check your network.');
    } on http.ClientException catch (e) {
      _logger.e('Client error: $e');
      throw Exception('Request failed. Please try again.');
    } catch (e) {
      _logger.e('Unexpected error: $e');
      throw Exception('Something went wrong. Please try again.');
    }
  }

  /// Generic PUT request method
  static Future<http.Response> putRequest({
    required String endpoint,
    Map<String, dynamic>? body,
  }) async {
    try {
      final url = Uri.parse('$baseUrl$endpoint');

      _logger.i('PUT Request to: $url');
      _logger.i('Headers: $_headers');
      _logger.i('Body: ${body != null ? jsonEncode(body) : 'null'}');

      final response = await http.put(
        url,
        headers: _headers,
        body: body != null ? jsonEncode(body) : null,
      );

      _logger.i('Response Status: ${response.statusCode}');
      _logger.i('Response Body: ${response.body}');

      return response;
    } on SocketException catch (e) {
      _logger.e('Network error: $e');
      throw Exception('No internet connection. Please check your network.');
    } on http.ClientException catch (e) {
      _logger.e('Client error: $e');
      throw Exception('Request failed. Please try again.');
    } catch (e) {
      _logger.e('Unexpected error: $e');
      throw Exception('Something went wrong. Please try again.');
    }
  }

  /// Generic DELETE request method
  static Future<http.Response> deleteRequest({required String endpoint}) async {
    try {
      final url = Uri.parse('$baseUrl$endpoint');

      _logger.i('DELETE Request to: $url');
      _logger.i('Headers: $_headers');

      final response = await http.delete(url, headers: _headers);

      _logger.i('Response Status: ${response.statusCode}');
      _logger.i('Response Body: ${response.body}');

      return response;
    } on SocketException catch (e) {
      _logger.e('Network error: $e');
      throw Exception('No internet connection. Please check your network.');
    } on http.ClientException catch (e) {
      _logger.e('Client error: $e');
      throw Exception('Request failed. Please try again.');
    } catch (e) {
      _logger.e('Unexpected error: $e');
      throw Exception('Something went wrong. Please try again.');
    }
  }

  /// Generic PATCH request method
  static Future<http.Response> patchRequest({
    required String endpoint,
    Map<String, dynamic>? body,
  }) async {
    try {
      final url = Uri.parse('$baseUrl$endpoint');

      _logger.i('PATCH Request to: $url');
      _logger.i('Headers: $_headers');
      _logger.i('Body: ${body != null ? jsonEncode(body) : 'null'}');

      final response = await http.patch(
        url,
        headers: _headers,
        body: body != null ? jsonEncode(body) : null,
      );

      _logger.i('Response Status: ${response.statusCode}');
      _logger.i('Response Body: ${response.body}');

      return response;
    } on SocketException catch (e) {
      _logger.e('Network error: $e');
      throw Exception('No internet connection. Please check your network.');
    } on http.ClientException catch (e) {
      _logger.e('Client error: $e');
      throw Exception('Request failed. Please try again.');
    } catch (e) {
      _logger.e('Unexpected error: $e');
      throw Exception('Something went wrong. Please try again.');
    }
  }
}
