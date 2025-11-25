// lib/widgets/calendar_picker.dart
import 'package:flutter/material.dart';

class CalendarPicker extends StatelessWidget {
  final void Function(DateTime) onSelect;
  const CalendarPicker({super.key, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.calendar_today),
      label: const Text('Agregar horario'),
      onPressed: () async {
        final now = DateTime.now();
        final date = await showDatePicker(
          context: context,
          initialDate: now,
          firstDate: now,
          lastDate: DateTime(now.year + 1),
        );
        if (date == null) return;
        final time = await showTimePicker(
          context: context,
          initialTime: const TimeOfDay(hour: 10, minute: 0),
        );
        if (time == null) return;
        final dt = DateTime(date.year, date.month, date.day, time.hour, time.minute);
        onSelect(dt.toUtc());
      },
    );
  }
}
