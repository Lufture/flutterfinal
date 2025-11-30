import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../models/tutor_model.dart';
import 'payment_screen.dart';

class TutorDetailScreen extends StatefulWidget {
  final Tutoria tutoria;
  const TutorDetailScreen({super.key, required this.tutoria});

  @override
  State<TutorDetailScreen> createState() => _TutorDetailScreenState();
}

class _TutorDetailScreenState extends State<TutorDetailScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(widget.tutoria.subject),
              background: Hero(
                tag: 'tutor_img_${widget.tutoria.id}',
                child: CachedNetworkImage(
                  imageUrl: widget.tutoria.tutorPhoto,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Tutor: ${widget.tutoria.tutorName}", style: Theme.of(context).textTheme.titleLarge),
                        Text("\$${widget.tutoria.pricePerHour}/hr", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    RatingBarIndicator(
                      rating: widget.tutoria.rating,
                      itemBuilder: (context, index) => const Icon(Icons.star, color: Colors.amber),
                      itemCount: 5,
                      itemSize: 20.0,
                    ),
                    const SizedBox(height: 20),
                    const Text("Sobre la clase:", style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(widget.tutoria.description),

                    const SizedBox(height: 30),
                    const Text("Selecciona Fecha:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),

                    // Calendario
                    TableCalendar(
                      firstDay: DateTime.utc(2024, 1, 1),
                      lastDay: DateTime.utc(2025, 12, 31),
                      focusedDay: _focusedDay,
                      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                      onDaySelected: (selectedDay, focusedDay) {
                        // NO setState en Providers, pero aquí es UI local efímera
                        setState(() {
                          _selectedDay = selectedDay;
                          _focusedDay = focusedDay;
                        });
                      },
                      calendarStyle: const CalendarStyle(
                        todayDecoration: BoxDecoration(color: Colors.indigoAccent, shape: BoxShape.circle),
                        selectedDecoration: BoxDecoration(color: Colors.indigo, shape: BoxShape.circle),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black12)]),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo, padding: const EdgeInsets.symmetric(vertical: 16)),
          onPressed: _selectedDay == null ? null : () {
            // Ir a pagar
            _showPaymentSheet(context);
          },
          child: const Text("Agendar y Pagar", style: TextStyle(color: Colors.white, fontSize: 16)),
        ),
      ),
    );
  }

  void _showPaymentSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => PaymentScreen(amount: widget.tutoria.pricePerHour),
    );
  }
}