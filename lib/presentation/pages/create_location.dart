import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:prueba/domain/entities/friend.dart';
import 'package:prueba/domain/entities/location.dart';
import 'package:prueba/domain/usecases/friends/friend_usecases.dart';

import '../../data/datasources/local/database_helper.dart';
import '../../data/datasources/local/friend_local_datasource.dart';
import '../../data/repositories/friends_repsoitory_impl.dart';
import '../../domain/repositories/friend_repository.dart';
import '../stores/friend_store.dart';
import '../stores/location_store.dart';
import '../viewmodels/image_picker_viewmodel.dart';
import '../widgets/image_picker_buttons.dart';

class AddLocationPage extends StatefulWidget {
  final LocationStore locationStore;

  const AddLocationPage({Key? key, required this.locationStore}) : super(key: key);

  @override
  _AddLocationPageState createState() => _AddLocationPageState();
}

class _AddLocationPageState extends State<AddLocationPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  List<File> _imageFiles = [];
  final picker = ImagePicker();

  Future<void> _requestPermissions() async {
    final status = await Permission.storage.request();
    if (status.isDenied) {
      throw("No se otorgó el permiso de almacenamiento.");
    }
  }

  Future<void> _pickImageFromCamera() async {
    try {
      await _requestPermissions();
      final pickedFile = await picker.pickImage(source: ImageSource.camera);
      setState(() {
        if (pickedFile != null && _imageFiles.length < 3) {
          _imageFiles.add(File(pickedFile.path));
        } else {
          print('No image selected or max limit reached.');
        }
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> _pickImage() async {
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      setState(() {
        if (pickedFile != null && _imageFiles.length < 3) {
          _imageFiles.add(File(pickedFile.path));
        } else {
          print('No image selected or max limit reached.');
        }
      });
    } catch (e) {
      print(e);
    }
  }





  Future<Position?> _getCurrentLocation() async {
    try {
      // Verificar permisos
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw ("Servicio de ubicación deshabilitado.");
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw ("Permiso de ubicación denegado.");
        }
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      print('Latitud: ${position.latitude}, Longitud: ${position.longitude}');

      return position; // Ahora puedes devolver la posición
    } catch (e) {
      print("Error al obtener ubicación: $e");
      return null; // Retorna null en caso de error
    }
  }


  Future<void> _addLocation() async {
    if (_formKey.currentState!.validate()) {
      Position? position = await _getCurrentLocation();
      List<String> photoPaths = _imageFiles.map((file) => file.path).toList();
      final location = Location(
        name: _nameController.text,
        description: _descriptionController.text,
        latitud: position?.latitude ?? 0.0,
        longitud: position?.longitude ?? 0.0,
        photos: photoPaths,
      );

      try {
        await widget.locationStore.agregarUbicacion(location);
        Navigator.pop(context);
      } catch (e) {
        print("Error al agregar amigo: $e");
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Agregar Ubicación',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF1E3A8A),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextField(_nameController, 'Nombre'),
                const SizedBox(height: 16),
                _buildTextField(_descriptionController, 'Descripción'),
                const SizedBox(height: 20),
                const Text("Puedes seleccionar una o más imagenes. (Máximo 3)"),
                const SizedBox(height: 20),
                Center(
                  child: ImagePickerButtons(
                    onPickImage: _pickImage,
                    onTakePhoto: _pickImageFromCamera,

                  ),
                ),

                const SizedBox(height: 20),
                const SizedBox(height: 20),


                if (_imageFiles.isNotEmpty)
                  Center(
                    child: Wrap(
                      spacing: 10.0,
                      runSpacing: 10.0,
                      children: _imageFiles.map((imageFile) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.file(
                            imageFile,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: _addLocation,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFBB4D00),
                      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Guardar datos',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )

                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Color(0xFF1E3A8A)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color(0xFF1E3A8A),
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color(0xFF1E3A8A),
            width: 2,
          ),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor ingresa $label';
        }
        return null;
      },
    );
  }

}

