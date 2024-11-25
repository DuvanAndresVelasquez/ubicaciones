import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:prueba/data/datasources/local/location_local_datasource.dart';
import 'package:prueba/data/repositories/location_repository_impl.dart';
import 'package:prueba/domain/entities/location.dart';
import 'package:prueba/domain/usecases/positions/add_location.dart';
import 'package:prueba/domain/usecases/positions/get_locations.dart';
import 'package:prueba/presentation/pages/create_location.dart';
import 'package:prueba/presentation/stores/location_store.dart';
import 'package:prueba/presentation/widgets/location_card.dart';
import '../../data/datasources/local/database_helper.dart';
import '../../domain/repositories/location_repository.dart';
import '../routes.dart';

class LocationsPage extends StatefulWidget {
  const LocationsPage({Key? key}) : super(key: key);

  @override
  _LocationsPageState createState() => _LocationsPageState();
}

class _LocationsPageState extends State<LocationsPage> {
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Observer(
          builder: (context) {
            if (locationStore.locations.isEmpty) {
              return const Center(child: Text("No hay ubicaciones registradas aún."));
            }
            return ListView.builder(
              itemCount: locationStore.locations.length,
              itemBuilder: (context, index) {
                final location = locationStore.locations[index];
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
    );
  }
}
