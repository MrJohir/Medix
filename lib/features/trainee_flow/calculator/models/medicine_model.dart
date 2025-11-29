class Medicine {
  /// Medicine data model
  /// Contains medicine information with id, title and description

  final String id;
  final String title;
  final String description;

  const Medicine({
    required this.id,
    required this.title,
    required this.description,
  });

  /// Create Medicine from JSON response
  /// [json] - API response data
  /// Returns Medicine object with null safety
  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
    );
  }

  /// Convert Medicine to JSON
  /// Returns map for API requests
  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'description': description};
  }

  /// Check if medicine has valid data
  /// Returns true if title is not empty
  bool get isValid => title.isNotEmpty;
}
