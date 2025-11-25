// lib/data/repositories/membresia_repository.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/membresia_model.dart';

class MembresiaRepository {
  final _db = FirebaseFirestore.instance.collection('membresias');

  Future<void> setMembresia(String uid, String plan,
      {required String provider, String? providerSubscriptionId}) async {
    final m = Membresia(
      uid: uid,
      plan: plan,
      status: 'active',
      startedAt: DateTime.now(),
      expiresAt: null,
      provider: provider,
      providerSubscriptionId: providerSubscriptionId,
    );
    await _db.doc(uid).set(m.toMap(), SetOptions(merge: true));
    await FirebaseFirestore.instance.collection('users').doc(uid).update({'membresia': plan});
  }

  Future<Membresia?> get(String uid) async {
    final doc = await _db.doc(uid).get();
    if (!doc.exists) return null;
    return Membresia.fromMap(doc.id, doc.data()!);
  }
}
