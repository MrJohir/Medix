import 'dart:convert';
import 'package:dermaininstitute/core/api_service/NetworkCaller.dart';
import 'package:dermaininstitute/core/utils/constants/api_constants.dart';
import 'package:dermaininstitute/features/admin_flow/dashboard_section/add_new_sop/views/screens/add_new_sop_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import '../../sop_view/views/screens/details_view_screen.dart';
import '../model/sop_model.dart';

class ManageSOPsController extends GetxController {
  final Logger _logger = Logger();

  // Search and Filter controllers
  final searchController = TextEditingController();
  final jurisdictionController = TextEditingController();
  final statusController = TextEditingController();

  // Observable state variables
  final RxList<SOPModel> sops = <SOPModel>[].obs;
  final RxList<SOPModel> filteredSOPs = <SOPModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxString searchQuery = ''.obs;
  final RxString selectedJurisdiction = 'All'.obs;
  final RxString selectedStatus = 'All'.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    setupSearchListener();
    fetchSOPs();
  }

  /// Setup search text field listener
  void setupSearchListener() {
    searchController.addListener(() {
      searchQuery.value = searchController.text;
      filterSOPs();
    });
  }

  /// Fetch SOPs from API
  Future<void> fetchSOPs() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await NetworkCaller.getRequest(
        endpoint: getAllSOPsEndpoint,
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);

        // Convert response to SOPModel list
        final List<SOPModel> sopList = responseData
            .map((json) => SOPModel.fromJson(json))
            .toList();

        sops.value = sopList;
        filteredSOPs.value = List.from(sops);

        // Debug: Log SOP jurisdictions
        _logger.i('Fetched ${sops.length} SOPs');
        for (final sop in sops) {
          _logger.i(
            'SOP "${sop.title}" has jurisdictions: ${sop.jurisdiction}',
          );
        }

        // Set initial values for dropdowns
        jurisdictionController.text = 'All';
        statusController.text = 'All';

        _logger.i('Successfully fetched ${sops.length} SOPs');
      } else {
        throw Exception('Failed to load SOPs: ${response.statusCode}');
      }
    } catch (error) {
      _logger.e('Error fetching SOPs: $error');
      errorMessage.value = 'Failed to load SOPs. Please try again.';
    } finally {
      isLoading.value = false;
    }
  }

  /// Refresh SOPs data
  Future<void> refreshSOPs() async {
    await fetchSOPs();
  }

  /// Filter SOPs based on search query, jurisdiction, and status
  void filterSOPs() {
    List<SOPModel> filtered = List.from(sops);

    // Filter by search query
    if (searchQuery.value.isNotEmpty) {
      filtered = filtered.where((sop) {
        return sop.title.toLowerCase().contains(
              searchQuery.value.toLowerCase(),
            ) ||
            sop.author.toLowerCase().contains(searchQuery.value.toLowerCase());
      }).toList();
    }

    // Filter by jurisdiction
    if (selectedJurisdiction.value != 'All') {
      filtered = filtered.where((sop) {
        return sop.jurisdiction.any(
          (jurisdiction) => jurisdiction.toLowerCase().contains(
            selectedJurisdiction.value.toLowerCase(),
          ),
        );
      }).toList();
    }

    // Filter by status
    if (selectedStatus.value != 'All') {
      filtered = filtered.where((sop) {
        return sop.displayStatus == selectedStatus.value;
      }).toList();
    }

    filteredSOPs.value = filtered;
  }

  /// Handle jurisdiction selection
  void onJurisdictionChanged(String value) {
    selectedJurisdiction.value = value;
    jurisdictionController.text = value;
    filterSOPs();
  }

  /// Handle status selection
  void onStatusChanged(String value) {
    selectedStatus.value = value;
    statusController.text = value;
    filterSOPs();
  }

  /// Navigate to add new SOP screen
  void onAddNewSOP() {
    Get.to(() => AddNewSopScreen(title: "Add New SOP"));
  }

  /// View SOP details
  void onViewSOP(SOPModel sop) {
    // Pass the SOP ID for API integration
    _logger.i('Viewing SOP with ID: ${sop.id}');
    Get.to(() => DetailsViewScreen(sopId: sop.id));
  }

  /// Edit SOP
  void onEditSOP(SOPModel sop) {
    // Pass the SOP data for editing
    _logger.i('Editing SOP with ID: ${sop.id}');
    Get.to(() => AddNewSopScreen(title: "Edit SOP", sopData: sop));
  }

  /// Delete SOP with confirmation
  void onDeleteSOP(SOPModel sop) {
    Get.dialog(
      AlertDialog(
        title: const Text('Delete SOP'),
        content: Text(
          'Are you sure you want to delete "${sop.title}"?\n\nThis action cannot be undone.',
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        actions: [
          TextButton(
            onPressed: () {
              if (Get.isDialogOpen ?? false) {
                Get.back(); // Close dialog
              }
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              // Close dialog first
              if (Get.isDialogOpen ?? false) {
                Get.back();
              }
              // Wait a bit to ensure dialog is fully closed
              await Future.delayed(const Duration(milliseconds: 150));
              // Then delete the SOP
              _deleteSOPFromAPI(sop);
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
      barrierDismissible: true,
    );
  }

  /// Delete SOP from API
  Future<void> _deleteSOPFromAPI(SOPModel sop) async {
    try {
      final response = await NetworkCaller.deleteRequest(
        endpoint: '$deleteSOPEndpoint/${sop.id}',
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        // Remove from local list
        final index = sops.indexWhere((item) => item.id == sop.id);
        if (index != -1) {
          sops.removeAt(index);
          filterSOPs();
        }

        _logger.i('SOP deleted successfully: ${sop.id}');
        Get.snackbar(
          'Success',
          'SOP "${sop.title}" deleted successfully',
          backgroundColor: const Color(0xFFE6F4EF),
          colorText: const Color(0xFF048E5C),
        );
      } else {
        throw Exception('Failed to delete SOP: ${response.statusCode}');
      }
    } catch (error) {
      _logger.e('Error deleting SOP: $error');
      Get.snackbar(
        'Error',
        'Failed to delete SOP. Please try again.',
        backgroundColor: const Color(0xFFF8E7D4),
        colorText: const Color(0xFFDB7906),
      );
    }
  }

  /// Get available jurisdictions for filter dropdown
  List<String> getAvailableJurisdictions() {
    final Set<String> jurisdictions = {'All'};
    for (final sop in sops) {
      jurisdictions.addAll(sop.jurisdiction);
    }
    final result = jurisdictions.toList();
    _logger.i('Getting available jurisdictions: $result');
    return result;
  }

  /// Get available statuses for filter dropdown
  List<String> getAvailableStatuses() {
    return ['All', 'Published', 'Draft'];
  }

  @override
  void onClose() {
    searchController.dispose();
    jurisdictionController.dispose();
    statusController.dispose();
    super.onClose();
  }
}
