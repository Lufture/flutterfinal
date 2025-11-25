// lib/modules/reservas/reservas_controller.dart
import 'package:get/get.dart';
import '../../data/repositories/reserva_repository.dart';
import '../../data/models/reserva_model.dart';
import '../../data/models/tutoria_model.dart';
import '../auth/auth_controller.dart';

class ReservasController extends GetxController {
  final ReservaRepository _repo = Get.find();
  RxList<Reserva> misReservas = <Reserva>[].obs;

  void cargarMisReservas(String uid) {
    _repo.streamReservasPorUsuario(uid).listen((list) => misReservas.value = list);
  }

  Future<void> reservar(Tutoria t, DateTime fecha, String hora) async {
    final uid = Get.find<AuthController>().user.value!.uid;
    final r = Reserva(
      id: '',
      alumnoId: uid,
      tutorId: t.tutorId,
      tutoriaId: t.id,
      fecha: fecha,
      hora: hora,
      estado: 'pendiente',
      createdAt: DateTime.now(),
    );
    await _repo.createReserva(r);
  }

  Future<void> confirmar(String reservaId) => _repo.updateEstado(reservaId, 'confirmada');
  Future<void> rechazar(String reservaId) => _repo.updateEstado(reservaId, 'cancelada');
  Future<void> reprogramar(String reservaId, DateTime nuevaFecha, String nuevaHora) =>
      _repo.updateReserva(reservaId, {'estado': 'reprogramada', 'fecha': nuevaFecha, 'hora': nuevaHora});
}
