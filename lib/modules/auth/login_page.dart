// lib/modules/auth/login_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'auth_controller.dart';

class LoginPage extends GetView<AuthController> {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ingreso institucional')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Usa tu correo @universidad.edu.mx'),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.account_circle),
              label: const Text('Ingresar con Google'),
              onPressed: () async {
                try {
                  await controller.loginWithGoogle();
                } catch (e) {
                  Get.snackbar('Acceso denegado', e.toString());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
