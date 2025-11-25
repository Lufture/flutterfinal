// lib/data/models/reserva_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class Reserva {
  final String id;
  final String alumnoId;
  final String tutorId;
  final String tutoriaId;
  final DateTime fecha;
  final String hora; // HH:mm
  final String estado; // pendiente|confirmada|cancelada|reprogramada
  final DateTime createdAt;
  final String? notas;

  Reserva({
    required this.id,
    required this.alumnoId,
    required this.tutorId,
    required this.tutoriaId,
    required this.fecha,
    required this.hora,
    required this.estado,
    required this.createdAt,
    this.notas,
  });

  factory Reserva.fromMap(String id, Map<String, dynamic> m) => Reserva(
    id: id,
    alumnoId: m['alumnoId'],
    tutorId: m['tutorId'],
    tutoriaId: m['tutoriaId'],
    fecha: (m['fecha'] as Timestamp).toDate(),
    hora: m['hora'],
    estado: m['estado'],
    createdAt: (m['createdAt'] as Timestamp).toDate(),
    notas: m['notas'],
  );

  Map<String, dynamic> toMap() => {
    'alumnoId': alumnoId,
    'tutorId': tutorId,
    'tutoriaId': tutoriaId,
    'fecha': Timestamp.fromDate(fecha),
    'hora': hora,
    'estado': estado,
    'createdAt': Timestamp.fromDate(createdAt),
    'notas': notas,
  };
}
