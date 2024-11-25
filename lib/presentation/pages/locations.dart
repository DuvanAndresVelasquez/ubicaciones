import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:prueba/data/datasources/local/location_local_datasource.dart';
import 'package:prueba/data/repositories/location_repository_impl.dart';
import 'package:prueba/domain/usecases/positions/add_location.dart';
import 'package:prueba/domain/usecases/positions/get_locations.dart';
import 'package:prueba/presentation/pages/create_location.dart';
import 'package:prueba/presentation/stores/location_store.dart';
import 'package:prueba/presentation/widgets/location_card.dart';
import '../../data/datasources/local/database_helper.dart';
import '../routes.dart';

class LocationsPage extends StatefulWidget {
  const LocationsPage({Key? key}) : super(key: key);

  @override
  _LocationsPageState createState() => _LocationsPageState();
}

class _LocationsPageState extends State<LocationsPage> {
  late LocationStore locationStore;
  String searchText = "";

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Ubicaciones'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddLocationPage(locationStore: locationStore),
                ),
              );
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Buscar ubicación...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
              onChanged: (value) {
                setState(() {
                  searchText = value.toLowerCase();
                });
              },
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Observer(
          builder: (context) {
            if (locationStore.locations.isEmpty) {
              return const Center(child: Text("No hay ubicaciones registradas aún."));
            }


            final filteredLocations = locationStore.locations.where((location) {
              return location.name.toLowerCase().contains(searchText);
            }).toList();

            if (filteredLocations.isEmpty) {
              return const Center(child: Text("No se encontraron coincidencias."));
            }

            return ListView.builder(
              itemCount: filteredLocations.length,
              itemBuilder: (context, index) {
                final location = filteredLocations[index];
                return CardLocationWidget(
                  name: location.name,
                  description: "${location.description} \nlongitud: ${location.longitud} \nlongitud: ${location.longitud}",
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
    );
  }
}
