// lib/models/report.dart
class Report {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String incidentTitle;
  final String procedure;
  final String severity;
  final int patientAge;
  final String patientSex;
  final String descriptionOfIncident;
  final String situation;
  final String actionsTaken;
  final String outcome;
  final String lessonsLearned;
  final bool isDraft;
  final String status;

  Report({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.incidentTitle,
    required this.procedure,
    required this.severity,
    required this.patientAge,
    required this.patientSex,
    required this.descriptionOfIncident,
    required this.situation,
    required this.actionsTaken,
    required this.outcome,
    required this.lessonsLearned,
    required this.isDraft,
    required this.status,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      id: json['id'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      incidentTitle: json['incidentTitle'] as String,
      procedure: json['procedure'] as String,
      severity: json['severity'] as String,
      patientAge: json['patientAge'] as int,
      patientSex: json['patientSex'] as String,
      descriptionOfIncident: json['descriptionOfIncident'] as String,
      situation: json['situation'] as String,
      actionsTaken: json['actionsTaken'] as String,
      outcome: json['outcome'] as String,
      lessonsLearned: json['lessonsLearned'] as String,
      isDraft: json['isDraft'] as bool,
      status: json['status'] as String,
    );
  }
}
