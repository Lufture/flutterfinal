// lib/modules/tutorias/tutorias_controller.dart
import 'package:get/get.dart';
import '../../data/repositories/tutoria_repository.dart';
import '../../data/models/tutoria_model.dart';

class TutoriasController extends GetxController {
  final TutoriaRepository _repo = Get.find();
  RxList<Tutoria> tutorias = <Tutoria>[].obs;
  RxString filtroCategoria = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _repo.streamTutorias().listen((list) => tutorias.value = list);
  }

  void setCategoria(String cat) {
    filtroCategoria.value = cat;
    _repo.streamTutorias(categoria: cat).listen((list) => tutorias.value = list);
  }
}
