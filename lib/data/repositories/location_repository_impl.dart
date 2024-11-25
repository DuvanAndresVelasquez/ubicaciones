

import 'package:prueba/data/models/location_model.dart';
import 'package:prueba/domain/entities/location.dart';
import 'package:prueba/domain/repositories/location_repository.dart';

import '../datasources/local/location_local_datasource.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocationLocalDataSource localDataSource;

  LocationRepositoryImpl(this.localDataSource);

  @override
  Future<void> addLocation(Location location) async {
    final locationModel = LocationModel(
      id: location.id,
      name: location.name,
      latitud: location.latitud,
      longitud: location.longitud,
      description: location.description,
      photos: location.photos,
    );
    await localDataSource.addLocation(locationModel);
  }

  @override
  Future<List<Location>> getLocation() async {
    final locationModels = await localDataSource.getLocations();
    return locationModels.map((locationModel) => Location(
      id: locationModel.id,
      name: locationModel.name,
      latitud: locationModel.latitud,
      longitud: locationModel.longitud,
      description: locationModel.description,
      photos: locationModel.photos,
    )).toList();
  }



  @override
  Future<List<Location>> getLocationForFriend(int friendId) async {
    final locationModels = await localDataSource.getLocationsForFriend(friendId);
    return locationModels.map((locationModel) => Location(
      id: locationModel.id,
      name: locationModel.name,
      latitud: locationModel.latitud,
      longitud: locationModel.longitud,
      description: locationModel.description,
      photos: locationModel.photos,
    )).toList();
  }
}
