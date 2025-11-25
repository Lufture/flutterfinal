// lib/modules/auth/auth_controller.dart
import 'package:get/get.dart';
import '../../app/services/firebase_service.dart';
import '../../data/repositories/user_repository.dart';
import '../../app/services/fcm_service.dart';
import '../../data/models/user_model.dart';
import '../../app/routes/app_routes.dart';

class AuthController extends GetxController {
  final FirebaseService _firebase = Get.find();
  final UserRepository _users = Get.find();
  final FCMService _fcm = Get.find();

  Rxn<UserModel> user = Rxn<UserModel>();

  Future<void> loginWithGoogle() async {
    final u = await _firebase.signInWithGoogleRestrictDomain();
    if (u == null) return;
    final token = await _fcm.getToken();
    await _users.upsertUser(u, token);
    user.value = await _users.getUser(u.uid);
    await _fcm.init();
    Get.offAllNamed(AppRoutes.dashboard);
  }

  Future<void> logout() async {
    await _firebase.signOut();
    user.value = null;
    Get.offAllNamed(AppRoutes.login);
  }
}
