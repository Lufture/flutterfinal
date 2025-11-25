// lib/data/repositories/user_repository.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  final _users = FirebaseFirestore.instance.collection('users');

  Future<void> upsertUser(User u, String? fcmToken) async {
    final doc = await _users.doc(u.uid).get();
    final data = {
      'name': u.displayName ?? '',
      'email': u.email ?? '',
      'photoUrl': u.photoURL ?? '',
      'role': 'alumno',
      'materiasDominadas': [],
      'membresia': 'basico',
      'createdAt': doc.exists ? (doc.data()!['createdAt']) : FieldValue.serverTimestamp(),
      'fcmToken': fcmToken,
    };
    await _users.doc(u.uid).set(data, SetOptions(merge: true));
  }

  Future<UserModel?> getUser(String uid) async {
    final doc = await _users.doc(uid).get();
    if (!doc.exists) return null;
    return UserModel.fromMap(doc.id, doc.data()!);
  }

  Future<void> updateUser(String uid, Map<String, dynamic> data) => _users.doc(uid).update(data);
}
