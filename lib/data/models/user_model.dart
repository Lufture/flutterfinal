// lib/data/models/user_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String name;
  final String email;
  final String photoUrl;
  final String role; // alumno|tutor
  final List<String> materiasDominadas;
  final String membresia; // basico|pro|premium
  final String? fcmToken;
  final DateTime createdAt;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.photoUrl,
    required this.role,
    required this.materiasDominadas,
    required this.membresia,
    required this.createdAt,
    this.fcmToken,
  });

  factory UserModel.fromMap(String uid, Map<String, dynamic> m) => UserModel(
    uid: uid,
    name: m['name'] ?? '',
    email: m['email'] ?? '',
    photoUrl: m['photoUrl'] ?? '',
    role: m['role'] ?? 'alumno',
    materiasDominadas: List<String>.from(m['materiasDominadas'] ?? []),
    membresia: m['membresia'] ?? 'basico',
    createdAt: (m['createdAt'] as Timestamp).toDate(),
    fcmToken: m['fcmToken'],
  );

  Map<String, dynamic> toMap() => {
    'name': name,
    'email': email,
    'photoUrl': photoUrl,
    'role': role,
    'materiasDominadas': materiasDominadas,
    'membresia': membresia,
    'createdAt': Timestamp.fromDate(createdAt),
    'fcmToken': fcmToken,
  };
}
