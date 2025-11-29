// ignore_for_file: library_prefixes

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import '../../../../../core/api_service/NetworkCaller.dart';
import '../../../../../core/utils/constants/api_constants.dart';
import '../../../sops_section/sops/model/sop_model.dart' as SopModels;
import '../models/add_sop_model.dart';
import '../models/simple_draft_sop_model.dart';
import '../../../../../core/services/local_data_service.dart';
import '../views/screens/draft_sop_list_screen.dart';
import '../../../sops_section/sops/controller/manage_sops_controller.dart';

class AddNewSopController extends GetxController {
  final Logger _logger = Logger();
  final GetStorage _storage = GetStorage();

  final sopTitleController = TextEditingController();
  final overviewController = TextEditingController();

  // loading state for API calls
  var isLoading = false.obs;

  // edit mode variables
  var isEditMode = false.obs;
  var editingSopId = ''.obs;

  // Dynamic text field lists for different sections
  var indicationsControllers = <TextEditingController>[].obs;
  var contraindicationsControllers = <TextEditingController>[].obs;
  var requiredEquipmentControllers = <TextEditingController>[].obs;

  // Protocol steps with multiple fields
  var protocolSteps = <Map<String, TextEditingController>>[].obs;

  // Medications with multiple fields
  var medications = <Map<String, TextEditingController>>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize with one field for each section
    addIndicationField();
    addContraindicationField();
    addRequiredEquipmentField();
    addProtocolStep();
    addMedication();
  }

  // indications section methods
  void addIndicationField() {
    indicationsControllers.add(TextEditingController());
  }

  void removeIndicationField(int index) {
    if (indicationsControllers.length > 1 && index > 0) {
      indicationsControllers[index].dispose();
      indicationsControllers.removeAt(index);
    }
  }

  // contraindications section methods
  void addContraindicationField() {
    contraindicationsControllers.add(TextEditingController());
  }

  void removeContraindicationField(int index) {
    if (contraindicationsControllers.length > 1 && index > 0) {
      contraindicationsControllers[index].dispose();
      contraindicationsControllers.removeAt(index);
    }
  }

  // required equipment section methods
  void addRequiredEquipmentField() {
    requiredEquipmentControllers.add(TextEditingController());
  }

  void removeRequiredEquipmentField(int index) {
    if (requiredEquipmentControllers.length > 1 && index > 0) {
      requiredEquipmentControllers[index].dispose();
      requiredEquipmentControllers.removeAt(index);
    }
  }

  // protocol steps section methods
  void addProtocolStep() {
    protocolSteps.add({
      'headline': TextEditingController(),
      'description': TextEditingController(),
      'duration': TextEditingController(),
    });
  }

  void removeProtocolStep(int index) {
    if (protocolSteps.length > 1 && index > 0) {
      protocolSteps[index]['headline']?.dispose();
      protocolSteps[index]['description']?.dispose();
      protocolSteps[index]['duration']?.dispose();
      protocolSteps.removeAt(index);
    }
  }

  // medications section methods
  void addMedication() {
    medications.add({
      'headline': TextEditingController(),
      'dose': TextEditingController(),
      'route': TextEditingController(),
      'repeat': TextEditingController(),
    });
  }

  void removeMedication(int index) {
    if (medications.length > 1 && index > 0) {
      medications[index]['headline']?.dispose();
      medications[index]['dose']?.dispose();
      medications[index]['route']?.dispose();
      medications[index]['repeat']?.dispose();
      medications.removeAt(index);
    }
  }

  // Jurisdiction Selection
  var selectedJurisdictions = <String>[].obs;

  final List<String> jurisdictions = [
    'United Kingdom',
    'United States',
    'Canada',
    'Australia',
    'Middle East',
    'New Zealand',
  ];
  void toggleJurisdiction(String jurisdiction) {
    if (selectedJurisdictions.contains(jurisdiction)) {
      selectedJurisdictions.remove(jurisdiction);
    } else {
      selectedJurisdictions.add(jurisdiction);
    }
  }

  // Tags Selection
  var selectedTags = <String>[].obs;

  final List<String> tags = [
    'Emergency',
    'Botulinum Toxin',
    'Allergic Reactions',
    'Dermal Fillers',
    'Anesthetics',
    'Vascular Complications',
    'Post-Procedure Care',
  ];
  void toggleTag(String tag) {
    if (selectedTags.contains(tag)) {
      selectedTags.remove(tag);
    } else {
      selectedTags.add(tag);
    }
  }

  // Settings
  var settingStatus = false.obs;
  void toggleSettingsValue(bool value) {
    settingStatus.value = value;
  }

  // Publication Status
  var publicationStatus = ''.obs;
  final List<String> publicationStatusOptions = ['Draft', 'Published'];

  // Priority
  var priority = ''.obs;
  final List<String> priorityOptions = [
    'High_Priority',
    'Medium_Priority',
    'Low_Priority',
  ];

  void onCancel() {
    _clearForm();
    Get.back();
  }

  /// Validate form data before submission
  /// Uses different validation rules based on create vs edit mode
  bool _validateForm() {
    if (isEditMode.value) {
      return _validateFormForEdit();
    } else {
      return _validateFormForCreate();
    }
  }

  /// Strict validation for creating new SOPs (all fields required)
  bool _validateFormForCreate() {
    // validate SOP title
    if (sopTitleController.text.trim().isEmpty) {
      EasyLoading.showError('Please enter SOP title');
      return false;
    }

    // validate jurisdictions
    if (selectedJurisdictions.isEmpty) {
      EasyLoading.showError('Please select at least one jurisdiction');
      return false;
    }

    // validate tags
    if (selectedTags.isEmpty) {
      EasyLoading.showError('Please select at least one tag');
      return false;
    }

    // validate overview
    if (overviewController.text.trim().isEmpty) {
      EasyLoading.showError('Please enter SOP overview');
      return false;
    }

    // validate indications - at least one non-empty field required
    bool hasValidIndication = indicationsControllers.any(
      (controller) => controller.text.trim().isNotEmpty,
    );
    if (!hasValidIndication) {
      EasyLoading.showError('Please enter at least one indication');
      return false;
    }

    // validate contraindications - at least one non-empty field required
    bool hasValidContraindication = contraindicationsControllers.any(
      (controller) => controller.text.trim().isNotEmpty,
    );
    if (!hasValidContraindication) {
      EasyLoading.showError('Please enter at least one contraindication');
      return false;
    }

    // validate required equipment - at least one non-empty field required
    bool hasValidEquipment = requiredEquipmentControllers.any(
      (controller) => controller.text.trim().isNotEmpty,
    );
    if (!hasValidEquipment) {
      EasyLoading.showError('Please enter at least one required equipment');
      return false;
    }

    // validate protocol steps - at least one complete step required
    bool hasValidProtocolStep = false;
    for (var step in protocolSteps) {
      final title = step['headline']?.text.trim() ?? '';
      final description = step['description']?.text.trim() ?? '';
      final duration = step['duration']?.text.trim() ?? '';

      if (title.isNotEmpty && description.isNotEmpty && duration.isNotEmpty) {
        hasValidProtocolStep = true;
        break;
      }
    }
    if (!hasValidProtocolStep) {
      EasyLoading.showError(
        'Please enter at least one complete protocol step (title, description, and duration)',
      );
      return false;
    }

    // validate medications - at least one complete medication required
    bool hasValidMedication = false;
    for (var medication in medications) {
      final name = medication['headline']?.text.trim() ?? '';
      final dose = medication['dose']?.text.trim() ?? '';
      final route = medication['route']?.text.trim() ?? '';
      final repeat = medication['repeat']?.text.trim() ?? '';

      if (name.isNotEmpty &&
          dose.isNotEmpty &&
          route.isNotEmpty &&
          repeat.isNotEmpty) {
        hasValidMedication = true;
        break;
      }
    }
    if (!hasValidMedication) {
      EasyLoading.showError(
        'Please enter at least one complete medication (name, dose, route, and repeat)',
      );
      return false;
    }

    // validate publication status
    if (publicationStatus.value.isEmpty) {
      EasyLoading.showError('Please select publication status');
      return false;
    }

    // validate priority
    if (priority.value.isEmpty) {
      EasyLoading.showError('Please select priority');
      return false;
    }

    return true;
  }

  /// Relaxed validation for editing SOPs (all fields optional, only basic checks)
  bool _validateFormForEdit() {
    // Only validate SOP title if it's provided (basic requirement for identification)
    if (sopTitleController.text.trim().isEmpty) {
      EasyLoading.showError('SOP title cannot be empty');
      return false;
    }

    // All other fields are optional during edit
    // Only validate structure if fields are provided

    // If protocol steps are provided, ensure they have at least title
    for (var step in protocolSteps) {
      final title = step['headline']?.text.trim() ?? '';
      final description = step['description']?.text.trim() ?? '';
      final duration = step['duration']?.text.trim() ?? '';

      // If any field is filled, validate structure
      if (title.isNotEmpty || description.isNotEmpty || duration.isNotEmpty) {
        if (title.isEmpty) {
          EasyLoading.showError(
            'Protocol step title is required when adding step details',
          );
          return false;
        }
      }
    }

    // If medications are provided, ensure they have at least name
    for (var medication in medications) {
      final name = medication['headline']?.text.trim() ?? '';
      final dose = medication['dose']?.text.trim() ?? '';
      final route = medication['route']?.text.trim() ?? '';
      final repeat = medication['repeat']?.text.trim() ?? '';

      // If any field is filled, validate structure
      if (name.isNotEmpty ||
          dose.isNotEmpty ||
          route.isNotEmpty ||
          repeat.isNotEmpty) {
        if (name.isEmpty) {
          EasyLoading.showError(
            'Medication name is required when adding medication details',
          );
          return false;
        }
      }
    }

    return true;
  }

  /// Convert form data to AddSopModel
  AddSopModel _createSopModel({required bool isDraft}) {
    // Get user info from storage
    final String author = _storage.read('userName') ?? 'Unknown User';

    // Prepare protocol steps
    final List<ProtocolStep> steps = [];
    for (int i = 0; i < protocolSteps.length; i++) {
      final step = protocolSteps[i];
      final title = step['headline']?.text.trim() ?? '';
      final description = step['description']?.text.trim() ?? '';
      final duration = step['duration']?.text.trim() ?? '';

      if (title.isNotEmpty) {
        steps.add(
          ProtocolStep(
            stepNumber: i + 1,
            title: title,
            description: description,
            duration: duration,
          ),
        );
      }
    }

    // Prepare medications
    final List<Medication> meds = [];
    for (final medication in medications) {
      final name = medication['headline']?.text.trim() ?? '';
      final dose = medication['dose']?.text.trim() ?? '';
      final route = medication['route']?.text.trim() ?? '';
      final repeat = medication['repeat']?.text.trim() ?? '';

      if (name.isNotEmpty) {
        meds.add(
          Medication(name: name, dose: dose, route: route, repeat: repeat),
        );
      }
    }

    return AddSopModel(
      title: sopTitleController.text.trim(),
      jurisdiction: selectedJurisdictions.toList(),
      tags: selectedTags.toList(),
      overview: overviewController.text.trim(),
      indications: indicationsControllers
          .map((c) => c.text.trim())
          .where((text) => text.isNotEmpty)
          .toList(),
      contraindications: contraindicationsControllers
          .map((c) => c.text.trim())
          .where((text) => text.isNotEmpty)
          .toList(),
      requiredEquipment: requiredEquipmentControllers
          .map((c) => c.text.trim())
          .where((text) => text.isNotEmpty)
          .toList(),
      status: settingStatus.value ? 'Emergence' : 'Procedure',
      priority: priority.value,
      isDraft: publicationStatus.value,
      author: author,
      protocolSteps: steps,
      medications: meds,
    );
  }

  /// Submit SOP data to API
  Future<void> _submitSop({required bool isDraft}) async {
    if (!_validateForm()) return;

    try {
      isLoading.value = true;
      EasyLoading.show(
        status: isDraft ? 'Saving as draft...' : 'Publishing SOP...',
      );

      final sopModel = _createSopModel(isDraft: isDraft);
      final response = await NetworkCaller.postRequest(
        endpoint: '/sop',
        body: sopModel.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        _logger.i('SOP created successfully: $responseData');

        EasyLoading.showSuccess(
          isDraft
              ? 'SOP saved as draft successfully!'
              : 'SOP published successfully!',
        );

        // Refresh the ManageSOPsController data before navigating back
        try {
          final manageSOPsController = Get.find<ManageSOPsController>();
          await manageSOPsController.refreshSOPs();
          _logger.i('ManageSOPsController refreshed after SOP creation');
        } catch (e) {
          _logger.w(
            'ManageSOPsController not found, data will refresh on next visit: $e',
          );
        }

        // Clear form and go back
        _clearForm();
        Get.back();
      } else {
        // Handle API error response
        final errorData = jsonDecode(response.body);
        String errorMessage;

        // Handle different types of error messages
        if (errorData['message'] is List) {
          errorMessage = (errorData['message'] as List).join(', ');
        } else if (errorData['message'] is String) {
          errorMessage = errorData['message'];
        } else {
          errorMessage = isDraft
              ? 'Failed to save SOP as draft'
              : 'Failed to publish SOP';
        }

        _logger.e('API Error: ${response.statusCode} - $errorMessage');
        EasyLoading.showError(errorMessage);
      }
    } catch (e) {
      _logger.e('Error submitting SOP: $e');
      EasyLoading.showError(e.toString());
    } finally {
      isLoading.value = false;
      EasyLoading.dismiss();
    }
  }

  /// Clear all form data
  void _clearForm() {
    sopTitleController.clear();
    overviewController.clear();

    // Clear dynamic fields
    for (var controller in indicationsControllers) {
      controller.clear();
    }
    for (var controller in contraindicationsControllers) {
      controller.clear();
    }
    for (var controller in requiredEquipmentControllers) {
      controller.clear();
    }

    // Clear protocol steps
    for (var step in protocolSteps) {
      step['headline']?.clear();
      step['description']?.clear();
      step['duration']?.clear();
    }

    // Clear medications
    for (var medication in medications) {
      medication['headline']?.clear();
      medication['dose']?.clear();
      medication['route']?.clear();
      medication['repeat']?.clear();
    }

    selectedJurisdictions.clear();
    selectedTags.clear();
    settingStatus.value = false;
    publicationStatus.value = '';
    priority.value = '';
  }

  /// Save SOP as draft to local database
  void onSaveAsDraft() async {
    if (!_validateForm()) return;

    // Check if publication status is set to Draft
    if (publicationStatus.value != 'Draft') {
      EasyLoading.showError(
        'Please select publication status as "Draft" to save as draft',
      );
      _logger.w(
        'Save as draft attempted with publication status: ${publicationStatus.value}',
      );
      return;
    }

    try {
      EasyLoading.show(status: 'Saving draft...');

      // Create draft SOP model from form data
      final draftSOP = _createDraftSOPModel();

      // Save to local database
      final saved = await LocalDataService.saveDraftSOP(draftSOP);

      if (saved) {
        EasyLoading.showSuccess('Draft saved successfully!');
        _logger.i('Draft SOP saved locally with ID: ${draftSOP.id}');

        // Clear form
        _clearForm();

        // Navigate to draft list screen
        Get.to(() => const DraftSOPListScreen());
      } else {
        EasyLoading.showError('Failed to save draft');
        _logger.e('Failed to save draft SOP locally');
      }
    } catch (e) {
      EasyLoading.showError('Error saving draft');
      _logger.e('Error saving draft SOP: $e');
    } finally {
      EasyLoading.dismiss();
    }
  }

  void onPublishSOP() {
    // Check if publication status is set to Published
    if (publicationStatus.value != 'Published') {
      EasyLoading.showError(
        'Please select publication status as "Published" to publish SOP',
      );
      _logger.w(
        'Publish SOP attempted with publication status: ${publicationStatus.value}',
      );
      return;
    }

    _submitSop(isDraft: false);
  }

  /// Initialize controller for edit mode with existing SOP data
  void initializeForEdit(SopModels.SOPModel sopData) {
    isEditMode.value = true;
    editingSopId.value = sopData.id;

    // Pre-populate basic information
    sopTitleController.text = sopData.title;
    overviewController.text = sopData.overview;

    // Pre-populate jurisdictions
    selectedJurisdictions.value = List.from(sopData.jurisdiction);

    // Pre-populate tags
    selectedTags.value = List.from(sopData.tags);

    // Pre-populate indications
    _populateTextFieldList(indicationsControllers, sopData.indications);

    // Pre-populate contraindications
    _populateTextFieldList(
      contraindicationsControllers,
      sopData.contraindications,
    );

    // Pre-populate required equipment
    _populateTextFieldList(
      requiredEquipmentControllers,
      sopData.requiredEquipment,
    );

    // Pre-populate protocol steps
    _populateProtocolSteps(sopData.protocolSteps);

    // Pre-populate medications
    _populateMedications(sopData.medications);

    // Pre-populate settings
    settingStatus.value = sopData.status == 'Emergence';
    publicationStatus.value = sopData.isDraft;
    priority.value = sopData.priority;

    _logger.i('Initialized controller for editing SOP: ${sopData.title}');
  }

  /// Helper method to populate text field controllers from string list
  void _populateTextFieldList(
    RxList<TextEditingController> controllers,
    List<String> data,
  ) {
    // Clear existing controllers
    for (var controller in controllers) {
      controller.dispose();
    }
    controllers.clear();

    // Add controllers with data
    if (data.isNotEmpty) {
      for (var item in data) {
        final controller = TextEditingController(text: item);
        controllers.add(controller);
      }
    } else {
      // Ensure at least one empty field
      controllers.add(TextEditingController());
    }
  }

  /// Helper method to populate protocol steps
  void _populateProtocolSteps(List<SopModels.ProtocolStep> steps) {
    // Clear existing protocol steps
    for (var step in protocolSteps) {
      step['headline']?.dispose();
      step['description']?.dispose();
      step['duration']?.dispose();
    }
    protocolSteps.clear();

    // Add protocol steps with data
    if (steps.isNotEmpty) {
      for (var step in steps) {
        protocolSteps.add({
          'headline': TextEditingController(text: step.title),
          'description': TextEditingController(text: step.description),
          'duration': TextEditingController(text: step.duration),
        });
      }
    } else {
      // Ensure at least one empty step
      addProtocolStep();
    }
  }

  /// Helper method to populate medications
  void _populateMedications(List<SopModels.Medication> meds) {
    // Clear existing medications
    for (var medication in medications) {
      medication['headline']?.dispose();
      medication['dose']?.dispose();
      medication['route']?.dispose();
      medication['repeat']?.dispose();
    }
    medications.clear();

    // Add medications with data
    if (meds.isNotEmpty) {
      for (var med in meds) {
        medications.add({
          'headline': TextEditingController(text: med.name),
          'dose': TextEditingController(text: med.dose),
          'route': TextEditingController(text: med.route),
          'repeat': TextEditingController(text: med.repeat),
        });
      }
    } else {
      // Ensure at least one empty medication
      addMedication();
    }
  }

  /// Update existing SOP
  void onUpdateSOP() {
    _updateSop();
  }

  /// Update SOP data via API
  Future<void> _updateSop() async {
    if (!_validateForm()) return;

    try {
      isLoading.value = true;
      EasyLoading.show(status: 'Updating SOP...');

      // Create update payload with proper structure for PATCH request
      final updatePayload = _createUpdatePayload();

      _logger.i('Update payload: ${jsonEncode(updatePayload)}');

      final response = await NetworkCaller.patchRequest(
        endpoint: '$updateSOPEndpoint/${editingSopId.value}',
        body: updatePayload,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        _logger.i('SOP updated successfully: $responseData');

        EasyLoading.showSuccess('SOP updated successfully!');

        await Future.delayed(const Duration(seconds: 1));

        // Clear form and navigate back
        _clearForm();

        // Refresh the ManageSOPsController data before navigating back
        try {
          final manageSOPsController = Get.find<ManageSOPsController>();
          await manageSOPsController.refreshSOPs();
          _logger.i('ManageSOPsController refreshed after SOP update');
        } catch (e) {
          _logger.w(
            'ManageSOPsController not found, data will refresh on next visit: $e',
          );
        }

        Get.back(); // Navigate back to previous screen
        Get.back(); // Navigate back to SOPs list if needed
      } else {
        final errorData = jsonDecode(response.body);
        final errorMessage = errorData['message'] ?? 'Failed to update SOP';
        _logger.e('API Error: ${response.statusCode} - $errorMessage');
        EasyLoading.showError(errorMessage);
      }
    } catch (e) {
      _logger.e('Error updating SOP: $e');
      EasyLoading.showError(e.toString());
    } finally {
      isLoading.value = false;
      EasyLoading.dismiss();
    }
  }

  /// Create update payload matching API expected format
  Map<String, dynamic> _createUpdatePayload() {
    // Get current author from storage or use default
    final storage = GetStorage();
    final firstName = storage.read('firstName') ?? 'Unknown';
    final lastName = storage.read('lastName') ?? 'User';
    final author = '$firstName $lastName';

    // Prepare protocol steps for update
    final List<Map<String, dynamic>> steps = [];
    for (int i = 0; i < protocolSteps.length; i++) {
      final step = protocolSteps[i];
      final title = step['headline']?.text.trim() ?? '';
      final description = step['description']?.text.trim() ?? '';
      final duration = step['duration']?.text.trim() ?? '';

      if (title.isNotEmpty) {
        steps.add({
          'stepNumber': i,
          'title': title,
          'description': description,
          'duration': duration,
        });
      }
    }

    // Prepare medications for update
    final List<Map<String, dynamic>> meds = [];
    for (final medication in medications) {
      final name = medication['headline']?.text.trim() ?? '';
      final dose = medication['dose']?.text.trim() ?? '';
      final route = medication['route']?.text.trim() ?? '';
      final repeat = medication['repeat']?.text.trim() ?? '';

      if (name.isNotEmpty) {
        meds.add({
          'name': name,
          'dose': dose,
          'route': route,
          'repeat': repeat,
        });
      }
    }

    return {
      'title': sopTitleController.text.trim(),
      'jurisdiction': selectedJurisdictions.toList(),
      'tags': selectedTags.toList(),
      'overview': overviewController.text.trim(),
      'indications': indicationsControllers
          .map((c) => c.text.trim())
          .where((text) => text.isNotEmpty)
          .toList(),
      'contraindications': contraindicationsControllers
          .map((c) => c.text.trim())
          .where((text) => text.isNotEmpty)
          .toList(),
      'required_equipment': requiredEquipmentControllers
          .map((c) => c.text.trim())
          .where((text) => text.isNotEmpty)
          .toList(),
      'status': settingStatus.value ? 'Emergence' : 'Procedure',
      'priority': priority.value,
      'isDraft': publicationStatus.value,
      'author': author,
      'protocolSteps': steps,
      'medications': meds,
      // Add oxygen if needed (currently not in form)
      'oxygen': {'dose': '', 'route': '', 'repeat': ''},
    };
  }

  /// Create draft SOP model from form data for local storage
  SimpleDraftSOPModel _createDraftSOPModel() {
    // Get current author from storage
    final String firstName = _storage.read('firstName') ?? 'Unknown';
    final String lastName = _storage.read('lastName') ?? 'User';
    final String author = '$firstName $lastName';

    // Convert protocol steps to simple format
    final List<Map<String, dynamic>> draftProtocolSteps = protocolSteps
        .where(
          (step) =>
              step['headline']?.text.trim().isNotEmpty == true ||
              step['description']?.text.trim().isNotEmpty == true,
        )
        .map(
          (step) => {
            'stepNumber': protocolSteps.indexOf(step) + 1,
            'title': step['headline']?.text.trim() ?? '',
            'description': step['description']?.text.trim() ?? '',
            'duration': step['duration']?.text.trim() ?? '',
          },
        )
        .toList();

    // Convert medications to simple format
    final List<Map<String, dynamic>> draftMedications = medications
        .where(
          (med) =>
              med['headline']?.text.trim().isNotEmpty == true ||
              med['dose']?.text.trim().isNotEmpty == true,
        )
        .map(
          (med) => {
            'name': med['headline']?.text.trim() ?? '',
            'dose': med['dose']?.text.trim() ?? '',
            'route': med['route']?.text.trim() ?? '',
            'repeat': med['repeat']?.text.trim() ?? '',
          },
        )
        .toList();

    return SimpleDraftSOPModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: sopTitleController.text.trim(),
      jurisdiction: selectedJurisdictions.toList(),
      tags: selectedTags.toList(),
      overview: overviewController.text.trim(),
      indications: indicationsControllers
          .map((c) => c.text.trim())
          .where((text) => text.isNotEmpty)
          .toList(),
      contraindications: contraindicationsControllers
          .map((c) => c.text.trim())
          .where((text) => text.isNotEmpty)
          .toList(),
      requiredEquipment: requiredEquipmentControllers
          .map((c) => c.text.trim())
          .where((text) => text.isNotEmpty)
          .toList(),
      status: settingStatus.value ? 'Emergence' : 'Procedure',
      priority: priority.value,
      publicationStatus: publicationStatus.value,
      author: author,
      protocolSteps: draftProtocolSteps,
      medications: draftMedications,
      settingStatus: settingStatus.value,
      createdAt: DateTime.now().toIso8601String(),
    );
  }

  @override
  void onClose() {
    sopTitleController.dispose();
    overviewController.dispose();

    // Dispose dynamic fields
    for (var controller in indicationsControllers) {
      controller.dispose();
    }
    for (var controller in contraindicationsControllers) {
      controller.dispose();
    }
    for (var controller in requiredEquipmentControllers) {
      controller.dispose();
    }

    // Dispose protocol steps
    for (var step in protocolSteps) {
      step['headline']?.dispose();
      step['description']?.dispose();
      step['duration']?.dispose();
    }

    // Dispose medications
    for (var medication in medications) {
      medication['headline']?.dispose();
      medication['dose']?.dispose();
      medication['route']?.dispose();
      medication['repeat']?.dispose();
    }

    super.onClose();
  }
}
