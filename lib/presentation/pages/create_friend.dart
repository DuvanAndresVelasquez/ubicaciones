import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:prueba/domain/entities/friend.dart';
import 'package:prueba/domain/usecases/friends/friend_usecases.dart';

import '../../data/datasources/local/database_helper.dart';
import '../../data/datasources/local/friend_local_datasource.dart';
import '../../data/repositories/friends_repsoitory_impl.dart';
import '../../domain/repositories/friend_repository.dart';
import '../stores/friend_store.dart';
import '../viewmodels/image_picker_viewmodel.dart';
import '../widgets/image_picker_buttons.dart';

class AddFriendPage extends StatefulWidget {
  final FriendStore friendStore;

  const AddFriendPage({Key? key, required this.friendStore}) : super(key: key);

  @override
  _AddFriendPageState createState() => _AddFriendPageState();
}

class _AddFriendPageState extends State<AddFriendPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  File? _imageFile;
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
        if (pickedFile != null) {
          _imageFile = File(pickedFile.path);
        } else {
          print('No image selected.');
        }
      });
    } catch (e) {
      print(e);
    }
  }
  Future<void> _pickImage() async {
    try{
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      setState(() {
        if (pickedFile != null) {
          _imageFile = File(pickedFile.path);
        } else {
          print('No image selected.');
        }
      });
    }catch(e){
      print(e);
    }
  }



  Future<void> _addFriend() async {
    if (_formKey.currentState!.validate()) {

      final friend = Friend(
        name: _nameController.text,
        last_name: _lastNameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
        photo: _imageFile != null ? _imageFile!.path : "",
      );

      try {
        await widget.friendStore.agregarAmigo(friend);
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
          'Agregar Amigo',
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
                _buildTextField(_lastNameController, 'Apellido'),
                const SizedBox(height: 16),
                _buildTextField(_emailController, 'Correo Electrónico'),
                const SizedBox(height: 16),
                _buildTextField(_phoneController, 'Teléfono'),
                const SizedBox(height: 20),
                Center(
                  child: ImagePickerButtons(
                    onPickImage: _pickImage,
                    onTakePhoto: _pickImageFromCamera,
                  ),
                ),
                const SizedBox(height: 20),
                if (_imageFile?.path != null && _imageFile?.path != "")
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.file(
                        File(_imageFile!.path),
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: _addFriend,
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
        labelStyle: TextStyle(color: Color(0xFF1E3A8A)), // Azul rey oscuro
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color(0xFF1E3A8A), // Azul rey oscuro
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color(0xFF1E3A8A), // Azul rey oscuro
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

