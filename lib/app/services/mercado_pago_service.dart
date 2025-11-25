// lib/app/services/payments/mercado_pago_service.dart
class MercadoPagoService {
  // Simulación para práctica escolar
  Future<_MPPreference> createPreference(String plan) async {
    return _MPPreference(id: 'pref_${DateTime.now().millisecondsSinceEpoch}', plan: plan, amount: plan == 'Pro' ? 99 : plan == 'Premium' ? 199 : 0);
  }
  Future<void> openCheckout(_MPPreference pref) async {
    await Future.delayed(const Duration(seconds: 2)); // simula checkout
  }
}

class _MPPreference {
  final String id;
  final String plan;
  final int amount;
  _MPPreference({required this.id, required this.plan, required this.amount});
}
