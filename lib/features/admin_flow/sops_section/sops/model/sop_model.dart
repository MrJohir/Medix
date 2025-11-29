/// User model for SOP author information
class User {
  final String firstName;
  final String lastName;

  User({required this.firstName, required this.lastName});

  /// Create user from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
    );
  }

  /// Convert user to JSON
  Map<String, dynamic> toJson() {
    return {'firstName': firstName, 'lastName': lastName};
  }

  /// Get full name
  String get fullName {
    return '$firstName $lastName'.trim();
  }
}

/// Protocol step model
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

  /// Create protocol step from JSON
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

  /// Convert protocol step to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'stepNumber': stepNumber,
      'title': title,
      'description': description,
      'duration': duration,
      'sopId': sopId,
    };
  }
}

/// Medication model
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

  /// Create medication from JSON
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

  /// Convert medication to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'dose': dose,
      'route': route,
      'repeat': repeat,
      'sopId': sopId,
    };
  }
}

/// Oxygen model
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

  /// Create oxygen from JSON
  factory Oxygen.fromJson(Map<String, dynamic> json) {
    return Oxygen(
      id: json['id'] ?? '',
      dose: json['dose'] ?? '',
      route: json['route'] ?? '',
      repeat: json['repeat'] ?? '',
      sopId: json['sopId'] ?? '',
    );
  }

  /// Convert oxygen to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'dose': dose,
      'route': route,
      'repeat': repeat,
      'sopId': sopId,
    };
  }
}

/// Main SOP model to match API response
class SOPModel {
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
  final String authorId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String priority;
  final List<ProtocolStep> protocolSteps;
  final List<Medication> medications;
  final Oxygen? oxygen;
  final User user;

  SOPModel({
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
    required this.authorId,
    required this.createdAt,
    required this.updatedAt,
    required this.priority,
    required this.protocolSteps,
    required this.medications,
    this.oxygen,
    required this.user,
  });

  /// Create SOP from JSON
  factory SOPModel.fromJson(Map<String, dynamic> json) {
    return SOPModel(
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
      authorId: json['authorId'] ?? '',
      createdAt: DateTime.parse(
        json['createdAt'] ?? DateTime.now().toIso8601String(),
      ),
      updatedAt: DateTime.parse(
        json['updatedAt'] ?? DateTime.now().toIso8601String(),
      ),
      priority: json['priority'] ?? '',
      protocolSteps:
          (json['protocolSteps'] as List?)
              ?.map((step) => ProtocolStep.fromJson(step))
              .toList() ??
          [],
      medications:
          (json['medications'] as List?)
              ?.map((med) => Medication.fromJson(med))
              .toList() ??
          [],
      oxygen: json['oxygen'] != null ? Oxygen.fromJson(json['oxygen']) : null,
      user: User.fromJson(json['user'] ?? {}),
    );
  }

  /// Convert SOP to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'jurisdiction': jurisdiction,
      'tags': tags,
      'overview': overview,
      'indications': indications,
      'contraindications': contraindications,
      'required_equipment': requiredEquipment,
      'status': status,
      'isDraft': isDraft,
      'authorId': authorId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'priority': priority,
      'protocolSteps': protocolSteps.map((step) => step.toJson()).toList(),
      'medications': medications.map((med) => med.toJson()).toList(),
      'oxygen': oxygen?.toJson(),
      'user': user.toJson(),
    };
  }

  /// Get formatted date string
  String get formattedDate {
    return '${createdAt.day.toString().padLeft(2, '0')}/${createdAt.month.toString().padLeft(2, '0')}/${createdAt.year}';
  }

  /// Get author name from user object
  String get author {
    return user.fullName;
  }

  /// Get display status text
  String get displayStatus {
    return isDraft == 'Published' ? 'Published' : 'Draft';
  }

  /// Get status color
  String get statusColor {
    return isDraft == 'Published' ? 'green' : 'orange';
  }

  /// Get priority display text
  String get displayPriority {
    switch (priority) {
      case 'High_Priority':
        return 'High Priority';
      case 'Medium_Priority':
        return 'Medium Priority';
      case 'Low_Priority':
        return 'Low Priority';
      default:
        return priority;
    }
  }

  /// Get jurisdiction as comma-separated string
  String get jurisdictionString {
    return jurisdiction.join(', ');
  }
}

/// Legacy enum for backward compatibility (will be removed later)
enum SOPStatus { published, draft }

extension SOPStatusExtension on SOPStatus {
  String get name {
    switch (this) {
      case SOPStatus.published:
        return 'published';
      case SOPStatus.draft:
        return 'draft';
    }
  }

  String get displayName {
    switch (this) {
      case SOPStatus.published:
        return 'Published';
      case SOPStatus.draft:
        return 'Draft';
    }
  }
}
