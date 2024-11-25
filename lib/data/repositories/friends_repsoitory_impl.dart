

import 'package:prueba/data/models/friend_model.dart';
import 'package:prueba/domain/entities/friend.dart';
import 'package:prueba/domain/repositories/friend_repository.dart';

import '../datasources/local/friend_local_datasource.dart';

class FriendsRepsoitoryImpl implements FriendRepository {
  final FriendLocalDataSource localDataSource;

  FriendsRepsoitoryImpl(this.localDataSource);

  @override
  Future<void> addFriend(Friend friend) async {
    final existingFriends = await localDataSource.getFriends();
    if (existingFriends.length >= 5) {
      throw Exception('No se pueden agregar más de 5 amigos.');
    }
    final friendModel = FriendModel(
      id: friend.id,
      name: friend.name,
      last_name: friend.last_name,
      email: friend.email,
      phone: friend.phone,
      photo: friend.photo,
    );
    await localDataSource.addFriend(friendModel);
  }


  @override
  Future<List<Friend>> getFriend() async {
    final friendModels = await localDataSource.getFriends();
    return friendModels.map((friendModel) => Friend(
      id: friendModel.id,
      name: friendModel.name,
      last_name: friendModel.last_name,
      email: friendModel.email,
      phone: friendModel.phone,
      photo: friendModel.photo,
    )).toList();
  }


}
