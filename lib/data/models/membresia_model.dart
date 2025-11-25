// lib/data/models/membresia_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class Membresia {
  final String uid;
  final String plan; // basico|pro|premium
  final String status; // active|canceled|expired
  final DateTime startedAt;
  final DateTime? expiresAt;
  final String provider; // mercadopago|stripe|revenuecat
  final String? providerSubscriptionId;

  Membresia({
    required this.uid,
    required this.plan,
    required this.status,
    required this.startedAt,
    this.expiresAt,
    required this.provider,
    this.providerSubscriptionId,
  });

  factory Membresia.fromMap(String uid, Map<String, dynamic> m) => Membresia(
    uid: uid,
    plan: m['plan'],
    status: m['status'],
    startedAt: (m['startedAt'] as Timestamp).toDate(),
    expiresAt: m['expiresAt'] != null ? (m['expiresAt'] as Timestamp).toDate() : null,
    provider: m['provider'],
    providerSubscriptionId: m['providerSubscriptionId'],
  );

  Map<String, dynamic> toMap() => {
    'plan': plan,
    'status': status,
    'startedAt': Timestamp.fromDate(startedAt),
    'expiresAt': expiresAt != null ? Timestamp.fromDate(expiresAt!) : null,
    'provider': provider,
    'providerSubscriptionId': providerSubscriptionId,
  };
}
