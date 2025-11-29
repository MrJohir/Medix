import 'dart:convert';
import 'package:dermaininstitute/core/api_service/NetworkCaller.dart';
import 'package:dermaininstitute/core/utils/constants/api_constants.dart';
import 'package:dermaininstitute/features/admin_flow/sops_section/sops/model/sop_model.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

/// Controller for managing the state of the Details View Screen
/// This follows the GetX MVC pattern for reactive state management
/// Integrates with real API to fetch SOP details by ID
class DetailsViewController extends GetxController {
  final Logger _logger = Logger();

  /// Observable variables for reactive UI updates
  final Rx<SOPModel?> sopDetails = Rx<SOPModel?>(null);
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxString sopId = ''.obs;

  /// Getters for accessing reactive data
  SOPModel? get sop => sopDetails.value;
  bool get loading => isLoading.value;
  String get error => errorMessage.value;

  // Convenience getters that safely access SOP data
  String get sopTitle => sop?.title ?? '';
  String get sopAuthor => sop?.author ?? '';
  String get sopDate => sop?.formattedDate ?? '';
  String get sopCategory => sop?.status ?? '';
  String get sopCreatedDate => sop?.formattedDate ?? '';
  String get criticalStatus => sop?.priority ?? '';
  String get publishedStatus => sop?.isDraft ?? '';
  List<String> get jurisdictions => sop?.jurisdiction ?? [];
  String get overview => sop?.overview ?? '';
  List<String> get indications => sop?.indications ?? [];
  List<String> get contraindications => sop?.contraindications ?? [];
  List<String> get requiredEquipment => sop?.requiredEquipment ?? [];
  List<ProtocolStep> get protocolSteps => sop?.protocolSteps ?? [];
  List<Medication> get medications => sop?.medications ?? [];
  Oxygen? get oxygen => sop?.oxygen;

  /// Initialize controller with SOP ID and load data
  void initializeWithSopId(String id) {
    sopId.value = id;
    loadSOPDetails();
  }


  /// Load SOP details from API using the provided ID
  Future<void> loadSOPDetails() async {
    if (sopId.value.isEmpty) {
      errorMessage.value = 'Invalid SOP ID';
      return;
    }

    try {
      isLoading.value = true;
      errorMessage.value = '';

      _logger.i('Loading SOP details for ID: ${sopId.value}');

      // Make API call to get SOP details
      final response = await NetworkCaller.getRequest(
        endpoint: '$getSOPByIdEndpoint/${sopId.value}',
      );

      _logger.i('Response status: ${response.statusCode}');
      _logger.i('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);

        // Parse the SOP model from API response
        final sopModel = SOPModel.fromJson(jsonData);
        sopDetails.value = sopModel;

        _logger.i('Successfully loaded SOP: ${sopModel.title}');
      } else {
        throw Exception(
          'Failed to load SOP details. Status: ${response.statusCode}',
        );
      }
    } catch (e) {
      _logger.e('Error loading SOP details: $e');
      errorMessage.value = 'Failed to load SOP details: ${e.toString()}';
      sopDetails.value = null;
    } finally {
      isLoading.value = false;
    }
  }

  /// Handle refresh action
  Future<void> refreshData() async {
    await loadSOPDetails();
  }

  /// Get status color based on status type
  String getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'critical':
      case 'high_priority':
        return 'Red';
      case 'published':
      case 'procedure':
        return 'Green';
      case 'draft':
      case 'medium_priority':
        return 'Yellow';
      case 'low_priority':
        return 'Blue';
      default:
        return 'Blue';
    }
  }

  /// Format indications list for display
  String get formattedIndications {
    if (indications.isEmpty) return 'No indications available';
    return indications.join('\n');
  }

  /// Format contraindications list for display
  String get formattedContraindications {
    if (contraindications.isEmpty) return 'No contraindications available';
    return contraindications.join('\n');
  }

  /// Format required equipment list for display
  String get formattedRequiredEquipment {
    if (requiredEquipment.isEmpty) return 'No equipment requirements available';
    return requiredEquipment.join('\n');
  }

  /// Convert protocol steps to map format for compatibility
  List<Map<String, String>> get protocolStepsMap {
    return protocolSteps
        .map(
          (step) => {
            'step': step.stepNumber.toString(),
            'title': step.title,
            'description': step.description,
            'timeframe': step.duration,
          },
        )
        .toList();
  }

  /// Convert medications to map format for compatibility
  List<Map<String, dynamic>> get medicationsMap {
    return medications
        .map(
          (med) => {
            'name': med.name,
            'dose': med.dose,
            'route': med.route,
            'repeat': med.repeat,
          },
        )
        .toList();
  }
}
