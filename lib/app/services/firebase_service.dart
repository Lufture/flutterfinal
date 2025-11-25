// lib/app/services/firebase_service.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseService {
  final _auth = FirebaseAuth.instance;
  final _google = GoogleSignIn();

  Future<User?> signInWithGoogleRestrictDomain() async {
    final gUser = await _google.signIn();
    if (gUser == null) return null;
    final gAuth = await gUser.authentication;
    final cred = GoogleAuthProvider.credential(accessToken: gAuth.accessToken, idToken: gAuth.idToken);
    final userCred = await _auth.signInWithCredential(cred);
    final email = userCred.user?.email ?? '';
    if (!email.endsWith('@universidad.edu.mx')) {
      await _auth.signOut();
      await _google.disconnect();
      throw Exception('Correo no permitido. Usa tu correo institucional @universidad.edu.mx');
    }
    return userCred.user;
  }

  Future<void> signOut() async {
    await _auth.signOut();
    await _google.signOut();
  }

  User? get currentUser => _auth.currentUser;
}
