import 'package:prueba/domain/entities/friend.dart';
import 'package:prueba/domain/repositories/friend_repository.dart';

class GetFriends {
  final FriendRepository repository;

  GetFriends(this.repository);

  Future<List<Friend>>  call() async {
    return await repository.getFriend();
  }
}
