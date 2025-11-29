/// Simple draft report model for local storage
/// Uses GetStorage-compatible JSON serialization without external dependencies
class SimpleDraftReportModel {
  final String id;
  final String incidentTitle;
  final String procedure;
  final String severity;
  final String patientAge;
  final String patientSex;
  final String incidentDescription;
  final String actionsTaken;
  final String outcome;
  final String lessonsLearned;
  final String author;
  final String createdAt;

  SimpleDraftReportModel({
    required this.id,
    required this.incidentTitle,
    required this.procedure,
    required this.severity,
    required this.patientAge,
    required this.patientSex,
    required this.incidentDescription,
    required this.actionsTaken,
    required this.outcome,
    required this.lessonsLearned,
    required this.author,
    required this.createdAt,
  });

  /// Convert to JSON for storage
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'incidentTitle': incidentTitle,
      'procedure': procedure,
      'severity': severity,
      'patientAge': patientAge,
      'patientSex': patientSex,
      'incidentDescription': incidentDescription,
      'actionsTaken': actionsTaken,
      'outcome': outcome,
      'lessonsLearned': lessonsLearned,
      'author': author,
      'createdAt': createdAt,
    };
  }

  /// Create from JSON for retrieval
  factory SimpleDraftReportModel.fromJson(Map<String, dynamic> json) {
    return SimpleDraftReportModel(
      id: json['id'] ?? '',
      incidentTitle: json['incidentTitle'] ?? '',
      procedure: json['procedure'] ?? '',
      severity: json['severity'] ?? '',
      patientAge: json['patientAge'] ?? '',
      patientSex: json['patientSex'] ?? '',
      incidentDescription: json['incidentDescription'] ?? '',
      actionsTaken: json['actionsTaken'] ?? '',
      outcome: json['outcome'] ?? '',
      lessonsLearned: json['lessonsLearned'] ?? '',
      author: json['author'] ?? '',
      createdAt: json['createdAt'] ?? '',
    );
  }

  /// Convert to CreateReportModel for API submission
  Map<String, dynamic> toApiJson() {
    return {
      'incidentTitle': incidentTitle,
      'procedure': procedure,
      'severity': severity,
      'patientAge': int.tryParse(patientAge) ?? 0,
      'patientSex': patientSex,
      'descriptionOfIncident': incidentDescription,
      'situation': severity, // Mapping severity to situation as per API
      'actionsTaken': actionsTaken,
      'outcome': outcome,
      'lessonsLearned': lessonsLearned,
      'isDraft': false, // Always false for submission
    };
  }

  /// Copy with method for updates
  SimpleDraftReportModel copyWith({
    String? id,
    String? incidentTitle,
    String? procedure,
    String? severity,
    String? patientAge,
    String? patientSex,
    String? incidentDescription,
    String? actionsTaken,
    String? outcome,
    String? lessonsLearned,
    String? author,
    String? createdAt,
  }) {
    return SimpleDraftReportModel(
      id: id ?? this.id,
      incidentTitle: incidentTitle ?? this.incidentTitle,
      procedure: procedure ?? this.procedure,
      severity: severity ?? this.severity,
      patientAge: patientAge ?? this.patientAge,
      patientSex: patientSex ?? this.patientSex,
      incidentDescription: incidentDescription ?? this.incidentDescription,
      actionsTaken: actionsTaken ?? this.actionsTaken,
      outcome: outcome ?? this.outcome,
      lessonsLearned: lessonsLearned ?? this.lessonsLearned,
      author: author ?? this.author,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
