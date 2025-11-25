// lib/modules/dashboard/dashboard_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/responsive_layout.dart';
import '../auth/auth_controller.dart';
import '../../app/routes/app_routes.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});
  @override
  Widget build(BuildContext context) {
    final user = Get.find<AuthController>().user.value!;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true, snap: true, expandedHeight: 160,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Hola, ${user.name}'),
              background: Center(child: CircleAvatar(radius: 40, backgroundImage: NetworkImage(user.photoUrl))),
            ),
            actions: [
              IconButton(onPressed: () => Get.toNamed(AppRoutes.notificaciones), icon: const Icon(Icons.notifications)),
            ],
          ),
          SliverToBoxAdapter(
            child: ResponsiveLayout(
              mobile: _grid(2),
              tablet: _grid(3),
              desktop: _grid(4),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Tutorías'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: 'Agenda'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
        onTap: (i) {
          if (i == 0) Get.toNamed(AppRoutes.tutorias);
          if (i == 1) Get.toNamed(AppRoutes.reservas);
          if (i == 2) Get.toNamed(AppRoutes.perfil);
        },
      ),
    );
  }

  Widget _grid(int cross) => Padding(
    padding: const EdgeInsets.all(16),
    child: GridView.count(
      shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: cross, children: const [
        _Tile(icon: Icons.explore, label: 'Explorar', route: AppRoutes.tutorias),
        _Tile(icon: Icons.add, label: 'Crear tutoría', route: AppRoutes.crearTutoria),
        _Tile(icon: Icons.workspace_premium, label: 'Membresías', route: AppRoutes.pagos),
        _Tile(icon: Icons.settings, label: 'Configuración', route: AppRoutes.configuracion),
      ],
    ),
  );
}

class _Tile extends StatelessWidget {
  final IconData icon; final String label; final String route;
  const _Tile({required this.icon, required this.label, required this.route, super.key});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(onTap: () => Get.toNamed(route), child: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Icon(icon, size: 32),
          const SizedBox(height: 8),
          Text(label),
        ]),
      )),
    );
  }
}
