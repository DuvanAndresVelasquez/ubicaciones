import 'package:mobx/mobx.dart';
import 'package:prueba/domain/entities/location.dart';
import 'package:prueba/domain/usecases/positions/add_location.dart';
import 'package:prueba/domain/usecases/positions/get_locations.dart';

part 'location_store.g.dart';

class LocationStore = _LocationStoreBase with _$LocationStore;

abstract class _LocationStoreBase with Store {
  final GetUbicaciones getLocations;
  final AddUbicacion addLocation;

  _LocationStoreBase(this.getLocations, this.addLocation);

  @observable
  ObservableList<Location> locations = ObservableList<Location>();

  @action
  Future<void> cargarUbicaciones() async {
    final ubicacionesCargadas = await getLocations();
    locations = ObservableList.of(ubicacionesCargadas);
  }

  @action
  Future<void> agregarUbicacion(Location location) async {
    await addLocation(location);
    locations.add(location);
  }
}
