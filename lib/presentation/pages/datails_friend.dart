import 'dart:io';

import 'package:flutter/material.dart';
import 'package:prueba/domain/entities/friend.dart';

import '../../data/datasources/local/database_helper.dart';
import '../../data/datasources/local/location_local_datasource.dart';
import '../../data/repositories/location_repository_impl.dart';
import '../../domain/usecases/positions/add_location.dart';
import '../../domain/usecases/positions/get_locations.dart';
import '../stores/location_store.dart';

class FriendDetailPage extends StatefulWidget {
  final Friend friend;

  const FriendDetailPage({Key? key, required this.friend}) : super(key: key);

  @override
  _FriendDetailPageState createState() => _FriendDetailPageState();
}

class _FriendDetailPageState extends State<FriendDetailPage> {
  late LocationStore locationStore;
  @override
  void initState() {
    super.initState();
    final dbHelper = DatabaseHelper();
    final localDataSource = LocationLocalDataSource(dbHelper);
    final repository = LocationRepositoryImpl(localDataSource);
    final getLocationsUseCase = GetUbicaciones(repository);
    final addLocationUseCase = AddUbicacion(repository);
    locationStore = LocationStore(getLocationsUseCase, addLocationUseCase);
    locationStore.cargarUbicaciones();
    print("Detalles cargados para ${widget.friend.name} ${widget.friend.last_name}");
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
            )
          ],
        ),
      ),
    );
  }
}
