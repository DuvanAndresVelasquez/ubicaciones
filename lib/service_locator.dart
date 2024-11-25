import 'package:get_it/get_it.dart';
import 'package:prueba/data/repositories/friends_repsoitory_impl.dart';
import 'package:prueba/data/repositories/location_repository_impl.dart';
import 'package:prueba/domain/repositories/friend_repository.dart';
import 'package:prueba/domain/repositories/location_repository.dart';
import 'package:prueba/domain/usecases/friends/add_friend.dart';
import 'package:prueba/domain/usecases/friends/friend_usecases.dart';
import 'package:prueba/domain/usecases/positions/add_location.dart';
import 'package:prueba/domain/usecases/positions/get_locations.dart';

final locator = GetIt.instance;

void setupLocator() {
  // Repositorios (ya agregados)
  locator.registerLazySingleton<FriendRepository>(
          () => FriendsRepsoitoryImpl(locator()));
  locator.registerLazySingleton<LocationRepository>(
          () => LocationRepositoryImpl(locator()));

  // Casos de uso: Amigos
  locator.registerLazySingleton(() => AddAmigo(locator()));
  locator.registerLazySingleton(() => GetFriends(locator()));

  // Casos de uso: Ubicaciones
  locator.registerLazySingleton(() => AddUbicacion(locator()));
  locator.registerLazySingleton(() => GetUbicaciones(locator()));
}
