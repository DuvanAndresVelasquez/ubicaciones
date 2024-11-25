

import 'package:prueba/domain/entities/location.dart';
import 'package:prueba/domain/repositories/location_repository.dart';

class GetUbicaciones {
  final LocationRepository repository;

  GetUbicaciones(this.repository);

  Future<List<Location>> call({int? friendId}) async {
    if (friendId != null) {
      print("Se buscan ubicaciones por id del amigo");
      return await repository.getLocationForFriend(friendId);
    }
    print("Se buscan ubicaciones normalmente");
    return await repository.getLocation();
  }
}
