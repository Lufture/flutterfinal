import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import 'chat_screen.dart';

class MyClassesScreen extends StatelessWidget {
  const MyClassesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).currentUser;
    if (user == null) return const Center(child: Text("Inicia sesión primero"));

    return Scaffold(
      appBar: AppBar(title: const Text("Mis Clases Agendadas")),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('reservaciones')
            .where('studentId', isEqualTo: user.uid)
            .orderBy('fecha', descending: true) // Asegúrate de crear este índice en Firebase si falla
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.event_busy, size: 60, color: Colors.grey),
                  const SizedBox(height: 10),
                  Text("No tienes clases pendientes", style: Theme.of(context).textTheme.bodyLarge),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final doc = snapshot.data!.docs[index];
              final data = doc.data() as Map<String, dynamic>;

              // Determinar color según estado
              Color statusColor = Colors.orange;
              if (data['estado'] == 'confirmada') statusColor = Colors.green;
              if (data['estado'] == 'cancelada') statusColor = Colors.red;

              return Card(
                elevation: 2,
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(data['materia'] ?? 'Tutoría',
                               style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          Chip(
                            label: Text(data['estado'], style: const TextStyle(color: Colors.white, fontSize: 12)),
                            backgroundColor: statusColor,
                            padding: EdgeInsets.zero,
                          )
                        ],
                      ),
                      const Divider(),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: const CircleAvatar(child: Icon(Icons.person)),
                        title: const Text("Tutor"), // Idealmente buscar nombre con otro Stream o guardar nombre en reserva
                        subtitle: Text("Fecha: ${data['fecha']}"), // Formatear fecha
                        trailing: IconButton(
                          icon: const Icon(Icons.chat_bubble, color: Colors.indigo),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ChatScreen(
                                  chatId: doc.id,
                                  otherUserId: data['tutorId'],
                                  otherUserName: "Tutor",
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}