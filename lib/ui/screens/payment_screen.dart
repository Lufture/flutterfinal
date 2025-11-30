import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PaymentScreen extends StatefulWidget {
  final double amount;
  const PaymentScreen({super.key, required this.amount});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),
          Text("Resumen de Pago", style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Total a pagar:"),
              Text("\$${widget.amount.toStringAsFixed(2)}", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 40),
          _isLoading
              ? const CircularProgressIndicator()
              : SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _initPayment,
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    child: const Text("Pagar con Tarjeta", style: TextStyle(color: Colors.white)),
                  ),
                ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Future<void> _initPayment() async {
    setState(() => _isLoading = true);
    try {
      // 1. Crear PaymentIntent en el Backend (Simulado aquí, pero deberia ser una Cloud Function)
      // NOTA: No hagas esto en producción real, la secret key debe estar en servidor.
      // Aquí simulamos la llamada para obtener el client_secret.

      // Supongamos que esta función devuelve el clientSecret
      final clientSecret = await _createTestPaymentIntent(widget.amount);

      // 2. Inicializar Payment Sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: 'TutorConnect',
          style: ThemeMode.light,
        ),
      );

      // 3. Presentar Payment Sheet
      await Stripe.instance.presentPaymentSheet();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pago exitoso! Tutoria agendada.')),
      );
      Navigator.pop(context); // Cerrar modal

    } catch (e) {
      if (e is StripeException) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error de pago: ${e.error.localizedMessage}')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<String> _createTestPaymentIntent(double amount) async {
    // ESTO ES SOLO PARA DEMOSTRACIÓN. USAR BACKEND REAL.
    // Necesitas una Cloud Function que haga esto y retorne el client_secret.
    // throw UnimplementedError("Debes implementar la llamada a tu Cloud Function aquí");

    // Simulación rápida:
    return "pi_test_secret_xxxxxxxx"; // Esto fallará si no es un secret real de Stripe
  }
}