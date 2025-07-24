class User {
  final String id;
  final String email;
  final String name;
  final String role;
  final String? profileImage;
  final DateTime? lastLogin;

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.role,
    this.profileImage,
    this.lastLogin,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      role: json['role'],
      profileImage: json['profileImage'],
      lastLogin: json['lastLogin'] != null 
          ? DateTime.parse(json['lastLogin'])
          : null,
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
    };
  }

  User copyWith({
    String? id,
    String? email,
    String? name,
    String? role,
    String? profileImage,
    DateTime? lastLogin,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      role: role ?? this.role,
      profileImage: profileImage ?? this.profileImage,
      lastLogin: lastLogin ?? this.lastLogin,
    );
  }
}
