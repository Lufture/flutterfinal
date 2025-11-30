import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/tutor_model.dart';

class TutorProvider extends ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  List<Tutoria> _tutorias = [];
  bool _isLoading = false;

  List<Tutoria> get tutorias => _tutorias;
  bool get isLoading => _isLoading;

  Future<void> fetchTutorias() async {
    _isLoading = true;
    notifyListeners(); // Importante: avisar a la UI para mostrar Shimmer

    try {
      // Simulación de delay para ver el Shimmer
      await Future.delayed(const Duration(seconds: 1));

      final snapshot = await _db.collection('tutorias').get();
      // Mapeo manual simple por ahora
      _tutorias = snapshot.docs.map((doc) => Tutoria(
        id: doc.id,
        tutorId: doc['tutorId'],
        tutorName: doc['tutorName'],
        tutorPhoto: doc['tutorPhoto'],
        subject: doc['subject'],
        description: doc['description'],
        pricePerHour: (doc['pricePerHour'] as num).toDouble(),
        rating: (doc['rating'] as num).toDouble(),
        reviewCount: doc['reviewCount'],
      )).toList();

    } catch (e) {
      print("Error fetching tutorias: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}