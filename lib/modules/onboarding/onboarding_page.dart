// lib/modules/onboarding/onboarding_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../app/routes/app_routes.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          _card('Conecta con tutores', 'Encuentra apoyo académico en tu universidad', 'assets/animations/onboarding1.json'),
          _card('Reserva fácil', 'Agenda sesiones con confirmaciones y recordatorios', 'assets/animations/onboarding2.json'),
          _card('Planes flexibles', 'Elige Básico, Pro o Premium', 'assets/animations/success.json', start: true),
        ],
      ),
    );
  }

  Widget _card(String t, String s, String anim, {bool start = false}) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(child: Lottie.asset(anim)),
          Text(t, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
          Padding(padding: const EdgeInsets.all(16), child: Text(s, textAlign: TextAlign.center)),
          if (start)
            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(onPressed: () => Get.offNamed(AppRoutes.login), child: const Text('Comenzar')),
            ),
        ],
      ),
    );
  }
}
