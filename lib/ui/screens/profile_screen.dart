import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../providers/auth_provider.dart';
import 'login_screen.dart';
import 'chat_screen.dart'; // Necesitaremos navegar al chat desde aquí

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final user = auth.currentUser;

    if (user == null) return const SizedBox();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Mi Perfil"),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () async {
              await auth.signOut();
              if (context.mounted) {
                Navigator.of(context).pushNamedAndRemoveUntil('/',(route)=> false);
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                  (route) => false,
                );
              }
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundImage: CachedNetworkImageProvider(user.photoUrl),
            ),
            const SizedBox(height: 10),
            Text(user.displayName, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Text(user.email, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 30),

            // Sección de Reservas
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.centerLeft,
              child: const Text("Mis Reservaciones", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),

            // Lista de Reservas desde Firestore
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('reservaciones')
                  .where('studentId', isEqualTo: user.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) return const Center(child: Text("Error al cargar"));
                if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());

                final docs = snapshot.data!.docs;
                if (docs.isEmpty) return const Padding(padding: EdgeInsets.all(20), child: Text("No tienes tutorías agendadas."));

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final data = docs[index].data() as Map<String, dynamic>;
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: ListTile(
                        leading: const Icon(Icons.calendar_today, color: Colors.indigo),
                        title: Text("Tutoría: ${data['materia'] ?? 'General'}"),
                        subtitle: Text("Estado: ${data['estado']}"),
                        trailing: IconButton(
                          icon: const Icon(Icons.chat_bubble_outline),
                          onPressed: () {
                            // Navegar al chat con el tutor
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ChatScreen(
                                  chatId: docs[index].id, // Usamos ID reserva como ID chat por simplicidad
                                  otherUserId: data['tutorId'],
                                  otherUserName: "Tutor", // Idealmente buscar nombre
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}