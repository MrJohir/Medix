class TriageMessage {
  final String id;
  final String message;
  final bool isFromUser;
  final DateTime timestamp;
  final String? messageType; // 'alert', 'info', 'user', 'assistant', 'image'
  final String? imagePath; // optional field for local image path or URL
  final bool complicationDetected;
  final String complicationName;

  TriageMessage({
    required this.id,
    required this.message,
    required this.isFromUser,
    required this.timestamp,
    this.messageType,
    this.imagePath,
    this.complicationDetected = false,
    this.complicationName = '',
  });

  // Factory constructor for API response
  factory TriageMessage.fromJson(Map<String, dynamic> json) {
    return TriageMessage(
      id: json['id'] ?? '',
      message: json['message'] ?? '',
      isFromUser: json['isFromUser'] ?? false,
      timestamp: DateTime.parse(
        json['timestamp'] ?? DateTime.now().toIso8601String(),
      ),
      messageType: json['messageType'],
      imagePath: json['imagePath'], // optional
      complicationDetected: json['complication_detected'] ?? false,
      complicationName: json['complication_name'] ?? '',
    );
  }

  // Convert to JSON for API request
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'message': message,
      'isFromUser': isFromUser,
      'timestamp': timestamp.toIso8601String(),
      'messageType': messageType,
      'imagePath': imagePath, // optional
      'complication_detected': complicationDetected,
      'complication_name': complicationName,
    };
  }
}
