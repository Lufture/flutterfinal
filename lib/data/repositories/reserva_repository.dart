// lib/data/repositories/reserva_repository.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/reserva_model.dart';

class ReservaRepository {
  final _db = FirebaseFirestore.instance.collection('reservas');

  Future<String> createReserva(Reserva r) async {
    final doc = await _db.add(r.toMap());
    return doc.id;
  }

  Stream<List<Reserva>> streamReservasPorUsuario(String uid) {
    return _db.where('alumnoId', isEqualTo: uid).snapshots()
      .map((s) => s.docs.map((d) => Reserva.fromMap(d.id, d.data())).toList());
  }

  Stream<List<Reserva>> streamReservasPorTutor(String uid) {
    return _db.where('tutorId', isEqualTo: uid).snapshots()
      .map((s) => s.docs.map((d) => Reserva.fromMap(d.id, d.data())).toList());
  }

  Future<void> updateEstado(String id, String estado) => _db.doc(id).update({'estado': estado});

  Future<void> updateReserva(String id, Map<String, dynamic> data) => _db.doc(id).update(data);
}
