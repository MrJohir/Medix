import 'package:dermaininstitute/features/trainee_flow/protocols/models/protocol_enums.dart';

class ProtocolModel {
  final String id;
  final String title;
  final String subtitle;
  final String description;
  final ProtocolLocation location;
  final ProtocolCategory category;
  final ProtocolPriority priority;
  final DateTime updatedDate;
  final String? imageUrl;

  ProtocolModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.location,
    required this.category,
    required this.priority,
    required this.updatedDate,
    this.imageUrl,
  });

  // Factory constructor for API response
  factory ProtocolModel.fromJson(Map<String, dynamic> json) {
    return ProtocolModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      subtitle: json['subtitle'] ?? '',
      description: json['description'] ?? '',
      location: ProtocolLocationExtension.fromString(json['location'] ?? 'UK'),
      category: ProtocolCategoryExtension.fromString(json['category'] ?? 'Emergency'),
      priority: ProtocolPriorityExtension.fromString(json['priority'] ?? 'High'),
      updatedDate: DateTime.tryParse(json['updated_date'] ?? '') ?? DateTime.now(),
      imageUrl: json['image_url'],
    );
  }

  // Convert to JSON for API requests
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'description': description,
      'location': location.value,
      'category': category.value,
      'priority': priority.value,
      'updated_date': updatedDate.toIso8601String(),
      'image_url': imageUrl,
    };
  }

  // Create a copy with updated fields
  ProtocolModel copyWith({
    String? id,
    String? title,
    String? subtitle,
    String? description,
    ProtocolLocation? location,
    ProtocolCategory? category,
    ProtocolPriority? priority,
    DateTime? updatedDate,
    String? imageUrl,
  }) {
    return ProtocolModel(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      description: description ?? this.description,
      location: location ?? this.location,
      category: category ?? this.category,
      priority: priority ?? this.priority,
      updatedDate: updatedDate ?? this.updatedDate,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ProtocolModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'ProtocolModel(id: $id, title: $title, location: $location, category: $category, priority: $priority)';
  }
}
