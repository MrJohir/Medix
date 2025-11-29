import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import '../../features/admin_flow/dashboard_section/add_new_sop/models/simple_draft_sop_model.dart';
import '../../features/trainee_flow/create_report/models/simple_draft_report_model.dart';

/// Simple local data service using GetStorage for local database
/// Handles save, get, and delete operations for both draft SOPs and draft reports
class LocalDataService {
  static const String _sopStorageKey = 'draft_sops';
  static const String _reportStorageKey = 'draft_reports';
  static final GetStorage _storage = GetStorage();
  static final Logger _logger = Logger();

  /// Save draft SOP to local storage
  /// [draftSOP] - The draft SOP data to save
  /// Returns: true if saved successfully, false otherwise
  static Future<bool> saveDraftSOP(SimpleDraftSOPModel draftSOP) async {
    try {
      final List<Map<String, dynamic>> existingDrafts =
          _getAllSOPDraftsAsJson();

      // Remove existing draft with same ID if any
      existingDrafts.removeWhere((draft) => draft['id'] == draftSOP.id);

      // Add new draft
      existingDrafts.add(draftSOP.toJson());

      // Save to storage
      await _storage.write(_sopStorageKey, existingDrafts);

      _logger.i('Draft SOP saved successfully with ID: ${draftSOP.id}');
      return true;
    } catch (e) {
      _logger.e('Error saving draft SOP: $e');
      return false;
    }
  }

  /// Get all draft SOPs from local storage
  /// Returns: List of all saved draft SOPs
  static List<SimpleDraftSOPModel> getAllDraftSOPs() {
    try {
      final List<Map<String, dynamic>> draftsJson = _getAllSOPDraftsAsJson();
      final List<SimpleDraftSOPModel> drafts = draftsJson
          .map((json) => SimpleDraftSOPModel.fromJson(json))
          .toList();

      _logger.i('Retrieved ${drafts.length} draft SOPs');
      return drafts;
    } catch (e) {
      _logger.e('Error getting draft SOPs: $e');
      return [];
    }
  }

  /// Get draft SOP by ID
  /// [id] - The ID of the draft SOP to retrieve
  /// Returns: SimpleDraftSOPModel if found, null otherwise
  static SimpleDraftSOPModel? getDraftSOPById(String id) {
    try {
      final List<Map<String, dynamic>> draftsJson = _getAllSOPDraftsAsJson();
      final Map<String, dynamic>? draftJson = draftsJson.firstWhereOrNull(
        (draft) => draft['id'] == id,
      );

      if (draftJson != null) {
        _logger.i('Retrieved draft SOP with ID: $id');
        return SimpleDraftSOPModel.fromJson(draftJson);
      } else {
        _logger.w('Draft SOP not found with ID: $id');
        return null;
      }
    } catch (e) {
      _logger.e('Error getting draft SOP by ID: $e');
      return null;
    }
  }

  /// Delete draft SOP from local storage
  /// [id] - The ID of the draft SOP to delete
  /// Returns: true if deleted successfully, false otherwise
  static Future<bool> deleteDraftSOP(String id) async {
    try {
      final List<Map<String, dynamic>> existingDrafts =
          _getAllSOPDraftsAsJson();
      final int initialLength = existingDrafts.length;

      // Remove draft with matching ID
      existingDrafts.removeWhere((draft) => draft['id'] == id);

      if (existingDrafts.length < initialLength) {
        // Save updated list
        await _storage.write(_sopStorageKey, existingDrafts);
        _logger.i('Draft SOP deleted successfully with ID: $id');
        return true;
      } else {
        _logger.w('Draft SOP not found for deletion with ID: $id');
        return false;
      }
    } catch (e) {
      _logger.e('Error deleting draft SOP: $e');
      return false;
    }
  }

  /// Clear all draft SOPs from local storage
  /// Returns: true if cleared successfully, false otherwise
  static Future<bool> clearAllDraftSOPs() async {
    try {
      await _storage.remove(_sopStorageKey);
      _logger.i('All draft SOPs cleared successfully');
      return true;
    } catch (e) {
      _logger.e('Error clearing all draft SOPs: $e');
      return false;
    }
  }

  /// Get count of draft SOPs
  /// Returns: Number of draft SOPs stored
  static int getDraftSOPCount() {
    try {
      final List<Map<String, dynamic>> drafts = _getAllSOPDraftsAsJson();
      return drafts.length;
    } catch (e) {
      _logger.e('Error getting draft SOP count: $e');
      return 0;
    }
  }

  /// Check if draft SOP exists by ID
  /// [id] - The ID to check
  /// Returns: true if exists, false otherwise
  static bool draftSOPExists(String id) {
    try {
      final List<Map<String, dynamic>> drafts = _getAllSOPDraftsAsJson();
      return drafts.any((draft) => draft['id'] == id);
    } catch (e) {
      _logger.e('Error checking if draft SOP exists: $e');
      return false;
    }
  }

  // ==================== DRAFT REPORTS METHODS ====================

  /// Save draft report to local storage
  /// [draftReport] - The draft report data to save
  /// Returns: true if saved successfully, false otherwise
  static Future<bool> saveDraftReport(
    SimpleDraftReportModel draftReport,
  ) async {
    try {
      final List<Map<String, dynamic>> existingDrafts =
          _getAllReportDraftsAsJson();

      // Remove existing draft with same ID if any
      existingDrafts.removeWhere((draft) => draft['id'] == draftReport.id);

      // Add new draft
      existingDrafts.add(draftReport.toJson());

      // Save to storage
      await _storage.write(_reportStorageKey, existingDrafts);

      _logger.i('Draft report saved successfully with ID: ${draftReport.id}');
      return true;
    } catch (e) {
      _logger.e('Error saving draft report: $e');
      return false;
    }
  }

  /// Get all draft reports from local storage
  /// Returns: List of all saved draft reports
  static List<SimpleDraftReportModel> getAllDraftReports() {
    try {
      final List<Map<String, dynamic>> draftsJson = _getAllReportDraftsAsJson();
      final List<SimpleDraftReportModel> drafts = draftsJson
          .map((json) => SimpleDraftReportModel.fromJson(json))
          .toList();

      _logger.i('Retrieved ${drafts.length} draft reports');
      return drafts;
    } catch (e) {
      _logger.e('Error getting draft reports: $e');
      return [];
    }
  }

  /// Get draft report by ID
  /// [id] - The ID of the draft report to retrieve
  /// Returns: SimpleDraftReportModel if found, null otherwise
  static SimpleDraftReportModel? getDraftReportById(String id) {
    try {
      final List<Map<String, dynamic>> draftsJson = _getAllReportDraftsAsJson();
      final Map<String, dynamic>? draftJson = draftsJson.firstWhereOrNull(
        (draft) => draft['id'] == id,
      );

      if (draftJson != null) {
        _logger.i('Retrieved draft report with ID: $id');
        return SimpleDraftReportModel.fromJson(draftJson);
      } else {
        _logger.w('Draft report not found with ID: $id');
        return null;
      }
    } catch (e) {
      _logger.e('Error getting draft report by ID: $e');
      return null;
    }
  }

  /// Delete draft report from local storage
  /// [id] - The ID of the draft report to delete
  /// Returns: true if deleted successfully, false otherwise
  static Future<bool> deleteDraftReport(String id) async {
    try {
      final List<Map<String, dynamic>> existingDrafts =
          _getAllReportDraftsAsJson();
      final int initialLength = existingDrafts.length;

      // Remove draft with matching ID
      existingDrafts.removeWhere((draft) => draft['id'] == id);

      if (existingDrafts.length < initialLength) {
        // Save updated list
        await _storage.write(_reportStorageKey, existingDrafts);
        _logger.i('Draft report deleted successfully with ID: $id');
        return true;
      } else {
        _logger.w('Draft report not found for deletion with ID: $id');
        return false;
      }
    } catch (e) {
      _logger.e('Error deleting draft report: $e');
      return false;
    }
  }

  /// Clear all draft reports from local storage
  /// Returns: true if cleared successfully, false otherwise
  static Future<bool> clearAllDraftReports() async {
    try {
      await _storage.remove(_reportStorageKey);
      _logger.i('All draft reports cleared successfully');
      return true;
    } catch (e) {
      _logger.e('Error clearing all draft reports: $e');
      return false;
    }
  }

  /// Get count of draft reports
  /// Returns: Number of draft reports stored
  static int getDraftReportCount() {
    try {
      final List<Map<String, dynamic>> drafts = _getAllReportDraftsAsJson();
      return drafts.length;
    } catch (e) {
      _logger.e('Error getting draft report count: $e');
      return 0;
    }
  }

  /// Check if draft report exists by ID
  /// [id] - The ID to check
  /// Returns: true if exists, false otherwise
  static bool draftReportExists(String id) {
    try {
      final List<Map<String, dynamic>> drafts = _getAllReportDraftsAsJson();
      return drafts.any((draft) => draft['id'] == id);
    } catch (e) {
      _logger.e('Error checking if draft report exists: $e');
      return false;
    }
  }

  // ==================== HELPER METHODS ====================

  /// Helper method to get all SOP drafts as JSON from storage
  static List<Map<String, dynamic>> _getAllSOPDraftsAsJson() {
    final dynamic storedData = _storage.read(_sopStorageKey);

    if (storedData == null) {
      return [];
    }

    if (storedData is List) {
      return storedData.cast<Map<String, dynamic>>();
    }

    return [];
  }

  /// Helper method to get all report drafts as JSON from storage
  static List<Map<String, dynamic>> _getAllReportDraftsAsJson() {
    final dynamic storedData = _storage.read(_reportStorageKey);

    if (storedData == null) {
      return [];
    }

    if (storedData is List) {
      return storedData.cast<Map<String, dynamic>>();
    }

    return [];
  }
}

/// Extension to add firstWhereOrNull to Iterable
extension IterableExtension<T> on Iterable<T> {
  T? firstWhereOrNull(bool Function(T) test) {
    for (T element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}
