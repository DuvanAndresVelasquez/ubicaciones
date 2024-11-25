import 'package:prueba/domain/entities/friend.dart';
import 'package:prueba/domain/repositories/friend_repository.dart';

class AddAmigo {
  final FriendRepository repository;

  AddAmigo(this.repository);

  Future<void> call(Friend friend) async {
    await repository.addFriend(friend);
  }
}
