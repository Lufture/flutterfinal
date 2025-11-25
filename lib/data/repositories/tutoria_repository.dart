// lib/data/repositories/tutoria_repository.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/tutoria_model.dart';

class TutoriaRepository {
  final _db = FirebaseFirestore.instance.collection('tutorias');

  Stream<List<Tutoria>> streamTutorias({String? categoria}) {
    Query q = _db.orderBy('fechaCreacion', descending: true);
    if (categoria != null && categoria.isNotEmpty) {
      q = q.where('categoria', isEqualTo: categoria);
    }
    return q.snapshots().map((s) => s.docs.map((d) => Tutoria.fromMap(d.id, d.data())).toList());
  }

  Future<String> createTutoria(Tutoria t) async {
    final doc = await _db.add(t.toMap());
    return doc.id;
  }

  Future<void> updateTutoria(String id, Map<String, dynamic> data) => _db.doc(id).update(data);

  Future<Tutoria?> getById(String id) async {
    final doc = await _db.doc(id).get();
    if (!doc.exists) return null;
    return Tutoria.fromMap(doc.id, doc.data()!);
  }
}
