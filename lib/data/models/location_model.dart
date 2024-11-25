class LocationModel {
  final int? id;
  final String name;
  final double latitud;
  final double longitud;
  final String? description;
  final List<String>? photos;

  LocationModel({
    this.id,
    required this.name,
    required this.latitud,
    required this.longitud,
    this.description,
    this.photos,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'latitud': latitud,
      'longitud': longitud,
      'description': description,
      'photos': photos != null ? photos!.join(',') : null,
    };
  }

  factory LocationModel.fromMap(Map<String, dynamic> map) {
    return LocationModel(
      id: map['id'],
      name: map['name'],
      latitud: map['latitud'],
      longitud: map['longitud'],
      description: map['description'],
      photos: map['photos'] != null ? (map['photos'] as String).split(',') : null,
    );
  }
}
