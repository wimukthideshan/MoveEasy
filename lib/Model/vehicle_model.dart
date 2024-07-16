class Vehicle {
  final String title;
  final String description;
  final double pricePerKm;
  final String imageUrl;
  final DateTime dateAdded;
  final String type;

  Vehicle({
    required this.title,
    required this.description,
    required this.pricePerKm,
    required this.imageUrl,
    required this.dateAdded,
    required this.type,
  });
}