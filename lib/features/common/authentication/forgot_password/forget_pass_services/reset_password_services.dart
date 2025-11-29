import 'dart:convert';
import 'package:dermaininstitute/core/utils/constants/api_constants.dart';
import 'package:flutter/rendering.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class ResetPasswordService {
  final box = GetStorage();

  Future<Map<String, dynamic>> resetPassword(String password) async {
    try {
      final token = box.read('verificationToken'); // 🔑 get saved token
      if (token == null) {
        throw Exception("No verification token found in storage");
      }

      debugPrint("🔹 Sending Reset Password request...");
      debugPrint("➡️ URL: $baseUrl/auth/reset-password");
      debugPrint("➡️ Token: $token");
      debugPrint("➡️ New Password: $password");

      final response = await http.post(
        Uri.parse('$baseUrl/auth/reset-password'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'token': token, 'password': password}),
      );

      debugPrint("✅ Response Status: ${response.statusCode}");
      debugPrint("✅ Response Body: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to reset password: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint("❌ Error resetting password: $e");
      throw Exception('Error resetting password: $e');
    }
  }
}
