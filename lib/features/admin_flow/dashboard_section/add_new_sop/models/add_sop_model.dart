class AddSopModel {
  final String title;
  final List<String> jurisdiction;
  final List<String> tags;
  final String overview;
  final List<String> indications;
  final List<String> contraindications;
  final List<String> requiredEquipment;
  final String status;
  final String priority;
  final String isDraft; // Changed from bool to String for publication status
  final String author;
  final List<ProtocolStep> protocolSteps;
  final List<Medication> medications;

  const AddSopModel({
    required this.title,
    required this.jurisdiction,
    required this.tags,
    required this.overview,
    required this.indications,
    required this.contraindications,
    required this.requiredEquipment,
    required this.status,
    required this.priority,
    required this.isDraft,
    required this.author,
    required this.protocolSteps,
    required this.medications,
  });

  /// Convert AddSopModel to JSON for API request
  Map<String, dynamic> toJson() {
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
      'isDraft': isDraft,
      'protocolSteps': protocolSteps.map((step) => step.toJson()).toList(),
      'medications': medications.map((med) => med.toJson()).toList(),
    };
  }

  /// Create AddSopModel from JSON response
  factory AddSopModel.fromJson(Map<String, dynamic> json) {
    return AddSopModel(
      title: json['title'] ?? '',
      jurisdiction: List<String>.from(json['jurisdiction'] ?? []),
      tags: List<String>.from(json['tags'] ?? []),
      overview: json['overview'] ?? '',
      indications: List<String>.from(json['indications'] ?? []),
      contraindications: List<String>.from(json['contraindications'] ?? []),
      requiredEquipment: List<String>.from(json['required_equipment'] ?? []),
      status: json['status'] ?? 'Procedure',
      priority: json['priority'] ?? 'High_Priority',
      isDraft: json['isDraft']?.toString() ?? 'Draft',
      author: json['author'] ?? '',
      protocolSteps:
          (json['protocolSteps'] as List<dynamic>?)
              ?.map((step) => ProtocolStep.fromJson(step))
              .toList() ??
          [],
      medications:
          (json['medications'] as List<dynamic>?)
              ?.map((med) => Medication.fromJson(med))
              .toList() ??
          [],
    );
  }
}

class ProtocolStep {
  final int stepNumber;
  final String title;
  final String description;
  final String duration;

  const ProtocolStep({
    required this.stepNumber,
    required this.title,
    required this.description,
    required this.duration,
  });

  /// Convert ProtocolStep to JSON
  Map<String, dynamic> toJson() {
    return {
      'stepNumber': stepNumber,
      'title': title,
      'description': description,
      'duration': duration,
    };
  }

  /// Create ProtocolStep from JSON
  factory ProtocolStep.fromJson(Map<String, dynamic> json) {
    return ProtocolStep(
      stepNumber: json['stepNumber'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      duration: json['duration'] ?? '',
    );
  }
}

class Medication {
  final String name;
  final String dose;
  final String route;
  final String repeat;

  const Medication({
    required this.name,
    required this.dose,
    required this.route,
    required this.repeat,
  });

  /// Convert Medication to JSON
  Map<String, dynamic> toJson() {
    return {'name': name, 'dose': dose, 'route': route, 'repeat': repeat};
  }

  /// Create Medication from JSON
  factory Medication.fromJson(Map<String, dynamic> json) {
    return Medication(
      name: json['name'] ?? '',
      dose: json['dose'] ?? '',
      route: json['route'] ?? '',
      repeat: json['repeat'] ?? '',
    );
  }
}
