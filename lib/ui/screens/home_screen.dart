import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:badges/badges.dart' as badges;
import '../../providers/auth_provider.dart';
import '../../providers/tutor_provider.dart';
import '../../models/tutor_model.dart';
import 'tutor_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch inicial sin setState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TutorProvider>(context, listen: false).fetchTutorias();
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final tutorProvider = Provider.of<TutorProvider>(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // 1. SliverAppBar con Floating
          SliverAppBar(
            floating: true,
            pinned: true,
            expandedHeight: 120.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Hola, ${authProvider.currentUser?.displayName?.split(' ')[0] ?? 'Estudiante'}'),
              centerTitle: false,
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  showSearch(context: context, delegate: TutorSearchDelegate());
                },
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: badges.Badge(
                  badgeContent: const Text('3', style: TextStyle(color: Colors.white)),
                  child: const Icon(Icons.notifications),
                ),
              )
            ],
          ),

          // 2. Filtros con Chips (SliverToBoxAdapter)
          SliverToBoxAdapter(
            child: SizedBox(
              height: 60,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(8),
                children: const [
                  _FilterChip(label: 'Matemáticas'),
                  _FilterChip(label: 'Física'),
                  _FilterChip(label: 'Programación'),
                  _FilterChip(label: 'Idiomas'),
                ],
              ),
            ),
          ),

          // 3. Grid Responsivo (LayoutBuilder + SliverGrid)
          tutorProvider.isLoading
          ? const SliverToBoxAdapter(child: _ShimmerList()) // Loading State
          : SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200, // Responsive: Tarjetas se adaptan
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.75,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final tutoria = tutorProvider.tutorias[index];
                    return _TutorCard(tutoria: tutoria);
                  },
                  childCount: tutorProvider.tutorias.length,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// Widget auxiliar para Tarjeta de Tutor
class _TutorCard extends StatelessWidget {
  final Tutoria tutoria;
  const _TutorCard({required this.tutoria});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navegación con Hero Animation
        Navigator.push(context, MaterialPageRoute(builder: (_) => TutorDetailScreen(tutoria: tutoria)));
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Hero(
                tag: 'tutor_img_${tutoria.id}',
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(tutoria.tutorPhoto),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(tutoria.subject, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo)),
                  Text(tutoria.tutorName, maxLines: 1, overflow: TextOverflow.ellipsis),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('\$${tutoria.pricePerHour}/h', style: const TextStyle(fontWeight: FontWeight.bold)),
                      Row(children: [const Icon(Icons.star, size: 14, color: Colors.amber), Text(tutoria.rating.toString())]),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget de Shimmer Loading
class _ShimmerList extends StatelessWidget {
  const _ShimmerList();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: 4,
        itemBuilder: (_, __) => Card(child: Container(height: 100)),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  const _FilterChip({required this.label});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: ChoiceChip(
        label: Text(label),
        selected: false,
        onSelected: (bool selected) {},
      ),
    );
  }
}

class TutorSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) => [IconButton(icon: const Icon(Icons.clear), onPressed: () => query = '')];
  @override
  Widget? buildLeading(BuildContext context) => IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => close(context, null));
  @override
  Widget buildResults(BuildContext context) => Center(child: Text("Buscando: $query"));
  @override
  Widget buildSuggestions(BuildContext context) => const Center(child: Text("Escribe una materia (ej. Cálculo)"));
}