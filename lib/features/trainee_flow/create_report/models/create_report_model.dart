class CreateReportModel {
  final String? incidentTitle;
  final String? procedure;
  final String? severity;
  final String? patientAge;
  final String? patientSex;
  final String? incidentDescription;
  final String? actionsTaken;
  final String? outcome;
  final String? lessonsLearned;

  CreateReportModel({
    this.incidentTitle,
    this.procedure,
    this.severity,
    this.patientAge,
    this.patientSex,
    this.incidentDescription,
    this.actionsTaken,
    this.outcome,
    this.lessonsLearned,
  });

  // Convert to JSON for API integration
  Map<String, dynamic> toJson() {
    return {
      'incidentTitle': incidentTitle,
      'procedure': procedure,
      'severity': severity,
      'patientAge': int.tryParse(patientAge ?? '0') ?? 0,
      'patientSex': patientSex,
      'descriptionOfIncident': incidentDescription,
      'situation': severity, // Mapping severity to situation as per API
      'actionsTaken': actionsTaken,
      'outcome': outcome,
      'lessonsLearned': lessonsLearned,
      'isDraft': false, // Always false for submission
    };
  }

  // Create from JSON for API integration
  factory CreateReportModel.fromJson(Map<String, dynamic> json) {
    return CreateReportModel(
      incidentTitle: json['incident_title'],
      procedure: json['procedure'],
      severity: json['severity'],
      patientAge: json['patient_age'],
      patientSex: json['patient_sex'],
      incidentDescription: json['incident_description'],
      actionsTaken: json['actions_taken'],
      outcome: json['outcome'],
      lessonsLearned: json['lessons_learned'],
    );
  }

  // Copy with method for state management
  CreateReportModel copyWith({
    String? incidentTitle,
    String? procedure,
    String? severity,
    String? patientAge,
    String? patientSex,
    String? incidentDescription,
    String? actionsTaken,
    String? outcome,
    String? lessonsLearned,
  }) {
    return CreateReportModel(
      incidentTitle: incidentTitle ?? this.incidentTitle,
      procedure: procedure ?? this.procedure,
      severity: severity ?? this.severity,
      patientAge: patientAge ?? this.patientAge,
      patientSex: patientSex ?? this.patientSex,
      incidentDescription: incidentDescription ?? this.incidentDescription,
      actionsTaken: actionsTaken ?? this.actionsTaken,
      outcome: outcome ?? this.outcome,
      lessonsLearned: lessonsLearned ?? this.lessonsLearned,
    );
  }
}
