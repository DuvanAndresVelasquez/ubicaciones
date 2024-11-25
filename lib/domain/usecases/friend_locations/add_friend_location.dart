

import 'dart:math';

import 'package:prueba/domain/entities/friend_location.dart';
import 'package:prueba/domain/entities/location.dart';
import 'package:prueba/domain/repositories/location_repository.dart';

import '../../repositories/frien_location_repository.dart';

class AddUbicacion {
  final FrienLocationRepository repository;

  AddUbicacion(this.repository);

  Future<void> call(FriendLocation friendLocation) async {

    await repository.addFriendLocation(friendLocation);
  }
}
