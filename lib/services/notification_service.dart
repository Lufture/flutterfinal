import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    // 1. Solicitar permisos
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      if (kDebugMode) {
        print('Permiso de notificaciones concedido');
      }

      // 2. Obtener Token (para pruebas o backend)
      final fcmToken = await _firebaseMessaging.getToken();
      if (kDebugMode) {
        print('FCM Token: $fcmToken');
      }

      // 3. Suscribirse a un tema obligatorio del curso
      await _firebaseMessaging.subscribeToTopic("nuevas_tutorias_general");

      // 4. Manejar notificaciones en primer plano
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        if (kDebugMode) {
          print('Mensaje recibido en primer plano: ${message.notification?.title}');
        }
        // Aquí podrías mostrar un SnackBar o un Dialog local
      });
    }
  }
}