// lib/app/services/storage_service.dart
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class StorageService {
  final _st = FirebaseStorage.instance;

  Future<String> uploadTutorImage(String tutorId, File file) async {
    final ref = _st.ref('tutores/$tutorId/${DateTime.now().millisecondsSinceEpoch}.jpg');
    await ref.putFile(file);
    return await ref.getDownloadURL();
  }
}
