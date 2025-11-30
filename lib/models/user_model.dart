class UserModel {
  final String uid;
  final String email;
  final String displayName;
  final String photoUrl;
  final String role; // 'tutor', 'student'

  UserModel({
    required this.uid,
    required this.email,
    required this.displayName,
    required this.photoUrl,
    this.role = 'student',
  });

  factory UserModel.fromMap(Map<String, dynamic> data, String uid) {
    return UserModel(
      uid: uid,
      email: data['email'] ?? '',
      displayName: data['displayName'] ?? 'Usuario',
      photoUrl: data['photoURL'] ?? '',
      role: data['role'] ?? 'student',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'displayName': displayName,
      'photoURL': photoUrl,
      'role': role,
    };
  }
}