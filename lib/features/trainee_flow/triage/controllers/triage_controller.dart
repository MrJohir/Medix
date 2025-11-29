import 'dart:io';
import 'dart:math';

import 'package:dermaininstitute/features/trainee_flow/triage/trainge_services/triange_services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'package:image_picker/image_picker.dart';
import 'package:dermaininstitute/features/trainee_flow/triage/models/triage_message_model.dart';

class TriageController extends GetxController {
  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final ImagePicker _picker = ImagePicker();

  ///image preview in textfield
  final Rx<File?> selectedImage = Rx<File?>(null);

  // Observable list of messages for real-time updates
  final RxList<TriageMessage> messages = <TriageMessage>[].obs;

  // Loading state for API calls
  final RxBool isLoading = false.obs;
  final RxBool isSendingMessage = false.obs;

  // User ID from storage or generate a temporary one
  // Correctly read userId from storage
  final box = GetStorage();
  late final String userId = box.read('userId') ?? '';
  // Chat ID for the current session
  final RxString chatId = "".obs;

  // conplecatede name
  final RxBool complicationDetected = false.obs;
  final RxString complicationName = "".obs;

  // Selected emergency protocol categories
  final RxList<String> selectedCategories = <String>[].obs;

  // Quick suggestion messages for emergency categories
  final Map<String, String> suggestionMessages = {
    'Anaphylaxis': 'Anaphylaxis',
    'Cardiac Emergency': 'Cardiac Emergency',
    'Respiratory Distress': 'Respiratory Distress',
  };

  // Protocol data from API
  final RxMap<String, dynamic> emargencyProtocolData = <String, dynamic>{}.obs;
  @override
  void onInit() {
    super.onInit();
    _initializeTriageSession();
  }

  @override
  void onClose() {
    messageController.dispose();
    scrollController.dispose();
    super.onClose();
  }

  // Generate random chat ID
  String _generateChatId() {
    final random = Random();
    return "${DateTime.now().millisecondsSinceEpoch}_${random.nextInt(10000)}";
  }

  // Initialize triage session with initial messages
  void _initializeTriageSession() {
    // Initialize chatId if empty
    if (chatId.value.isEmpty) {
      chatId.value = _generateChatId();
    }

    // Initialize messages array
    messages.addAll([]);

    // Initialize categories
    selectedCategories.addAll([
      'Anaphylaxis',
      'Cardiac Emergency',
      'Respiratory Distress',
    ]);
  }

  // Show camera options bottom sheet
  void showCameraOptions() {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Select Image Source',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => _pickImage(ImageSource.camera),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.camera_alt,
                            size: 32,
                            color: Colors.grey.shade600,
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Camera',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: GestureDetector(
                    onTap: () => _pickImage(ImageSource.gallery),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.photo_library,
                            size: 32,
                            color: Colors.grey.shade600,
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Gallery',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () => Get.back(),
              child: Text(
                'Cancel',
                style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.transparent,
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      Get.back(); // Close bottom sheet

      final XFile? image = await _picker.pickImage(
        source: source,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 80,
      );

      if (image != null) {
        selectedImage.value = File(image.path); // preview in textfield
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to capture image: $e',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  //send image message
  Future<void> sendMessageWithOptionalImage(String jurisdiction) async {
    final text = messageController.text.trim();
    final file = selectedImage.value;
    if (text.isEmpty && file == null) return; // nothing to send

    // Ensure we have a chat ID
    if (chatId.value.isEmpty) {
      chatId.value = _generateChatId();
      debugPrint("Generated new chatId: ${chatId.value}");
    }
    final currentChatId = chatId.value;

    // Add local user message
    final userMessage = TriageMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      message: text.isNotEmpty ? text : "📷 Image",
      isFromUser: true,
      timestamp: DateTime.now(),
      messageType: 'user',
      imagePath: file?.path,
    );
    messages.add(userMessage);
    messageController.clear();
    selectedImage.value = null;
    _scrollToBottom();

    // Add AI "loading"
    messages.add(
      TriageMessage(
        id: "loading_ai",
        message: "",
        isFromUser: false,
        timestamp: DateTime.now(),
        messageType: 'assistant',
      ),
    );
    _scrollToBottom();

    try {
      isLoading.value = true;
      final response = await TriageApiService.sendTriageMessage(
        query: text.isNotEmpty ? text : "Image uploaded",
        userId: userId,
        chatId: currentChatId,
        file: file,
        jurisdiction: jurisdiction,
      );
      // If user started a new chat in the meantime, ignore this response
      if (currentChatId != chatId.value) {
        isSendingMessage.value = false;
        return;
      }
      // Remove loading
      messages.removeWhere((msg) => msg.id == "loading_ai");

      // Add AI reply
      final aiText = response["response"] ?? "AI processed your input";
      messages.add(
        TriageMessage(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          message: aiText,
          isFromUser: false,
          timestamp: DateTime.now(),
          messageType: 'assistant',
          complicationDetected: response["complication_detected"] ?? false,
        ),
      );
      _scrollToBottom();

      // ✅ Check for complication

      complicationDetected.value = response["complication_detected"] ?? false;
      complicationName.value = response["complication_name"] ?? "";

      // Optional: You can store in controller to use in UI
      // this.complicationDetected.value = complicationDetected;
      // this.complicationName.value = complicationName;
    } catch (e) {
      messages.removeWhere((msg) => msg.id == "loading_ai");
      Get.snackbar("Error", "Failed to send: $e");
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  // Send message to API and get response
  Future<void> sendMessage(String message, String jurisdiction) async {
    if (message.trim().isEmpty) return;

    final currentChatId = chatId.value; // store current chatId
    isSendingMessage.value = true;

    try {
      // Add user message
      final userMessage = TriageMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        message: message.trim(),
        isFromUser: true,
        timestamp: DateTime.now(),
        messageType: 'user',
      );
      messages.add(userMessage);
      messageController.clear();
      _scrollToBottom();

      // Add loading AI message
      final loadingMessage = TriageMessage(
        id: "loading_ai",
        message: "",
        isFromUser: false,
        timestamp: DateTime.now(),
        messageType: 'assistant',
      );
      messages.add(loadingMessage);
      _scrollToBottom();

      // Call API
      final response = await TriageApiService.sendTriageMessage(
        query: message.trim(),
        userId: userId,
        chatId: currentChatId,
        jurisdiction: jurisdiction,
      );

      // If user started a new chat in the meantime, ignore this response
      if (currentChatId != chatId.value) {
        isSendingMessage.value = false;
        return;
      }

      messages.removeWhere((msg) => msg.id == "loading_ai");

      String aiText = "";

      // Handle chat_history if provided
      if (response.containsKey("chat_history")) {
        final chatHistory = response["chat_history"];
        if (chatHistory is List && chatHistory.isNotEmpty) {
          final latest = chatHistory.last;
          aiText = latest["content"] ?? "";
        }
      }

      // Handle direct response key (your backend)
      if (aiText.isEmpty && response.containsKey("response")) {
        aiText = response["response"] ?? "";
      }

      // Only add if not empty
      if (aiText.isNotEmpty) {
        final aiMessage = TriageMessage(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          message: aiText,
          isFromUser: false,
          timestamp: DateTime.now(),
          messageType: 'assistant',
        );
        messages.add(aiMessage);
        _scrollToBottom();
      }
    } catch (e) {
      messages.removeWhere((msg) => msg.id == "loading_ai");
      Get.snackbar(
        'Error',
        'Failed to send message: $e',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isSendingMessage.value = false;
    }
  }

  // Handle suggestion click - send predefined message
  Future<void> handleSuggestionClick(String category) async {
    final suggestionMessage = suggestionMessages[category];
    if (suggestionMessage != null) {
      await sendMessage(suggestionMessage, "");
    }
  }

  // Navigate to Emergency Protocols
  void navigateToEmergencyProtocols() {
    Get.toNamed('/emergencyProtocolsScreen');
  }

  // Add emergency category
  void toggleCategory(String category) {
    if (selectedCategories.contains(category)) {
      selectedCategories.remove(category);
    } else {
      selectedCategories.add(category);
    }
  }

  Future<void> callEmergencyProtocol(String jurisdiction) async {
    try {
      isLoading.value = true;
      EasyLoading.show(status: 'Calling emergency protocol...');
      final response = await TriageApiService.callEmergencyProtocol(
        userId: userId,
        chatId: chatId.value,
        jurisdiction: jurisdiction,
        detectedComplication: complicationName.value.isNotEmpty
            ? complicationName.value
            : "Unknown",
      );

      // Handle API response structure: {statusCode, success, message, data}
      if (response['data'] != null) {
        emargencyProtocolData.value =
            response['data']; // store data from response
      } else {
        // If data is null, show error
        Get.snackbar(
          "Error",
          response['message'] ?? "No emergency protocol data available",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        emargencyProtocolData.value = {};
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
      EasyLoading.dismiss();
    }
  }

  // Scroll to bottom of chat
  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  // Clear all messages
  void clearMessages() {
    messages.clear();
  }

  // Refresh triage session
  Future<void> refreshTriageSession() async {
    isLoading.value = true;
    try {
      clearMessages();
      _initializeTriageSession();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to refresh session: $e',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void startNewChat() {
    // generate fresh chatId
    chatId.value = _generateChatId();

    // clear messages
    clearMessages();

    // re-init categories / setup
    _initializeTriageSession();
  }
}
