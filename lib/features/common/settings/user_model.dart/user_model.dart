// class UserModel {
//   final String id;
//   final String email;
//   final String? phone;
//   final String role;
//   final bool isApproved;
//   final String status;
//   final String firstName;
//   final String lastName;
//   final String? jurisdiction;
//   final String? institution;
//   final String? department;
//   final String? specialization;
//   final String createdAt;
//   final String updatedAt;
//   final String? image;
//   final bool? notification;

//   UserModel({
//     required this.id,
//     required this.email,
//     this.phone,
//     required this.role,
//     required this.isApproved,
//     required this.status,
//     required this.firstName,
//     required this.lastName,
//     this.jurisdiction,
//     this.institution,
//     this.department,
//     this.specialization,
//     required this.createdAt,
//     required this.updatedAt,
//     this.image,
//     this.notification,
//   });

//   factory UserModel.fromJson(Map<String, dynamic> json) {
//     return UserModel(
//       id: json["id"] ?? '',
//       email: json["email"] ?? '',
//       phone: json["phone"] as String?,
//       role: json["role"] ?? '',
//       isApproved: json["isApproved"] ?? false,
//       status: json["status"] ?? '',
//       firstName: json["firstName"] ?? '',
//       lastName: json["lastName"] ?? '',
//       jurisdiction: json["jurisdiction"] as String?,
//       institution: json["institution"] as String?,
//       department: json["department"] as String?,
//       specialization: json["specialization"] as String?,
//       createdAt: json["createdAt"] ?? '',
//       updatedAt: json["updatedAt"] ?? '',
//       image: json["image"] as String?,
//       notification: json["notification"] as bool?,
//     );
//   }
// }
