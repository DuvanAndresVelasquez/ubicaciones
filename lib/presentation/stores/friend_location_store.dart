import 'package:mobx/mobx.dart';
import 'package:prueba/domain/entities/friend_location.dart';
import 'package:prueba/domain/entities/location.dart';

import '../../domain/usecases/friend_locations/add_friend_location.dart';

part 'friend_location_store.g.dart';

class FriendLocationStore = _FriendLocationStoreBase with _$FriendLocationStore;

abstract class _FriendLocationStoreBase with Store {

  final AddUbicacion addLocation;

  _FriendLocationStoreBase(this.addLocation);

  @observable
  ObservableList<FriendLocation> locations = ObservableList<FriendLocation>();


  @action
  Future<void> agregarUbicacion(FriendLocation friendLocation) async {
    await addLocation(friendLocation);
    locations.add(friendLocation);
  }
}
