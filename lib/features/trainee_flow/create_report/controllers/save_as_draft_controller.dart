import 'package:dermaininstitute/features/trainee_flow/create_report/models/create_report_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SaveAsDraftController extends GetxController {
  static const String _draftKey = 'create_report_draft';
  final GetStorage _storage = GetStorage();

  /// Save user form data as draft to local storage
  Future<void> saveUserDataAsDraft(CreateReportModel reportModel) async {
    try {
      await _storage.write(_draftKey, reportModel.toJson());
      debugPrint('Draft data saved successfully');
    } catch (e) {
      debugPrint('Error saving draft: $e');
      rethrow;
    }
  }

  /// Load draft data from local storage
  CreateReportModel? loadDraftData() {
    try {
      final draftData = _storage.read(_draftKey);
      if (draftData != null) {
        return CreateReportModel.fromJson(Map<String, dynamic>.from(draftData));
      }
      return null;
    } catch (e) {
      debugPrint('Error loading draft data: $e');
      return null;
    }
  }

  /// Clear draft data from local storage
  Future<void> clearDraftData() async {
    try {
      await _storage.remove(_draftKey);
      debugPrint('Draft data cleared successfully');
    } catch (e) {
      debugPrint('Error clearing draft data: $e');
    }
  }

  /// Auto-save draft data (can be called periodically)
  Future<void> autoSaveDraft(CreateReportModel reportModel) async {
    try {
      await _storage.write(_draftKey, reportModel.toJson());
      debugPrint('Auto-saved draft data');
    } catch (e) {
      debugPrint('Error auto-saving draft: $e');
    }
  }
}
