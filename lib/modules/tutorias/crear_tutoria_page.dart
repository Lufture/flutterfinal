// lib/modules/tutorias/crear_tutoria_page.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/calendar_picker.dart';
import '../../utils/validators.dart';
import '../../data/repositories/tutoria_repository.dart';
import '../../app/services/storage_service.dart';
import '../auth/auth_controller.dart';
import '../../data/models/tutoria_model.dart';

class CrearTutoriaPage extends StatefulWidget {
  const CrearTutoriaPage({super.key});
  @override
  State<CrearTutoriaPage> createState() => _CrearTutoriaPageState();
}

class _CrearTutoriaPageState extends State<CrearTutoriaPage> {
  final _form = GlobalKey<FormState>();
  final _materia = TextEditingController();
  final _desc = TextEditingController();
  final _precio = TextEditingController();
  final horarios = <String>[].obs;
  File? img;

  @override
  Widget build(BuildContext context) {
    final repo = Get.find<TutoriaRepository>();
    final storage = Get.find<StorageService>();
    final uid = Get.find<AuthController>().user.value!.uid;

    return Scaffold(
      appBar: AppBar(title: const Text('Publicar tutoría')),
      body: Form(
        key: _form,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(controller: _materia, decoration: const InputDecoration(labelText: 'Materia'), validator: Validators.required),
            TextFormField(controller: _desc, decoration: const InputDecoration(labelText: 'Descripción'), maxLines: 3, validator: Validators.required),
            TextFormField(controller: _precio, decoration: const InputDecoration(labelText: 'Precio (opcional)'), keyboardType: TextInputType.number, validator: Validators.positiveNumber),
            const SizedBox(height: 12),
            CalendarPicker(onSelect: (dt) => horarios.add(dt.toIso8601String())),
            Obx(() => ReorderableListView(
              shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
              onReorder: (old, neu) {
                final item = horarios.removeAt(old);
                horarios.insert(neu > old ? neu - 1 : neu, item);
              },
              children: [
                for (final h in horarios) ListTile(key: Key(h), title: Text(DateTime.parse(h).toLocal().toString())),
              ],
            )),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              icon: const Icon(Icons.image),
              label: const Text('Seleccionar imagen'),
              onPressed: () async {
                // Integrar ImagePicker si lo deseas; aquí se omite por simplicidad.
              },
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () async {
                if (!_form.currentState!.validate()) return;
                String imgUrl = '';
                if (img != null) imgUrl = await storage.uploadTutorImage(uid, img!);
                final t = Tutoria(
                  id: '',
                  tutorId: uid,
                  materia: _materia.text,
                  descripcion: _desc.text,
                  horarios: horarios.toList(),
                  precio: _precio.text.isEmpty ? null : double.tryParse(_precio.text),
                  imagenUrl: imgUrl,
                  categoria: 'general',
                  activo: true,
                  fechaCreacion: DateTime.now(),
                );
                await repo.createTutoria(t);
                Get.back();
                Get.snackbar('Publicado', 'Tu tutoría está disponible');
              },
              child: const Text('Publicar'),
            ),
          ],
        ),
      ),
    );
  }
}
