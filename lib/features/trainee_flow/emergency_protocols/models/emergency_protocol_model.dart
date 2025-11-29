class EmergencyProtocol {
  final String id;
  final String title;
  final String description;
  final String timeLimit;
  final bool isCompleted;
  final bool isUrgent;
  final List<String> steps;

  EmergencyProtocol({
    required this.id,
    required this.title,
    required this.description,
    required this.timeLimit,
    this.isCompleted = false,
    this.isUrgent = false,
    this.steps = const [],
  });

  // Factory constructor for API response
  factory EmergencyProtocol.fromJson(Map<String, dynamic> json) {
    return EmergencyProtocol(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      timeLimit: json['timeLimit'] ?? '',
      isCompleted: json['isCompleted'] ?? false,
      isUrgent: json['isUrgent'] ?? false,
      steps: List<String>.from(json['steps'] ?? []),
    );
  }

  // Convert to JSON for API request
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'timeLimit': timeLimit,
      'isCompleted': isCompleted,
      'isUrgent': isUrgent,
      'steps': steps,
    };
  }

  // Create a copy with updated fields
  EmergencyProtocol copyWith({
    String? id,
    String? title,
    String? description,
    String? timeLimit,
    bool? isCompleted,
    bool? isUrgent,
    List<String>? steps,
  }) {
    return EmergencyProtocol(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      timeLimit: timeLimit ?? this.timeLimit,
      isCompleted: isCompleted ?? this.isCompleted,
      isUrgent: isUrgent ?? this.isUrgent,
      steps: steps ?? this.steps,
    );
  }
}
