import 'package:prueba/domain/entities/friend_location.dart';
import 'package:prueba/domain/entities/location.dart';

abstract class FrienLocationRepository {
  Future<void> addFriendLocation(FriendLocation location);
  Future<List<FriendLocation>> getLocation();
}
