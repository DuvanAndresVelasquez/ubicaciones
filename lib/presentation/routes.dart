import 'package:flutter/material.dart';
import 'package:prueba/presentation/pages/create_friend.dart';
import 'package:prueba/presentation/pages/datails_friend.dart';
import 'package:prueba/presentation/pages/details_location.dart';
import 'package:prueba/presentation/pages/friend.dart';
import 'package:prueba/presentation/pages/locations.dart';
import 'package:prueba/presentation/pages/main.dart';
import '../domain/entities/friend.dart';
import '../domain/entities/location.dart';

class Routes {
  static const optionsList = '/opciones';
  static const amigoList = '/amigos';
  static const ubicacionList = '/ubicaciones';
  static const agregarAmigo = '/agregar_amigo';
  static const friendDetails = '/friend_detail';
  static const locationDetails = '/location_detail';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case optionsList:
        return MaterialPageRoute(
          builder: (_) => const OptionsPage(),
        );

      case amigoList:
        return MaterialPageRoute(
          builder: (_) => const FriendsPage(),
        );

      case ubicacionList:
        return MaterialPageRoute(
          builder: (_) => const LocationsPage(),
        );

      case friendDetails:
        final friend = settings.arguments as Friend;
        return MaterialPageRoute(
          builder: (_) => FriendDetailPage(friend: friend),
        );


      case locationDetails:
        final location = settings.arguments as Location;
        return MaterialPageRoute(
          builder: (_) => LocationDetailPage(location: location),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const OptionsPage(),
        );
    }
  }
}
