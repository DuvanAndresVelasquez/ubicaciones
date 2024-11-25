

import 'dart:math';

import 'package:prueba/domain/entities/location.dart';
import 'package:prueba/domain/repositories/location_repository.dart';

class AddUbicacion {
  final LocationRepository repository;

  AddUbicacion(this.repository);

  Future<void> call(Location location) async {


    final ubicaciones = await repository.getLocation();
    final esDuplicada = ubicaciones.any((u) =>
    u.name == location.name &&
        u.latitud == location.latitud &&
        u.longitud == location.longitud);

    if (esDuplicada) {
      throw Exception("La ubicación ya existe.");
    }

    final esCercana = ubicaciones.any((u) {
      final distancia = calcularDistancia(
        location.latitud,
        location.longitud,
        u.latitud,
        u.longitud,
      );
      return distancia <= 500; // Radio en metros.
    });

    if (esCercana) {
      throw Exception("Existe otra ubicación en un radio de 500 metros.");
    }

    await repository.addLocation(location);
  }

  double calcularDistancia(
      double lat1, double lon1, double lat2, double lon2) {
    const radioTierra = 6371000;
    final dLat = (lat2 - lat1) * (3.14159265359 / 180);
    final dLon = (lon2 - lon1) * (3.14159265359 / 180);

    final a = (sin(dLat / 2) * sin(dLat / 2)) +
        (cos(lat1 * (3.14159265359 / 180)) *
            cos(lat2 * (3.14159265359 / 180)) *
            sin(dLon / 2) *
            sin(dLon / 2));

    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return radioTierra * c;
  }
}
