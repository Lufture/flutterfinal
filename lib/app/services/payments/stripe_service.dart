// lib/app/services/payments/stripe_service.dart
class StripeService {
  Future<void> pay(String plan) async {
    await Future.delayed(const Duration(seconds: 2)); // simulación
  }
}
