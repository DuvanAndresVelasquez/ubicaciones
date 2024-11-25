

import 'package:prueba/data/datasources/local/friend_location_local_datasource.dart';
import 'package:prueba/data/models/location_model.dart';
import 'package:prueba/domain/entities/location.dart';
import 'package:prueba/domain/repositories/frien_location_repository.dart';
import 'package:prueba/domain/repositories/location_repository.dart';

import '../../domain/entities/friend_location.dart';
import '../datasources/local/location_local_datasource.dart';
import '../models/friend_location_model.dart';

class FriendLocationRepositoryImpl implements FrienLocationRepository {
  final FriendLocationLocalDatasource localDataSource;

  FriendLocationRepositoryImpl(this.localDataSource);

  @override
  Future<void> addFriendLocation(FriendLocation location) async {
    final locationModel = FriendLocationModel(
      id: location.id,
      friendId: location.friendId,
      locationId: location.locationId
    );
    await localDataSource.addFriendLocation(locationModel);
  }

  @override
  Future<List<FriendLocation>> getLocation() {
    // TODO: implement getLocation
    throw UnimplementedError();
  }






}
