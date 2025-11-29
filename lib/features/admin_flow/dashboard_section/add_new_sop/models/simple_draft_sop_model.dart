/// Simple draft SOP model for GetStorage local database storage
/// Stores SOP data when user saves as draft
class SimpleDraftSOPModel {
  final String id;
  final String title;
  final List<String> jurisdiction;
  final List<String> tags;
  final String overview;
  final List<String> indications;
  final List<String> contraindications;
  final List<String> requiredEquipment;
  final String status;
  final String priority;
  final String publicationStatus;
  final String author;
  final List<Map<String, dynamic>> protocolSteps;
  final List<Map<String, dynamic>> medications;
  final bool settingStatus;
  final String createdAt;

  SimpleDraftSOPModel({
    required this.id,
    required this.title,
    required this.jurisdiction,
    required this.tags,
    required this.overview,
    required this.indications,
    required this.contraindications,
    required this.requiredEquipment,
    required this.status,
    required this.priority,
    required this.publicationStatus,
    required this.author,
    required this.protocolSteps,
    required this.medications,
    required this.settingStatus,
    required this.createdAt,
  });

  /// Convert to JSON for storage
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'jurisdiction': jurisdiction,
      'tags': tags,
      'overview': overview,
      'indications': indications,
      'contraindications': contraindications,
      'requiredEquipment': requiredEquipment,
      'status': status,
      'priority': priority,
      'publicationStatus': publicationStatus,
      'author': author,
      'protocolSteps': protocolSteps,
      'medications': medications,
      'settingStatus': settingStatus,
      'createdAt': createdAt,
    };
  }

  /// Create from JSON
  factory SimpleDraftSOPModel.fromJson(Map<String, dynamic> json) {
    return SimpleDraftSOPModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      jurisdiction: List<String>.from(json['jurisdiction'] ?? []),
      tags: List<String>.from(json['tags'] ?? []),
      overview: json['overview'] ?? '',
      indications: List<String>.from(json['indications'] ?? []),
      contraindications: List<String>.from(json['contraindications'] ?? []),
      requiredEquipment: List<String>.from(json['requiredEquipment'] ?? []),
      status: json['status'] ?? '',
      priority: json['priority'] ?? '',
      publicationStatus: json['publicationStatus'] ?? '',
      author: json['author'] ?? '',
      protocolSteps: List<Map<String, dynamic>>.from(
        json['protocolSteps'] ?? [],
      ),
      medications: List<Map<String, dynamic>>.from(json['medications'] ?? []),
      settingStatus: json['settingStatus'] ?? false,
      createdAt: json['createdAt'] ?? '',
    );
  }

  /// Convert to API format for publishing
  Map<String, dynamic> toApiJson() {
    return {
      'title': title,
      'jurisdiction': jurisdiction,
      'tags': tags,
      'overview': overview,
      'indications': indications,
      'contraindications': contraindications,
      'required_equipment': requiredEquipment,
      'status': status,
      'priority': priority,
      'isDraft': 'Published',
      'author': author,
      'protocolSteps': protocolSteps,
      'medications': medications,
    };
  }

  /// Get formatted date for display
  String get formattedDate {
    try {
      final date = DateTime.parse(createdAt);
      return '${date.day}/${date.month}/${date.year}';
    } catch (e) {
      return createdAt;
    }
  }
}
