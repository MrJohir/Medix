import 'dart:convert';
import 'dart:io';
import 'package:dermaininstitute/core/utils/constants/api_constants.dart';
import 'package:http_parser/http_parser.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

class TriageApiService {
  static String? _getMimeType(String filePath) {
    final ext = path.extension(filePath).toLowerCase();
    switch (ext) {
      case '.jpg':
      case '.jpeg':
        return 'image/jpeg';
      case '.png':
        return 'image/png';
      case '.gif':
        return 'image/gif';
      case '.bmp':
        return 'image/bmp';
      case '.webp':
        return 'image/webp';
      default:
        return null;
    }
  }

  /// Send message or image to AI triage API
  static Future<Map<String, dynamic>> sendTriageMessage({
    required String query,
    required String userId,
    required String chatId,
    required String jurisdiction,
    File? file,
  }) async {
    try {
      debugPrint("📤 Sending triage message...");
      debugPrint("Query: $query");
      debugPrint("UserId: $userId");
      debugPrint("ChatId: $chatId");
      if (file != null) debugPrint("File path: ${file.path}");

      var request = http.MultipartRequest(
        "POST",
        Uri.parse(aIbaseUrl + chatAIEndpoint),
      );

      // Add headers
      request.headers.addAll({
        'accept': 'application/json',
        'Content-Type': 'multipart/form-data',
      });

      request.fields['query'] = query;
      request.fields['user_id'] = userId;
      request.fields['chat_id'] = chatId;
      request.fields['jurisdiction'] = jurisdiction;

      if (file != null) {
        // Add file with content type
        final mimeType = _getMimeType(file.path);
        request.files.add(
          await http.MultipartFile.fromPath(
            "file",
            file.path,
            contentType: mimeType != null ? MediaType.parse(mimeType) : null,
          ),
        );
      }

      var response = await request.send();
      var body = await response.stream.bytesToString();

      debugPrint("📥 Response status: ${response.statusCode}");
      debugPrint("📥 Response body: $body");

      if (response.statusCode == 200) {
        return jsonDecode(body);
      } else {
        throw Exception("Error ${response.statusCode}: $body");
      }
    } catch (e) {
      debugPrint("❌ API failed: $e");
      throw Exception("API failed: $e");
    }
  }

  ///emargency protocol API call

  static Future<Map<String, dynamic>> callEmergencyProtocol({
    required String userId,
    required String chatId,
    required String jurisdiction,
    required String detectedComplication,
  }) async {
    final url = Uri.parse(
      "https://dermainstitute-ai.onrender.com/api/v1/triage/emergency-protocol",
    );

    final body = {
      "user_id": userId,
      "chat_id": chatId,
      "jurisdiction": jurisdiction,
      "detected_complication": detectedComplication,
    };

    final response = await http.post(
      url,
      headers: {
        "accept": "application/json",
        "Content-Type": "application/json",
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
        "Failed to call emergency protocol: ${response.statusCode} ${response.body}",
      );
    }
  }
}
