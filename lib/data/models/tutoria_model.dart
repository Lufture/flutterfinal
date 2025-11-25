// lib/data/models/tutoria_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class Tutoria {
  final String id;
  final String tutorId;
  final String materia;
  final String descripcion;
  final List<String> horarios; // ISO strings
  final double? precio;
  final String imagenUrl;
  final String categoria;
  final bool activo;
  final DateTime fechaCreacion;

  Tutoria({
    required this.id,
    required this.tutorId,
    required this.materia,
    required this.descripcion,
    required this.horarios,
    required this.imagenUrl,
    required this.categoria,
    required this.activo,
    required this.fechaCreacion,
    this.precio,
  });

  factory Tutoria.fromMap(String id, Map<String, dynamic> m) => Tutoria(
    id: id,
    tutorId: m['tutorId'],
    materia: m['materia'],
    descripcion: m['descripcion'],
    horarios: List<String>.from(m['horarios'] ?? []),
    precio: (m['precio'] != null) ? (m['precio'] as num).toDouble() : null,
    imagenUrl: m['imagenUrl'] ?? '',
    categoria: m['categoria'] ?? 'general',
    activo: m['activo'] ?? true,
    fechaCreacion: (m['fechaCreacion'] as Timestamp).toDate(),
  );

  Map<String, dynamic> toMap() => {
    'tutorId': tutorId,
    'materia': materia,
    'descripcion': descripcion,
    'horarios': horarios,
    'precio': precio,
    'imagenUrl': imagenUrl,
    'categoria': categoria,
    'activo': activo,
    'fechaCreacion': Timestamp.fromDate(fechaCreacion),
  };
}
