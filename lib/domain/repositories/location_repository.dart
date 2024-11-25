import 'package:prueba/domain/entities/location.dart';

abstract class LocationRepository {
  Future<void> addLocation(Location position);
  Future<List<Location>> getLocation();
  Future<List<Location>> getLocationForFriend(int friendId);
}
