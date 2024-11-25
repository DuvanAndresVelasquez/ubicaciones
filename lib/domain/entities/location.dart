class Location {
  final int? id;
  final String name;
  final double latitud;
  final double longitud;
  final String? description;
  final List<String>? photos;

  Location({
    this.id,
    required this.name,
    required this.latitud,
    required this.longitud,
    this.description,
    this.photos,
  });
}
