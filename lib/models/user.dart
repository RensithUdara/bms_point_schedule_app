class User {
  final String id;
  final String email;
  final String name;
  final String role;
  final String? profileImage;
  final DateTime? lastLogin;
  final bool isActive;
  final String? password; // For internal use only, not typically stored in model

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.role,
    this.profileImage,
    this.lastLogin,
    this.isActive = true,
    this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      name: json['name'] ?? '',
      role: json['role'] ?? '',
      profileImage: json['profileImage'],
      lastLogin: json['lastLogin'] != null 
          ? DateTime.parse(json['lastLogin'])
          : null,
      isActive: json['is_active'] ?? true,
      password: json['password'], // Only used during authentication
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'role': role,
      'profileImage': profileImage,
      'lastLogin': lastLogin?.toIso8601String(),
      'is_active': isActive,
      // Note: password should not be included in toJson for security
    };
  }

  User copyWith({
    String? id,
    String? email,
    String? name,
    String? role,
    String? profileImage,
    DateTime? lastLogin,
    bool? isActive,
    String? password,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      role: role ?? this.role,
      profileImage: profileImage ?? this.profileImage,
      lastLogin: lastLogin ?? this.lastLogin,
      isActive: isActive ?? this.isActive,
      password: password ?? this.password,
    );
  }
}
