// lib/modules/configuracion/configuracion_controller.dart
import 'package:get/get.dart';
import '../../app/services/fcm_service.dart';

class ConfiguracionController extends GetxController {
  final FCMService _fcm = Get.find();
  RxBool notifMatematicas = false.obs;
  RxBool notifProgramacion = false.obs;

  Future<void> toggleTopic(String topic, bool value) async {
    if (value) {
      await _fcm.subscribeTopic(topic);
    } else {
      await _fcm.unsubscribeTopic(topic);
    }
  }
}
