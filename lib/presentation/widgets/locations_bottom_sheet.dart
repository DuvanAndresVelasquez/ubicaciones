import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prueba/domain/entities/friend_location.dart';
import 'package:prueba/presentation/stores/friend_location_store.dart';

import '../../domain/entities/location.dart';

class LocationsBottomSheet extends StatelessWidget {
  final List<Location> locations;
  final FriendLocationStore friendLocationStore;
  final Future<void> Function() action;
  final int friendId;

  LocationsBottomSheet({required this.locations, required this.friendLocationStore,
    required this.friendId, required this.action});

  final _formKey = GlobalKey<FormState>();


  Future<void> _addLocation(int locationId) async {

      final friendLocation = FriendLocation(
        friendId: friendId,
        locationId: locationId,
      );

      try {
        friendLocationStore.agregarUbicacion(friendLocation);
      } catch (e) {
        print("Error al agregar la ubicación al amigo: $e");
      }

  }



  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Ubicaciones disponibles",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          ListView.builder(
            shrinkWrap: true,
            itemCount: locations.length,
            itemBuilder: (context, index) {
              final location = locations[index];
              return ListTile(
                title: Text(location.name),
                subtitle: Text(location.description ?? "Sin descripción"),
                onTap: () {
                  _addLocation(location.id ?? 0);
                  action();
                  Navigator.pop(context);

                },
              );
            },
          ),
        ],
      ),
    );
  }
}
