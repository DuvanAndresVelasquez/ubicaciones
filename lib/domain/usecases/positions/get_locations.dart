

import 'package:prueba/domain/entities/location.dart';
import 'package:prueba/domain/repositories/location_repository.dart';

class GetUbicaciones {
  final LocationRepository repository;

  GetUbicaciones(this.repository);

  Future<List<Location>> call({int? friendId}) async {
    if (friendId != null) {
      return await repository.getLocationForFriend(friendId);
    }
    return await repository.getLocation();
  }
}
