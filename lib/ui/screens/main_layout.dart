import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'profile_screen.dart';
import 'my_classes_screen.dart'; // Crearemos esta pantalla abajo

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  // Lista de pantallas principales
  final List<Widget> _screens = [
    const HomeScreen(),      // Índice 0
    const MyClassesScreen(), // Índice 1 (Nueva pantalla para separar reservas del perfil)
    const ProfileScreen(),   // Índice 2
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Usamos IndexedStack para mantener el estado de las pantallas (scroll, inputs)
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.search_outlined),
            selectedIcon: Icon(Icons.search),
            label: 'Explorar',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_month_outlined),
            selectedIcon: Icon(Icons.calendar_month),
            label: 'Mis Clases',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}