import 'dart:convert';
import 'package:dermaininstitute/core/utils/constants/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class OtpVerifyService {
  final box = GetStorage();

  Future<Map<String, dynamic>> verifyOtp(String otp) async {
    try {
      debugPrint("🔹 Sending OTP verification request...");
      debugPrint("➡️ URL: $baseUrl/auth/verify-otp");
      debugPrint("➡️ OTP: $otp");

      final response = await http.post(
        Uri.parse('$baseUrl/auth/verify-otp'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'otp': int.parse(otp)}), // ✅ send as int
      );

      debugPrint("✅ Response Status: ${response.statusCode}");
      debugPrint("✅ Response Body: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);

        // ✅ Extract and save verification token
        final token = responseData['data']['verificationToken'];
        if (token != null) {
          box.write('verificationToken', token);
          debugPrint("🔑 Token saved to storage: $token");
        }

        debugPrint("✅ OTP verified successfully");
        return responseData;
      } else {
        throw Exception('Failed to verify OTP: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint("❌ Error verifying OTP: $e");
      throw Exception('Error verifying OTP: $e');
    }
  }
}
