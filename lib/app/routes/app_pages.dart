// lib/app/routes/app_pages.dart
import 'package:get/get.dart';
import '../../modules/onboarding/onboarding_page.dart';
import '../../modules/auth/login_page.dart';
import '../../modules/dashboard/dashboard_page.dart';
import '../../modules/tutorias/tutorias_page.dart';
import '../../modules/tutorias/crear_tutoria_page.dart';
import '../../modules/tutorias/detalle_tutoria_page.dart';
import '../../modules/reservas/reservas_page.dart';
import '../../modules/reservas/confirmacion_reserva_page.dart';
import '../../modules/pagos/planes_page.dart';
import '../../modules/pagos/pago_tarjeta_page.dart';
import '../../modules/pagos/confirmacion_pago_page.dart';
import '../../modules/perfil/perfil_page.dart';
import '../../modules/configuracion/configuracion_page.dart';
import '../../modules/notificaciones/notificaciones_page.dart';
import '../../modules/auth/auth_controller.dart';
import '../../modules/dashboard/dashboard_controller.dart';
import '../../modules/tutorias/tutorias_controller.dart';
import '../../modules/reservas/reservas_controller.dart';
import '../../modules/pagos/pagos_controller.dart';

class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.onboarding, page: () => const OnboardingPage()),
    GetPage(name: AppRoutes.login, page: () => const LoginPage(), binding: BindingsBuilder(() {
      Get.put(AuthController());
    })),
    GetPage(name: AppRoutes.dashboard, page: () => const DashboardPage(), binding: BindingsBuilder(() {
      Get.put(DashboardController());
      Get.put(TutoriasController());
      Get.put(ReservasController());
      Get.put(PagosController());
    })),
    GetPage(name: AppRoutes.tutorias, page: () => const TutoriasPage()),
    GetPage(name: AppRoutes.crearTutoria, page: () => const CrearTutoriaPage()),
    GetPage(name: AppRoutes.detalleTutoria, page: () => const DetalleTutoriaPage()),
    GetPage(name: AppRoutes.reservas, page: () => const ReservasPage()),
    GetPage(name: AppRoutes.confirmarReserva, page: () => const ConfirmacionReservaPage()),
    GetPage(name: AppRoutes.pagos, page: () => const PlanesPage()),
    GetPage(name: AppRoutes.pagoTarjeta, page: () => const PagoTarjetaPage()),
    GetPage(name: AppRoutes.confirmacionPago, page: () => const ConfirmacionPagoPage()),
    GetPage(name: AppRoutes.perfil, page: () => const PerfilPage()),
    GetPage(name: AppRoutes.configuracion, page: () => const ConfiguracionPage()),
    GetPage(name: AppRoutes.notificaciones, page: () => const NotificacionesPage()),
  ];
}
