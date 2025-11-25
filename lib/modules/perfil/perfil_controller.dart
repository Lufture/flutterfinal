// lib/modules/perfil/perfil_controller.dart
import 'package:get/get.dart';
import '../../data/repositories/user_repository.dart';
import '../auth/auth_controller.dart';

class PerfilController extends GetxController {
  final UserRepository _repo = Get.find();
  RxString name = ''.obs;
  RxString role = 'alumno'.obs;
  RxList<String> materias = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    final u = Get.find<AuthController>().user.value!;
    name.value = u.name;
    role.value = u.role;
    materias.assignAll(u.materiasDominadas);
  }

  Future<void> guardar() async {
    final uid = Get.find<AuthController>().user.value!.uid;
    await _repo.updateUser(uid, {
      'name': name.value,
      'role': role.value,
      'materiasDominadas': materias.toList(),
    });
  }
}
