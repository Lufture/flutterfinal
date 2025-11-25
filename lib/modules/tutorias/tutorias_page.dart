// lib/modules/tutorias/tutorias_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/cached_image.dart';
import '../../widgets/shimmer_list.dart';
import '../../app/routes/app_routes.dart';
import 'tutorias_controller.dart';

class TutoriasPage extends GetView<TutoriasController> {
  const TutoriasPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tutorías')),
      body: Column(
        children: [
          _Filtros(controller),
          Expanded(
            child: Obx(() {
              final list = controller.tutorias;
              if (list.isEmpty) return const ShimmerList(itemCount: 6);
              return ListView.builder(
                itemCount: list.length,
                itemBuilder: (_, i) => Dismissible(
                  key: Key(list[i].id),
                  background: Container(color: Colors.redAccent),
                  onDismissed: (_) => Get.snackbar('Oculto', 'Tutoría ocultada localmente'),
                  child: ListTile(
                    leading: CachedImage(url: list[i].imagenUrl, width: 56, height: 56),
                    title: Text(list[i].materia),
                    subtitle: Text(list[i].descripcion),
                    trailing: Text(list[i].precio != null ? '\$${list[i].precio!.toStringAsFixed(2)}' : 'Gratis'),
                    onTap: () => Get.toNamed(AppRoutes.detalleTutoria, arguments: list[i]),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(AppRoutes.crearTutoria),
        child: const Icon(Icons.add),
      ),
    );
  }
}

Widget _Filtros(TutoriasController c) => ExpansionTile(
  title: const Text('Filtros'),
  children: [
    Wrap(
      spacing: 8,
      children: [
        ChoiceChip(label: const Text('Todas'), selected: c.filtroCategoria.value == '', onSelected: (_) => c.setCategoria('')),
        ChoiceChip(label: const Text('Matemáticas'), selected: c.filtroCategoria.value == 'matematicas', onSelected: (_) => c.setCategoria('matematicas')),
        ChoiceChip(label: const Text('Programación'), selected: c.filtroCategoria.value == 'programacion', onSelected: (_) => c.setCategoria('programacion')),
      ],
    ),
  ],
);
