// lib/widgets/responsive_layout.dart
import 'package:flutter/material.dart';
class ResponsiveLayout extends StatelessWidget {
  final Widget mobile, tablet, desktop;
  const ResponsiveLayout({required this.mobile, required this.tablet, required this.desktop, super.key});
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    if (w < 600) return mobile;
    if (w < 1024) return tablet;
    return desktop;
  }
}
