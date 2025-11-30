import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'login_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: "Encuentra tu Tutor",
          body: "Busca expertos en las materias que necesitas reforzar.",
          image: const Icon(Icons.school, size: 100, color: Colors.indigo),
        ),
        PageViewModel(
          title: "Agenda Flexible",
          body: "Reserva sesiones en los horarios que mejor te convengan.",
          image: const Icon(Icons.calendar_month, size: 100, color: Colors.indigo),
        ),
        PageViewModel(
          title: "Pagos Seguros",
          body: "Realiza tus pagos de forma segura a través de la app.",
          image: const Icon(Icons.security, size: 100, color: Colors.indigo),
        ),
      ],
      onDone: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      },
      showSkipButton: true,
      skip: const Text("Saltar"),
      next: const Text("Siguiente"),
      done: const Text("Empezar", style: TextStyle(fontWeight: FontWeight.w600)),
    );
  }
}