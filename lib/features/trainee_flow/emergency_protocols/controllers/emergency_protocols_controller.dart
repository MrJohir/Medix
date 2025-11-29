import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:dermaininstitute/features/trainee_flow/emergency_protocols/models/emergency_protocol_model.dart';

class EmergencyProtocolsController extends GetxController {
  // Observable list of protocols for real-time updates
  final RxList<EmergencyProtocol> protocols = <EmergencyProtocol>[].obs;

  // Loading state for API calls
  final RxBool isLoading = false.obs;

  // Progress tracking
  final RxInt completedProtocols = 0.obs;
  final RxInt totalProtocols = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _initializeProtocols();
  }

  // Initialize protocols with sample data - Replace with API call
  void _initializeProtocols() {
    protocols.addAll([
      EmergencyProtocol(
        id: '1',
        title: 'Assess Airway, Breathing, Circulation',
        description: 'Check patient responsiveness and vital signs. Look for signs of respiratory distress, check pulse, and assess circulation.',
        timeLimit: 'Complete within 30 seconds',
        isCompleted: false,
        isUrgent: true,
      ),
      EmergencyProtocol(
        id: '2',
        title: 'Remove/Stop Trigger',
        description: 'If known allergen is still present, remove it immediately. Stop any ongoing procedures or medication administration.',
        timeLimit: 'Complete within 1 minute',
        isCompleted: true,
        isUrgent: false,
      ),
      EmergencyProtocol(
        id: '3',
        title: 'Administer Epinephrine',
        description: 'Give epinephrine 0.3-0.5mg IM into anterolateral thigh. Use auto-injector if available.',
        timeLimit: 'Complete within 2 minutes',
        isCompleted: true,
        isUrgent: true,
      ),
      EmergencyProtocol(
        id: '4',
        title: 'Call Emergency Services',
        description: 'Call 911/999 immediately. Inform them of anaphylaxis and current treatment given.',
        timeLimit: 'Complete within 30 seconds',
        isCompleted: true,
        isUrgent: false,
      ),
      EmergencyProtocol(
        id: '5',
        title: 'Position Patient',
        description: 'Place patient supine with legs elevated (unless breathing difficulties, then semi-upright).',
        timeLimit: '',
        isCompleted: true,
        isUrgent: false,
      ),
      EmergencyProtocol(
        id: '6',
        title: 'Administer Oxygen',
        description: 'Give high-flow oxygen if available (15L/min via non-rebreather mask).',
        timeLimit: '',
        isCompleted: false,
        isUrgent: false,
      ),
      EmergencyProtocol(
        id: '7',
        title: 'IV Access & Fluids',
        description: 'Establish IV access if possible. Give IV normal saline if hypotensive.',
        timeLimit: '',
        isCompleted: false,
        isUrgent: false,
      ),
      EmergencyProtocol(
        id: '8',
        title: 'Monitor & Reassess',
        description: 'Continuously monitor vital signs. Prepare for second dose of epinephrine if no improvement in 5-15 minutes.',
        timeLimit: '',
        isCompleted: false,
        isUrgent: false,
      ),
    ]);

    _updateProgress();
  }

  // Toggle protocol completion status
  void toggleProtocolCompletion(String protocolId) {
    final protocolIndex = protocols.indexWhere((p) => p.id == protocolId);
    if (protocolIndex != -1) {
      final protocol = protocols[protocolIndex];
      protocols[protocolIndex] = protocol.copyWith(
        isCompleted: !protocol.isCompleted,
      );
      _updateProgress();

      // Todo: Send completion status to API
      _updateProtocolStatusOnServer(protocolId, protocols[protocolIndex].isCompleted);
    }
  }

  // Update progress counters
  void _updateProgress() {
    completedProtocols.value = protocols.where((p) => p.isCompleted).length;
    totalProtocols.value = protocols.length;
  }

  // API call to update protocol status on server
  Future<void> _updateProtocolStatusOnServer(String protocolId, bool isCompleted) async {
    try {
      // Todo: Replace with actual API call
      // await apiService.updateProtocolStatus(protocolId, isCompleted);
      debugPrint('Updated protocol $protocolId status to $isCompleted');
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to update protocol status: ${e.toString()}',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // Refresh protocols from API
  Future<void> refreshProtocols() async {
    isLoading.value = true;
    try {
      // Todo: Replace with actual API call
      // final response = await apiService.getEmergencyProtocols();
      // protocols.value = response.map((json) => EmergencyProtocol.fromJson(json)).toList();

      await Future.delayed(Duration(seconds: 1)); // Simulate API delay
      _updateProgress();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to refresh protocols: ${e.toString()}',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Get progress percentage
  double get progressPercentage {
    if (totalProtocols.value == 0) return 0.0;
    return completedProtocols.value / totalProtocols.value;
  }

  // Reset all protocols (for new emergency)
  void resetAllProtocols() {
    for (int i = 0; i < protocols.length; i++) {
      protocols[i] = protocols[i].copyWith(isCompleted: false);
    }
    _updateProgress();
  }
}
