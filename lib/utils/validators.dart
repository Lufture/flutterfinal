// lib/utils/validators.dart
class Validators {
  static String? required(String? v) => (v == null || v.trim().isEmpty) ? 'Campo requerido' : null;
  static String? positiveNumber(String? v) {
    if (v == null || v.isEmpty) return null;
    final n = double.tryParse(v);
    if (n == null || n <= 0) return 'Debe ser número positivo';
    return null;
  }
}
