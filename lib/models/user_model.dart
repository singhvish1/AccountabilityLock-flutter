import 'package:cloud_firestore/cloud_firestore.dart';

enum AuthType { password, pin }

enum UserRole { user, partner, both }

class UserModel {
  final String id;
  final String email;
  final String displayName;
  final UserRole role;
  final AuthType authType;
  final String? accountabilityPartnerId;
  final String? fcmToken;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime lastActiveAt;

  UserModel({
    required this.id,
    required this.email,
    required this.displayName,
    this.role = UserRole.user,
    this.authType = AuthType.password,
    this.accountabilityPartnerId,
    this.fcmToken,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? lastActiveAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now(),
        lastActiveAt = lastActiveAt ?? DateTime.now();

  // Convert to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'displayName': displayName,
      'role': role.name,
      'authType': authType.name,
      'accountabilityPartnerId': accountabilityPartnerId,
      'fcmToken': fcmToken,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
      'lastActiveAt': Timestamp.fromDate(lastActiveAt),
    };
  }

  // Create from Firestore Map
  factory UserModel.fromMap(Map<String, dynamic> map, String documentId) {
    return UserModel(
      id: documentId,
      email: map['email'] ?? '',
      displayName: map['displayName'] ?? '',
      role: UserRole.values.firstWhere(
        (e) => e.name == map['role'],
        orElse: () => UserRole.user,
      ),
      authType: AuthType.values.firstWhere(
        (e) => e.name == map['authType'],
        orElse: () => AuthType.password,
      ),
      accountabilityPartnerId: map['accountabilityPartnerId'],
      fcmToken: map['fcmToken'],
      createdAt: map['createdAt'] != null 
          ? (map['createdAt'] as Timestamp).toDate()
          : DateTime.now(),
      updatedAt: map['updatedAt'] != null 
          ? (map['updatedAt'] as Timestamp).toDate()
          : DateTime.now(),
      lastActiveAt: map['lastActiveAt'] != null 
          ? (map['lastActiveAt'] as Timestamp).toDate()
          : DateTime.now(),
    );
  }

  // Copy with method for updates
  UserModel copyWith({
    String? email,
    String? displayName,
    UserRole? role,
    AuthType? authType,
    String? accountabilityPartnerId,
    String? fcmToken,
    DateTime? updatedAt,
  }) {
    return UserModel(
      id: id,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      role: role ?? this.role,
      authType: authType ?? this.authType,
      accountabilityPartnerId: accountabilityPartnerId ?? this.accountabilityPartnerId,
      fcmToken: fcmToken ?? this.fcmToken,
      createdAt: createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }
}
