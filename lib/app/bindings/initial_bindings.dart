// lib/app/bindings/initial_bindings.dart
import 'package:get/get.dart';
import '../services/firebase_service.dart';
import '../services/fcm_service.dart';
import '../services/storage_service.dart';
import '../../data/repositories/user_repository.dart';
import '../../data/repositories/tutoria_repository.dart';
import '../../data/repositories/reserva_repository.dart';
import '../../data/repositories/membresia_repository.dart';
import '../services/payments/mercado_pago_service.dart';
import '../services/payments/stripe_service.dart';
import '../services/payments/revenuecat_service.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(FirebaseService(), permanent: true);
    Get.put(FCMService(), permanent: true);
    Get.put(StorageService(), permanent: true);
    Get.put(UserRepository(), permanent: true);
    Get.put(TutoriaRepository(), permanent: true);
    Get.put(ReservaRepository(), permanent: true);
    Get.put(MembresiaRepository(), permanent: true);
    Get.put(MercadoPagoService(), permanent: true);
    Get.put(StripeService(), permanent: true);
    Get.put(RevenueCatService(), permanent: true);
  }
}
