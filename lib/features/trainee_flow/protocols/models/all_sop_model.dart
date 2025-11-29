import 'dart:convert';
import 'package:dermaininstitute/features/trainee_flow/protocols/models/protocol_enums.dart';

class ProtocolStep {
  final String id;
  final int stepNumber;
  final String title;
  final String description;
  final String duration;
  final String sopId;

  ProtocolStep({
    required this.id,
    required this.stepNumber,
    required this.title,
    required this.description,
    required this.duration,
    required this.sopId,
  });

  factory ProtocolStep.fromJson(Map<String, dynamic> json) {
    return ProtocolStep(
      id: json['id'] ?? '',
      stepNumber: json['stepNumber'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      duration: json['duration'] ?? '',
      sopId: json['sopId'] ?? '',
    );
  }
}

class Medication {
  final String id;
  final String name;
  final String dose;
  final String route;
  final String repeat;
  final String sopId;

  Medication({
    required this.id,
    required this.name,
    required this.dose,
    required this.route,
    required this.repeat,
    required this.sopId,
  });

  factory Medication.fromJson(Map<String, dynamic> json) {
    return Medication(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      dose: json['dose'] ?? '',
      route: json['route'] ?? '',
      repeat: json['repeat'] ?? '',
      sopId: json['sopId'] ?? '',
    );
  }
}

class Oxygen {
  final String id;
  final String dose;
  final String route;
  final String repeat;
  final String sopId;

  Oxygen({
    required this.id,
    required this.dose,
    required this.route,
    required this.repeat,
    required this.sopId,
  });

  factory Oxygen.fromJson(Map<String, dynamic> json) {
    return Oxygen(
      id: json['id'] ?? '',
      dose: json['dose'] ?? '',
      route: json['route'] ?? '',
      repeat: json['repeat'] ?? '',
      sopId: json['sopId'] ?? '',
    );
  }
}

class User {
  final String firstName;
  final String lastName;

  User({required this.firstName, required this.lastName});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
    );
  }

  String get fullName => '$firstName $lastName';
}

class Sop {
  final String id;
  final String title;
  final String subtitle; // mapped from overview
  final List<String> jurisdiction;
  final List<String> tags;
  final String overview;
  final List<String> indications;
  final List<String> contraindications;
  final List<String> requiredEquipment;
  final ProtocolCategory category; // mapped from status
  final String isDraft; // Changed to String to match API
  final String authorId;
  final DateTime createdAt;
  final DateTime updatedDate; // mapped from updatedAt
  final List<ProtocolStep> protocolSteps;
  final List<Medication> medications;
  final Oxygen? oxygen;
  final ProtocolPriority priority;
  final User user;

  Sop({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.jurisdiction,
    required this.tags,
    required this.overview,
    required this.indications,
    required this.contraindications,
    required this.requiredEquipment,
    required this.category,
    required this.isDraft,
    required this.authorId,
    required this.createdAt,
    required this.updatedDate,
    required this.protocolSteps,
    required this.medications,
    this.oxygen,
    required this.priority,
    required this.user,
  });

  factory Sop.fromJson(Map<String, dynamic> json) {
    return Sop(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      subtitle: json['overview'] ?? '',
      jurisdiction: List<String>.from(json['jurisdiction'] ?? []),
      tags: List<String>.from(json['tags'] ?? []),
      overview: json['overview'] ?? '',
      indications: List<String>.from(json['indications'] ?? []),
      contraindications: List<String>.from(json['contraindications'] ?? []),
      requiredEquipment: List<String>.from(json['required_equipment'] ?? []),
      category: ProtocolCategoryExtension.fromString(json['status'] ?? ''),
      isDraft: json['isDraft']?.toString() ?? 'Draft',
      authorId: json['authorId'] ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedDate: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
      protocolSteps:
          (json['protocolSteps'] as List<dynamic>?)
              ?.map((e) => ProtocolStep.fromJson(e))
              .toList() ??
          [],
      medications:
          (json['medications'] as List<dynamic>?)
              ?.map((e) => Medication.fromJson(e))
              .toList() ??
          [],
      oxygen: json['oxygen'] != null ? Oxygen.fromJson(json['oxygen']) : null,
      priority: ProtocolPriorityExtension.fromString(
        json['priority']?.toString() ?? '',
      ),
      user: json['user'] != null
          ? User.fromJson(json['user'])
          : User(firstName: '', lastName: ''),
    );
  }

  static List<Sop> listFromRawJson(String rawJson) {
    final List<dynamic> jsonList = jsonDecode(rawJson);
    return jsonList.map((json) => Sop.fromJson(json)).toList();
  }

  ProtocolLocation get location {
    // Check each jurisdiction for location mapping
    for (String jurisdiction in this.jurisdiction) {
      switch (jurisdiction.toLowerCase()) {
        case 'united states':
        case 'us':
          return ProtocolLocation.us;
        case 'united kingdom':
        case 'uk':
          return ProtocolLocation.uk;
        case 'european union':
        case 'eu':
          return ProtocolLocation.eu;
        case 'middle east':
        case 'me':
          return ProtocolLocation.me;
        case 'canada':
        case 'ca':
          return ProtocolLocation.ca;
        case 'new zealand':
        case 'nz':
          return ProtocolLocation.nz;
      }
    }
    return ProtocolLocation.all;
  }

  // Helper getter for author name
  String get authorName => user.fullName;

  // Helper getter to check if draft
  bool get isProtocolDraft => isDraft.toLowerCase() == 'draft';
}
