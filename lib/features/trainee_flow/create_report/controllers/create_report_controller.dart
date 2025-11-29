import 'package:dermaininstitute/features/trainee_flow/create_report/models/create_report_model.dart';
import 'package:dermaininstitute/features/trainee_flow/create_report/models/simple_draft_report_model.dart';
import 'package:dermaininstitute/features/trainee_flow/create_report/controllers/save_as_draft_controller.dart';
import 'package:dermaininstitute/core/api_service/NetworkCaller.dart';
import 'package:dermaininstitute/core/utils/constants/api_constants.dart';
import 'package:dermaininstitute/core/services/local_data_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:logger/logger.dart';
import 'dart:convert';

class CreateReportController extends GetxController {
  final Logger _logger = Logger();
  final GetStorage _storage = GetStorage();

  // Form key for validation
  final formKey = GlobalKey<FormState>();

  // Draft controller for local storage
  late final SaveAsDraftController draftController;

  // Text editing controllers
  final incidentTitleController = TextEditingController();
  final patientAgeController = TextEditingController();
  final incidentDescriptionController = TextEditingController();
  final actionsTakenController = TextEditingController();
  final outcomeController = TextEditingController();
  final lessonsLearnedController = TextEditingController();

  // Dropdown values
  final RxString selectedProcedure = ''.obs;
  final RxString selectedSeverity = ''.obs;
  final RxString selectedPatientSex = ''.obs;

  // Loading states
  final RxBool isSavingDraft = false.obs;
  final RxBool isSubmitting = false.obs;

  // Draft data loaded state
  final RxBool isDraftDataLoaded = false.obs;

  // Dropdown options
  final List<String> procedureOptions = [
    'Botulinum Toxin Injection',
    'Dermal Filler Injection',
    'Chemical Peel',
    'Laser Treatment',
    'Other',
  ];

  final List<String> severityOptions = ['Low', 'Medium', 'High', 'Critical'];

  final List<String> sexOptions = [
    'Male',
    'Female',
    'Other',
    'Prefer not to say',
  ];

  @override
  void onInit() {
    super.onInit();
    // Initialize draft controller
    draftController = Get.put(SaveAsDraftController());

    // Load draft data if exists
    _loadDraftDataIfExists();
  }

  @override
  void onClose() {
    // Dispose controllers
    incidentTitleController.dispose();
    patientAgeController.dispose();
    incidentDescriptionController.dispose();
    actionsTakenController.dispose();
    outcomeController.dispose();
    lessonsLearnedController.dispose();
    super.onClose();
  }

  // Update dropdown values
  void updateProcedure(String value) {
    selectedProcedure.value = value;
  }

  void updateSeverity(String value) {
    selectedSeverity.value = value;
  }

  void updatePatientSex(String value) {
    selectedPatientSex.value = value;
  }

  // Create report model from form data
  CreateReportModel _createReportModel() {
    return CreateReportModel(
      incidentTitle: incidentTitleController.text.trim(),
      procedure: selectedProcedure.value,
      severity: selectedSeverity.value,
      patientAge: patientAgeController.text.trim(),
      patientSex: selectedPatientSex.value,
      incidentDescription: incidentDescriptionController.text.trim(),
      actionsTaken: actionsTakenController.text.trim(),
      outcome: outcomeController.text.trim(),
      lessonsLearned: lessonsLearnedController.text.trim(),
    );
  }

  /// Create draft report model from form data for local storage
  SimpleDraftReportModel _createDraftReportModel() {
    // Get current author from storage
    final String firstName = _storage.read('firstName') ?? 'Unknown';
    final String lastName = _storage.read('lastName') ?? 'User';
    final String author = '$firstName $lastName';

    return SimpleDraftReportModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      incidentTitle: incidentTitleController.text.trim(),
      procedure: selectedProcedure.value,
      severity: selectedSeverity.value,
      patientAge: patientAgeController.text.trim(),
      patientSex: selectedPatientSex.value,
      incidentDescription: incidentDescriptionController.text.trim(),
      actionsTaken: actionsTakenController.text.trim(),
      outcome: outcomeController.text.trim(),
      lessonsLearned: lessonsLearnedController.text.trim(),
      author: author,
      createdAt: DateTime.now().toIso8601String(),
    );
  }

  // Validate form
  bool validateForm() {
    if (!formKey.currentState!.validate()) {
      return false;
    }

    // Additional validation for dropdowns
    if (selectedProcedure.value.isEmpty) {
      EasyLoading.showError('Please select a procedure');
      return false;
    }

    if (selectedSeverity.value.isEmpty) {
      EasyLoading.showError('Please select severity level');
      return false;
    }

    if (selectedPatientSex.value.isEmpty) {
      EasyLoading.showError('Please select patient sex');
      return false;
    }

    return true;
  }

  /// Load draft data from local storage if it exists
  void _loadDraftDataIfExists() {
    try {
      final draftData = draftController.loadDraftData();

      if (draftData != null) {
        // Populate text controllers
        incidentTitleController.text = draftData.incidentTitle ?? '';
        patientAgeController.text = draftData.patientAge ?? '';
        incidentDescriptionController.text =
            draftData.incidentDescription ?? '';
        actionsTakenController.text = draftData.actionsTaken ?? '';
        outcomeController.text = draftData.outcome ?? '';
        lessonsLearnedController.text = draftData.lessonsLearned ?? '';

        // Populate dropdown values
        selectedProcedure.value = draftData.procedure ?? '';
        selectedSeverity.value = draftData.severity ?? '';
        selectedPatientSex.value = draftData.patientSex ?? '';

        isDraftDataLoaded.value = true;

        debugPrint('Draft data loaded and populated in form');
      }
    } catch (e) {
      debugPrint('Error loading draft data: $e');
    }
  }

  // Save as draft - Updated to use LocalDataService
  Future<void> saveAsDraft() async {
    if (!validateForm()) return;

    try {
      EasyLoading.show(status: 'Saving draft...');
      isSavingDraft.value = true;

      // Create draft report model from form data
      final draftReport = _createDraftReportModel();

      // Save to local database
      final saved = await LocalDataService.saveDraftReport(draftReport);

      if (saved) {
        EasyLoading.showSuccess('Draft saved successfully!');
        _logger.i('Draft report saved locally with ID: ${draftReport.id}');

        // Clear form
        _clearAllFormData();

        // Navigate to draft reports screen
        Get.toNamed('/draft-reports');
      } else {
        EasyLoading.showError('Failed to save draft');
        _logger.e('Failed to save draft report locally');
      }
    } catch (e) {
      EasyLoading.showError('Error saving draft');
      _logger.e('Error saving draft report: $e');
    } finally {
      isSavingDraft.value = false;
      EasyLoading.dismiss();
    }
  }

  // Submit report - API integration with NetworkCaller
  Future<void> submitReport() async {
    if (!validateForm()) return;

    try {
      // Show loading
      EasyLoading.show(status: 'Submitting report...');
      isSubmitting.value = true;

      final reportModel = _createReportModel();

      // Call API using NetworkCaller
      final response = await NetworkCaller.postRequest(
        endpoint: createReportEndpoint,
        body: reportModel.toJson(),
      );

      // Check response status
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Parse response if needed
        final responseData = jsonDecode(response.body);
        debugPrint('Report created successfully: ${responseData['id']}');

        // Clear draft data after successful submission
        await draftController.clearDraftData();

        // Clear all form fields and reset state
        _clearAllFormData();

        // Hide loading and show success
        EasyLoading.dismiss();
        EasyLoading.showSuccess('Report submitted successfully');

        // Navigate back to previous screen and refresh
        Get.back(result: true); // Pass true to indicate success
      } else {
        // Handle error response
        final errorData = jsonDecode(response.body);
        String errorMessage = 'Failed to submit report';

        // Handle both string and array error messages
        if (errorData['message'] != null) {
          if (errorData['message'] is List) {
            // If message is an array, join the messages
            final messages = errorData['message'] as List;
            errorMessage = messages.join(', ');
          } else {
            // If message is a string
            errorMessage = errorData['message'];
          }
        }

        EasyLoading.dismiss();
        EasyLoading.showError(errorMessage);
      }
    } catch (e) {
      debugPrint('Error submitting report: $e');

      EasyLoading.dismiss();
      EasyLoading.showError('Failed to submit report. Please try again.');
    } finally {
      isSubmitting.value = false;
    }
  }

  /// Auto-save draft data when user makes changes
  void autoSaveDraft() {
    if (!isDraftDataLoaded.value && _isFormEmpty()) return;

    final reportModel = _createReportModel();
    draftController.autoSaveDraft(reportModel);
  }

  /// Check if form is empty
  bool _isFormEmpty() {
    return incidentTitleController.text.trim().isEmpty &&
        patientAgeController.text.trim().isEmpty &&
        incidentDescriptionController.text.trim().isEmpty &&
        actionsTakenController.text.trim().isEmpty &&
        outcomeController.text.trim().isEmpty &&
        lessonsLearnedController.text.trim().isEmpty &&
        selectedProcedure.value.isEmpty &&
        selectedSeverity.value.isEmpty &&
        selectedPatientSex.value.isEmpty;
  }

  /// Clear all form data and reset state
  void _clearAllFormData() {
    incidentTitleController.clear();
    patientAgeController.clear();
    incidentDescriptionController.clear();
    actionsTakenController.clear();
    outcomeController.clear();
    lessonsLearnedController.clear();
    selectedProcedure.value = '';
    selectedSeverity.value = '';
    selectedPatientSex.value = '';
    isDraftDataLoaded.value = false;
  }
}
