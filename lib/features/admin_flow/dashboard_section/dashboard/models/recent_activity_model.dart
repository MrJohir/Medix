/// sop activity model for recent activity API response
class SopActivity {
  final String id;
  final String title;
  final List<String> jurisdiction;
  final List<String> tags;
  final String overview;
  final List<String> indications;
  final List<String> contraindications;
  final List<String> requiredEquipment;
  final String status;
  final String isDraft;
  final String author;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String priority;

  const SopActivity({
    required this.id,
    required this.title,
    required this.jurisdiction,
    required this.tags,
    required this.overview,
    required this.indications,
    required this.contraindications,
    required this.requiredEquipment,
    required this.status,
    required this.isDraft,
    required this.author,
    required this.createdAt,
    required this.updatedAt,
    required this.priority,
  });

  factory SopActivity.fromJson(Map<String, dynamic> json) {
    return SopActivity(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      jurisdiction: List<String>.from(json['jurisdiction'] ?? []),
      tags: List<String>.from(json['tags'] ?? []),
      overview: json['overview'] ?? '',
      indications: List<String>.from(json['indications'] ?? []),
      contraindications: List<String>.from(json['contraindications'] ?? []),
      requiredEquipment: List<String>.from(json['required_equipment'] ?? []),
      status: json['status'] ?? '',
      isDraft: json['isDraft'] ?? '',
      author: json['author'] ?? '',
      createdAt: DateTime.parse(
        json['createdAt'] ?? DateTime.now().toIso8601String(),
      ),
      updatedAt: DateTime.parse(
        json['updatedAt'] ?? DateTime.now().toIso8601String(),
      ),
      priority: json['priority'] ?? '',
    );
  }
}

/// credentials activity model for recent activity API response
class CredentialsActivity {
  final String id;
  final String email;
  final String phone;
  final String role;
  final bool isApproved;
  final String status;
  final String firstName;
  final String lastName;
  final String jurisdiction;
  final String institution;
  final String department;
  final String specialization;
  final DateTime createdAt;
  final DateTime updatedAt;

  const CredentialsActivity({
    required this.id,
    required this.email,
    required this.phone,
    required this.role,
    required this.isApproved,
    required this.status,
    required this.firstName,
    required this.lastName,
    required this.jurisdiction,
    required this.institution,
    required this.department,
    required this.specialization,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CredentialsActivity.fromJson(Map<String, dynamic> json) {
    return CredentialsActivity(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      role: json['role'] ?? '',
      isApproved: json['isApproved'] ?? false,
      status: json['status'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      jurisdiction: json['jurisdiction'] ?? '',
      institution: json['institution'] ?? '',
      department: json['department'] ?? '',
      specialization: json['specialization'] ?? '',
      createdAt: DateTime.parse(
        json['createdAt'] ?? DateTime.now().toIso8601String(),
      ),
      updatedAt: DateTime.parse(
        json['updatedAt'] ?? DateTime.now().toIso8601String(),
      ),
    );
  }
}

/// incident report activity model (currently empty but ready for future use)
class IncidentReportActivity {
  final String id;
  final String title;
  final DateTime createdAt;

  const IncidentReportActivity({
    required this.id,
    required this.title,
    required this.createdAt,
  });

  factory IncidentReportActivity.fromJson(Map<String, dynamic> json) {
    return IncidentReportActivity(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      createdAt: DateTime.parse(
        json['createdAt'] ?? DateTime.now().toIso8601String(),
      ),
    );
  }
}

/// recent activity response model
class RecentActivityResponse {
  final List<SopActivity> sopActivity;
  final List<IncidentReportActivity> incidentReportActivity;
  final List<CredentialsActivity> credentialsActivity;

  const RecentActivityResponse({
    required this.sopActivity,
    required this.incidentReportActivity,
    required this.credentialsActivity,
  });

  factory RecentActivityResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? {};
    return RecentActivityResponse(
      sopActivity: (data['sopActivity'] as List<dynamic>? ?? [])
          .map((e) => SopActivity.fromJson(e as Map<String, dynamic>))
          .toList(),
      incidentReportActivity:
          (data['incidentReportActivity'] as List<dynamic>? ?? [])
              .map(
                (e) =>
                    IncidentReportActivity.fromJson(e as Map<String, dynamic>),
              )
              .toList(),
      credentialsActivity: (data['credentialsActivity'] as List<dynamic>? ?? [])
          .map((e) => CredentialsActivity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
