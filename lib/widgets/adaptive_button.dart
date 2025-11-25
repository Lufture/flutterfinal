// lib/widgets/adaptive_button.dart
import 'package:flutter/material.dart';
class AdaptiveButton extends StatelessWidget {
  final String label; final VoidCallback onPressed;
  const AdaptiveButton({super.key, required this.label, required this.onPressed});
  @override
  Widget build(BuildContext context) => ElevatedButton(onPressed: onPressed, child: Text(label));
}
