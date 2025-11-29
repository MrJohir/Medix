// lib/features/trainee_flow/reports/models/incident_model.dart
enum Priority { all, low, medium, high, critical }

enum Status { submitted, completed }

class IncidentModel {
  final String id;
  final String title;
  final String description;
  final String procedure;
  final Priority priority;
  final Status status;
  final DateTime dateTime;
  final String patientSex;

  IncidentModel({
    required this.id,
    required this.title,
    required this.description,
    required this.procedure,
    required this.priority,
    required this.status,
    required this.dateTime,
    required this.patientSex,
  });

  factory IncidentModel.fromJson(Map<String, dynamic> jsonData) {
    return IncidentModel(
      id: jsonData['id'] ?? '',
      title: jsonData['title'] ?? '',
      description: jsonData['description'] ?? '',
      procedure: jsonData['procedure'] ?? '',
      patientSex: jsonData['patientSex'] ?? '',
      priority: _parsePriority(jsonData['priority']),
      status: Status.values.firstWhere(
        (s) => s.name.toLowerCase() == jsonData['status']?.toLowerCase(),
        orElse: () => Status.submitted,
      ),
      dateTime: DateTime.tryParse(jsonData['dateTime'] ?? '') ?? DateTime.now(),
    );
  }

  /// Parse priority from API response with proper case handling
  static Priority _parsePriority(dynamic priorityData) {
    if (priorityData == null) return Priority.low;

    final priorityString = priorityData.toString().toLowerCase();

    switch (priorityString) {
      case 'low':
        return Priority.low;
      case 'medium':
        return Priority.medium;
      case 'high':
        return Priority.high;
      case 'critical':
        return Priority.critical;
      default:
        return Priority.low;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'procedure': procedure,
      'priority': priority.name,
      'status': status.name,
      'patientSex': patientSex,
      'dateTime': dateTime.toIso8601String(),
    };
  }
}

extension PriorityExtension on Priority {
  String get displayName {
    switch (this) {
      case Priority.all:
        return 'All';
      case Priority.low:
        return 'Low';
      case Priority.medium:
        return 'Medium';
      case Priority.high:
        return 'High';
      case Priority.critical:
        return 'Critical';
    }
  }
}

extension StatusExtension on Status {
  String get displayName {
    switch (this) {
      case Status.submitted:
        return 'Submitted';
      case Status.completed:
        return 'Completed';
    }
  }
}
