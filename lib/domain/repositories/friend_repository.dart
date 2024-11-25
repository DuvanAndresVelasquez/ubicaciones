import 'package:prueba/domain/entities/friend.dart';

abstract class FriendRepository {
  Future<void> addFriend(Friend friend);
  Future<List<Friend>> getFriend();
}
