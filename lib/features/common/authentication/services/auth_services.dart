// auth_service.dart
import 'dart:convert';
import 'package:dermaininstitute/core/utils/constants/api_constants.dart';
import 'package:dermaininstitute/features/common/notification/notification_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final NotificationController notificationController =
      Get.find<NotificationController>();
  // Login method
  Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse("$baseUrl/auth/login");
    debugPrint("🔹 Login request to: $url");
    debugPrint("🔹 Email: $email");
    debugPrint("🔹 FCM Token: ${notificationController.fcmToken.value}");
    http.Response response;
    try {
      response = await http.post(
        url,
        headers: {'accept': '*/*', 'Content-Type': 'application/json'},
        body: jsonEncode({
          "email": email,
          "password": password,
          "fcmToken": notificationController.fcmToken.value,
        }),
      );
    } catch (e) {
      return {"success": false, "message": "Network error: $e"};
    }

    debugPrint("HTTP status: ${response.statusCode}");
    debugPrint("Body: ${response.body}");

    Map<String, dynamic>? json;
    try {
      json = jsonDecode(response.body) as Map<String, dynamic>;
    } catch (_) {
      // Non-JSON response
      return {
        "success": response.statusCode >= 200 && response.statusCode < 300,
        "message": response.body.isNotEmpty
            ? response.body
            : "Unexpected response",
      };
    }

    // Treat either a 2xx HTTP code OR a JSON { success: true } as success
    final httpOk = response.statusCode >= 200 && response.statusCode < 300;
    final bodyOk = (json['success'] == true) || (json['statusCode'] == 200);

    if (httpOk || bodyOk) {
      return {"success": true, "data": json};
    } else {
      return {
        "success": false,
        "message": (json['message'] as String?) ?? 'Login failed',
        "data": json,
      };
    }
  }

  // Signup method
  Future<Map<String, dynamic>> signup({
    required String email,
    required String password,
    required String phone,
    required String firstName,
    required String lastName,
    required String role,
    required String jurisdiction,
  }) async {
    final url = Uri.parse("$baseUrl/auth/signup");

    final body = jsonEncode({
      "email": email,
      "password": password,
      "phone": phone,
      "firstName": firstName,
      "lastName": lastName,
      "role": role.toUpperCase(),
      "jurisdiction": jurisdiction,
      // API expects TRAINEE/ADMIN
    });

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json', 'accept': '*/*'},
      body: body,
    );

    final decoded = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      // Check for API-level success field
      if (decoded is Map<String, dynamic>) {
        if (decoded['success'] == false ||
            decoded['error'] != null ||
            decoded['message']?.toString().toLowerCase().contains("exists") ==
                true) {
          // Throw explicit exception
          throw Exception(decoded['message'] ?? 'Signup failed');
        }
        return decoded;
      } else {
        return {"raw": decoded};
      }
    } else {
      // Non-200 status, definitely fail
      throw Exception("Signup failed: ${decoded['message'] ?? response.body}");
    }
  }
}
