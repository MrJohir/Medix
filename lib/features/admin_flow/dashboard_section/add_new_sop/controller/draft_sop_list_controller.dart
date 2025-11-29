import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../../../core/services/local_data_service.dart';
import '../models/simple_draft_sop_model.dart';
import '../../../../../core/api_service/NetworkCaller.dart';
import '../../../../../core/utils/constants/api_constants.dart';

/// Controller for managing draft SOPs list screen
/// Handles loading, publishing, and deleting draft SOPs
class DraftSOPListController extends GetxController {
  final Logger _logger = Logger();

  // Reactive variables
  final RxList<SimpleDraftSOPModel> draftSOPs = <SimpleDraftSOPModel>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadDraftSOPs();
  }

  /// Load all draft SOPs from local database
  void loadDraftSOPs() {
    try {
      final drafts = LocalDataService.getAllDraftSOPs();
      draftSOPs.value = drafts;
      _logger.i('Loaded ${drafts.length} draft SOPs');
    } catch (e) {
      _logger.e('Error loading draft SOPs: $e');
      EasyLoading.showError('Failed to load draft SOPs');
    }
  }

  /// Publish draft SOP to server
  /// [draftSOP] - The draft SOP to publish
  Future<void> publishDraftSOP(SimpleDraftSOPModel draftSOP) async {
    try {
      isLoading.value = true;
      EasyLoading.show(status: 'Publishing SOP...');

      // Convert draft SOP to API format
      final apiData = draftSOP.toApiJson();

      // Send to server
      final response = await NetworkCaller.postRequest(
        endpoint: createSOPEndpoint,
        body: apiData,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Remove from local database after successful publish
        await LocalDataService.deleteDraftSOP(draftSOP.id);

        // Remove from UI list
        draftSOPs.removeWhere((draft) => draft.id == draftSOP.id);

        EasyLoading.showSuccess('SOP published successfully!');
        _logger.i('Draft SOP published and removed: ${draftSOP.id}');
      } else {
        EasyLoading.showError('Failed to publish SOP');
        _logger.e('Failed to publish draft SOP: ${response.statusCode}');
      }
    } catch (e) {
      EasyLoading.showError('Error publishing SOP');
      _logger.e('Error publishing draft SOP: $e');
    } finally {
      isLoading.value = false;
      EasyLoading.dismiss();
    }
  }

  /// Delete draft SOP from local database
  /// [draftSOP] - The draft SOP to delete
  Future<void> deleteDraftSOP(SimpleDraftSOPModel draftSOP) async {
    try {
      EasyLoading.show(status: 'Deleting draft...');

      // Delete from local database
      final deleted = await LocalDataService.deleteDraftSOP(draftSOP.id);

      if (deleted) {
        // Remove from UI list
        draftSOPs.removeWhere((draft) => draft.id == draftSOP.id);

        EasyLoading.showSuccess('Draft deleted successfully!');
        _logger.i('Draft SOP deleted: ${draftSOP.id}');
      } else {
        EasyLoading.showError('Failed to delete draft');
        _logger.e('Failed to delete draft SOP: ${draftSOP.id}');
      }
    } catch (e) {
      EasyLoading.showError('Error deleting draft');
      _logger.e('Error deleting draft SOP: $e');
    } finally {
      EasyLoading.dismiss();
    }
  }

  /// Refresh draft SOPs list
  void refreshDraftSOPs() {
    loadDraftSOPs();
  }

  /// Get total count of draft SOPs
  int get draftCount => draftSOPs.length;

  /// Check if no drafts available
  bool get hasNoDrafts => draftSOPs.isEmpty;

  /// Navigate back
  void onBackPressed() {
    Get.back();
  }
}
