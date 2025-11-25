// lib/app/services/fcm_service.dart
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FCMService {
  final _fcm = FirebaseMessaging.instance;
  final _local = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    await _fcm.requestPermission();
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidInit);
    await _local.initialize(initSettings);

    FirebaseMessaging.onMessage.listen(_showLocal);
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      // Opcional: navegación según message.data
    });
  }

  Future<void> subscribeTopic(String topic) => _fcm.subscribeToTopic(topic);
  Future<void> unsubscribeTopic(String topic) => _fcm.unsubscribeFromTopic(topic);
  Future<String?> getToken() => _fcm.getToken();

  Future<void> _showLocal(RemoteMessage msg) async {
    const details = NotificationDetails(
      android: AndroidNotificationDetails('tutoru', 'TutorU', importance: Importance.max, priority: Priority.high),
    );
    await _local.show(msg.hashCode, msg.notification?.title, msg.notification?.body, details, payload: msg.data.toString());
  }
}
