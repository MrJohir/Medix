/// model class for report view screen data
/// contains all necessary fields for displaying report information
class ReportModel {
  final String id;
  final String createdAt;
  final String updatedAt;
  final String incidentTitle;
  final String procedure;
  final String severity;
  final int patientAge;
  final String patientSex;
  final String userId;
  final String descriptionOfIncident;
  final String situation;
  final String actionsTaken;
  final String outcome;
  final String lessonsLearned;
  final bool isDraft;
  final String status;

  const ReportModel({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.incidentTitle,
    required this.procedure,
    required this.severity,
    required this.patientAge,
    required this.patientSex,
    required this.userId,
    required this.descriptionOfIncident,
    required this.situation,
    required this.actionsTaken,
    required this.outcome,
    required this.lessonsLearned,
    required this.isDraft,
    required this.status,
  });

  /// factory constructor to create model from json
  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
      id: json['id'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      incidentTitle: json['incidentTitle'] ?? '',
      procedure: json['procedure'] ?? '',
      severity: json['severity'] ?? '',
      patientAge: json['patientAge'] ?? 0,
      patientSex: json['patientSex'] ?? '',
      userId: json['userId'] ?? '',
      descriptionOfIncident: json['descriptionOfIncident'] ?? '',
      situation: json['situation'] ?? '',
      actionsTaken: json['actionsTaken'] ?? '',
      outcome: json['outcome'] ?? '',
      lessonsLearned: json['lessonsLearned'] ?? '',
      isDraft: json['isDraft'] ?? false,
      status: json['status'] ?? '',
    );
  }

  /// convert model to json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'incidentTitle': incidentTitle,
      'procedure': procedure,
      'severity': severity,
      'patientAge': patientAge,
      'patientSex': patientSex,
      'userId': userId,
      'descriptionOfIncident': descriptionOfIncident,
      'situation': situation,
      'actionsTaken': actionsTaken,
      'outcome': outcome,
      'lessonsLearned': lessonsLearned,
      'isDraft': isDraft,
      'status': status,
    };
  }

  /// get formatted created date
  String get formattedCreatedDate {
    try {
      final dateTime = DateTime.parse(createdAt);
      return '${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year}';
    } catch (e) {
      return createdAt;
    }
  }

  /// get priority color for severity
  String get priorityColor {
    switch (severity.toLowerCase()) {
      case 'high':
        return 'High';
      case 'medium':
        return 'Medium';
      case 'low':
        return 'Low';
      default:
        return severity;
    }
  }
}
