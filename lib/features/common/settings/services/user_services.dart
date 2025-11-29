import 'dart:convert';
import 'dart:io';
import 'package:dermaininstitute/core/utils/constants/api_constants.dart';
import 'package:dermaininstitute/features/admin_flow/user_section/user_management/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserService {
  static Future<UserModel?> getMe({required String token}) async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/user/get-me"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token", // if JWT token needed
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // ✅ Safe printing
        debugPrint(jsonEncode(data));

        return UserModel.fromJson(data["data"]);
      } else {
        debugPrint("Error: ${response.body}");
        return null;
      }
    } catch (e) {
      debugPrint("Exception: $e");
      return null;
    }
  }

  // ======================
  // Update Profile
  // ======================
  static Future<UserModel?> updateProfile({
    required String token,
    required String firstName,
    required String lastName,
    required String phone,
    required String specialization,
    required String jurisdiction,
    File? image,
  }) async {
    final uri = Uri.parse("$baseUrl/user/update-profile");
    final request = http.MultipartRequest("PATCH", uri);

    // Headers
    request.headers["Authorization"] = "Bearer $token";

    // Fields (remove email)
    request.fields["firstName"] = firstName;
    request.fields["lastName"] = lastName;
    request.fields["phone"] = phone;
    request.fields["specialization"] = specialization;
    request.fields["jurisdiction"] = jurisdiction;

    // Image if available
    if (image != null && image.existsSync()) {
      request.files.add(await http.MultipartFile.fromPath("image", image.path));
    }

    final response = await request.send();
    final body = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      debugPrint("Response Body: $body");
      return UserModel.fromJson(json.decode(body)["data"]);
    } else {
      throw Exception(
        "Failed to update profile: ${response.statusCode} - $body",
      );
    }
  }

  /// Change/Reset Password API
  static Future<bool> resetPassword({
    required String token,
    required String oldPassword,
    required String newPassword,
  }) async {
    final url = Uri.parse("$baseUrl/auth/user/reset-password");

    try {
      final response = await http.patch(
        url,
        headers: {
          'accept': '*/*',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'oldPassword': oldPassword,
          'newPassword': newPassword,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['success'] == true) {
          debugPrint('✅ Password reset successful');
          return true;
        } else {
          debugPrint('❌ Password reset failed: ${data['message']}');
          return false;
        }
      } else {
        debugPrint('❌ HTTP Error: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      debugPrint('❌ Error resetting password: $e');
      return false;
    }
  }

  static Future<Map<String, dynamic>?> updateNotifications({
    required String token,
    required String notification,
    required String emargencyAlert,
  }) async {
    final url = Uri.parse('$baseUrl/user/update-profile');

    try {
      final response = await http.patch(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'notification': notification,
          'emargencyAlert': emargencyAlert,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body)['data'];
      } else {
        debugPrint('❌ Failed to update notifications: ${response.body}');
      }
    } catch (e) {
      debugPrint('❌ Exception in updateNotifications: $e');
    }

    return null;
  }
}
