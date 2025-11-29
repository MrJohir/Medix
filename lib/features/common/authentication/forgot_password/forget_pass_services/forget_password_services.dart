import 'dart:convert';
import 'package:dermaininstitute/core/utils/constants/api_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ForgetPasswordServices {
  Future<Map<String, dynamic>> sendPasswordResetOtp(String email) async {
    try {
      debugPrint('=== Starting API call ===');
      debugPrint('Endpoint: $forgetpasswordEndpoint'); // Print the URL
      debugPrint('Email: $email'); // Confirm email is passed correctly

      final uri = Uri.parse(
        "$baseUrl$forgetpasswordEndpoint",
      ); // Parse explicitly for debugging
      debugPrint('Parsed URI: $uri'); // Check if URL is valid

      final body = jsonEncode({'email': email});
      debugPrint('Request body: $body'); // Log the JSON payload

      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      debugPrint(
        'Response status: ${response.statusCode}',
      ); // Always print status
      debugPrint(
        'Response headers: ${response.headers}',
      ); // Useful for CORS issues
      debugPrint('Response body: ${response.body}'); // Raw response

      if (response.statusCode == 200) {
        debugPrint('Password reset OTP sent successfully');
        return jsonDecode(response.body);
      } else {
        throw Exception(
          'Failed to send password reset OTP: ${response.statusCode} - ${response.body}',
        );
      }
    } catch (e) {
      debugPrint(
        'Exception in sendPasswordResetOtp: $e',
      ); // Catch and print ALL errors
      throw Exception('Error sending password reset OTP: $e');
    }
  }
}
