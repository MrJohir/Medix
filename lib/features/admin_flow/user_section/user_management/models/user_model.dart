/// User model representing a user in the system
class UserModel {
  final String id;
  final String email;
  final String? phone;
  final String role;
  final bool isApproved;
  final String status;
  final String? firstName;
  final String? lastName;
  final String? jurisdiction;
  final String? institution;
  final String? department;
  final String? specialization;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? image;
  final bool? notification;
  final bool? emargencyAlert;

  const UserModel({
    required this.id,
    required this.email,
    this.phone,
    required this.role,
    required this.isApproved,
    required this.status,
    this.firstName,
    this.lastName,
    this.jurisdiction,
    this.institution,
    this.department,
    this.specialization,
    required this.createdAt,
    required this.updatedAt,
    this.image,
    this.notification,
    this.emargencyAlert,
  });

  /// Get full name combining first and last name
  String get fullName {
    if (firstName == null && lastName == null) return 'Unknown User';
    return '${firstName ?? ''} ${lastName ?? ''}'.trim();
  }

  /// Get user role enum from string
  UserRole get roleEnum {
    switch (role.toLowerCase()) {
      case 'admin':
      case 'administrator':
        return UserRole.administrator;
      case 'trainee':
        return UserRole.trainee;
      case 'supervisor':
        return UserRole.supervisor;
      default:
        return UserRole.trainee;
    }
  }

  /// Get user status enum from string
  UserStatus get statusEnum {
    return status.toLowerCase() == 'active'
        ? UserStatus.active
        : UserStatus.inactive;
  }

  /// Get display text for created date
  String get createdAtDisplay {
    final now = DateTime.now();
    final difference = now.difference(createdAt);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'phone': phone,
      'role': role,
      'isApproved': isApproved,
      'status': status,
      'firstName': firstName,
      'lastName': lastName,
      'jurisdiction': jurisdiction,
      'institution': institution,
      'department': department,
      'specialization': specialization,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'image': image,
      'notification': notification,
      'emargencyAlert': emargencyAlert,
    };
  }

  /// Create from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'],
      role: json['role'] ?? 'TRAINEE',
      isApproved: json['isApproved'] ?? false,
      status: json['status'] ?? 'inactive',
      firstName: json['firstName'],
      lastName: json['lastName'],
      jurisdiction: json['jurisdiction'],
      institution: json['institution'],
      department: json['department'],
      specialization: json['specialization'],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : DateTime.now(),
      image: json['image'],
      notification: json['notification'] as bool?,
      emargencyAlert: json['emargencyAlert'] as bool?,
    );
  }

  /// Copy with changes
  UserModel copyWith({
    String? id,
    String? email,
    String? phone,
    String? role,
    bool? isApproved,
    String? status,
    String? firstName,
    String? lastName,
    String? jurisdiction,
    String? institution,
    String? department,
    String? specialization,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? image,
    bool? notification,
    bool? emargencyAlert,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      isApproved: isApproved ?? this.isApproved,
      status: status ?? this.status,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      jurisdiction: jurisdiction ?? this.jurisdiction,
      institution: institution ?? this.institution,
      department: department ?? this.department,
      specialization: specialization ?? this.specialization,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      image: image ?? this.image,
      notification: notification ?? this.notification,
      emargencyAlert: emargencyAlert ?? this.emargencyAlert,
    );
  }
}

/// User role enumeration
enum UserRole {
  administrator,
  trainee,
  supervisor;

  /// Get display name for role
  String get displayName {
    switch (this) {
      case UserRole.administrator:
        return 'Administrator';
      case UserRole.trainee:
        return 'Trainee';
      case UserRole.supervisor:
        return 'Supervisor';
    }
  }

  /// Get background color for role badge
  String get backgroundColor {
    switch (this) {
      case UserRole.administrator:
        return '#D4E7F8'; // Light blue
      case UserRole.trainee:
        return '#D4E7F8'; // Light blue
      case UserRole.supervisor:
        return '#FFF6DD'; // Light yellow
    }
  }

  /// Get text color for role badge
  String get textColor {
    switch (this) {
      case UserRole.administrator:
        return '#0637DB'; // Blue
      case UserRole.trainee:
        return '#0637DB'; // Blue
      case UserRole.supervisor:
        return '#A94907'; // Orange
    }
  }
}

/// User status enumeration
enum UserStatus {
  active,
  inactive;

  /// Get display name for status
  String get displayName {
    switch (this) {
      case UserStatus.active:
        return 'Active';
      case UserStatus.inactive:
        return 'Inactive';
    }
  }

  /// Get background color for status badge
  String get backgroundColor {
    switch (this) {
      case UserStatus.active:
        return '#E6F4EF'; // Light green
      case UserStatus.inactive:
        return '#F0F0F0'; // Light gray
    }
  }

  /// Get text color for status badge
  String get textColor {
    switch (this) {
      case UserStatus.active:
        return '#048E5C'; // Green
      case UserStatus.inactive:
        return '#919191'; // Gray
    }
  }
}
