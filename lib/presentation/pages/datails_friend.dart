import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:prueba/data/datasources/local/friend_location_local_datasource.dart';
import 'package:prueba/domain/entities/friend.dart';
import 'package:prueba/presentation/routes.dart';

import '../../data/datasources/local/database_helper.dart';
import '../../data/datasources/local/location_local_datasource.dart';
import '../../data/repositories/friend_location_repository_impl.dart';
import '../../data/repositories/location_repository_impl.dart';
import '../../domain/entities/location.dart';
import '../../domain/repositories/frien_location_repository.dart';
import '../../domain/usecases/friend_locations/add_friend_location.dart';
import '../../domain/usecases/positions/get_locations.dart';
import '../stores/friend_location_store.dart';
import '../stores/location_store.dart';
import '../widgets/location_card.dart';
import '../widgets/locations_bottom_sheet.dart';

class FriendDetailPage extends StatefulWidget {
  final Friend friend;

  const FriendDetailPage({Key? key, required this.friend}) : super(key: key);

  @override
  _FriendDetailPageState createState() => _FriendDetailPageState();
}

class _FriendDetailPageState extends State<FriendDetailPage> {
  late LocationStore locationStore;
  late FriendLocationStore friendLocationStore;
  List<Location> locations = [];
  List<Location> allLocations = [];

  late LocationRepositoryImpl repo;


  @override
  void initState() {
    super.initState();
    final dbHelper = DatabaseHelper();
    final localDataSource = LocationLocalDataSource(dbHelper);
    final repository = LocationRepositoryImpl(localDataSource);
    setState(() {
      repo = repository;
    });
    cargarUbicaciones(repository);
    print("Detalles cargados para ${widget.friend.name} ${widget.friend.last_name}");
  }



  Future<void> cargarUbicaciones(LocationRepositoryImpl repository) async {
    final getUbicaciones = GetUbicaciones(repository);
    final ubicacionesCargadas = await getUbicaciones.call(friendId: widget.friend.id);
    final ubicacionesCargadasTodas = await getUbicaciones.call();
    setState(() {
      locations = ubicacionesCargadas;
      allLocations = ubicacionesCargadasTodas;
    });
    print("Id usado: ${widget.friend.id}"  );
  }


  void _showLocationsBottomSheet(BuildContext context) {


    final _dbHelper = DatabaseHelper();
    final _localDataSource = FriendLocationLocalDatasource(_dbHelper);
    final _repository = FriendLocationRepositoryImpl(_localDataSource);
    final _addFriendLocationUseCase = AddUbicacion(_repository);
    friendLocationStore = FriendLocationStore(_addFriendLocationUseCase);




    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return LocationsBottomSheet(locations: allLocations, friendLocationStore: friendLocationStore,friendId: widget.friend.id ?? 0,
            action: () => cargarUbicaciones(repo));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final friend = widget.friend;

    return Scaffold(
      appBar: AppBar(
        title: Text("${friend.name} ${friend.last_name}"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: friend.photo != null && friend.photo!.isNotEmpty
                  ? ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.file(
                  File(friend.photo!),
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              )
                  : const Icon(
                Icons.person,
                size: 50,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Nombre: ${friend.name} ${friend.last_name}",
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Correo electrónico: ${friend.email}",
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Teléfono: ${friend.phone}",
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            const Divider(height: 32),
            Expanded(
              child: Observer(
                builder: (context) {
                  if (locations.isEmpty) {
                    return const Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("No hay ubicaciones registradas aún."),

                      ],
                    ),

                  );
                  }
                  return ListView.builder(
                    itemCount: locations.length,
                    itemBuilder: (context, index) {
                      final location = locations[index];
                      return CardLocationWidget(
                        name: location.name,
                        description: location.description ?? "",
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            Routes.locationDetails,
                            arguments: location,
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  ElevatedButton(
                    onPressed: () {

                      _showLocationsBottomSheet(context);
                    },
                    child: const Text("Agregar una nueva ubicación a este amigo"),
                  ),
                ],
              ),

            )
          ],
        ),
      ),
    );
  }

}
