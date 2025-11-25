// lib/app/theme/app_theme.dart
import 'package:flutter/material.dart';
import 'app_colors.dart';
class AppTheme {
  static final light = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.background,
    appBarTheme: const AppBarTheme(centerTitle: true),
  );
}
