class Tutoria {
  final String id;
  final String tutorId;
  final String tutorName; // Desnormalizado para búsquedas rápidas
  final String tutorPhoto;
  final String subject;
  final String description;
  final double pricePerHour;
  final double rating;
  final int reviewCount;

  Tutoria({
    required this.id,
    required this.tutorId,
    required this.tutorName,
    required this.tutorPhoto,
    required this.subject,
    required this.description,
    required this.pricePerHour,
    required this.rating,
    required this.reviewCount,
  });

  // Factory y toMap omitidos por brevedad, sigue el patrón anterior
}