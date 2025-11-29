/// user recent activity model for recent activity API response
class UserRecentActivity {
  final String incidentTitle;
  final DateTime updatedAt;
  final String jurisdiction;

  const UserRecentActivity({
    required this.incidentTitle,
    required this.updatedAt,
    required this.jurisdiction,
  });

  /// Create UserRecentActivity from JSON
  factory UserRecentActivity.fromJson(Map<String, dynamic> json) {
    return UserRecentActivity(
      incidentTitle: json['incidentTitle'] ?? '',
      updatedAt: DateTime.parse(
        json['updatedAt'] ?? DateTime.now().toIso8601String(),
      ),
      jurisdiction: json['user']?['jurisdiction'] ?? '',
    );
  }

  /// Convert UserRecentActivity to JSON
  Map<String, dynamic> toJson() {
    return {
      'incidentTitle': incidentTitle,
      'updatedAt': updatedAt.toIso8601String(),
      'jurisdiction': jurisdiction,
    };
  }
}

/// API response wrapper for user recent activity
class UserRecentActivityResponse {
  final int statusCode;
  final bool success;
  final String message;
  final List<UserRecentActivity> data;

  const UserRecentActivityResponse({
    required this.statusCode,
    required this.success,
    required this.message,
    required this.data,
  });

  /// Create UserRecentActivityResponse from JSON
  factory UserRecentActivityResponse.fromJson(Map<String, dynamic> json) {
    return UserRecentActivityResponse(
      statusCode: json['statusCode'] ?? 0,
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data:
          (json['data'] as List<dynamic>?)
              ?.map((item) => UserRecentActivity.fromJson(item))
              .toList() ??
          [],
    );
  }
}
