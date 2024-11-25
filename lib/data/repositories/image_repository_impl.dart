import 'dart:io';
import 'package:image_picker/image_picker.dart';

abstract class ImageRepository {
  Future<File?> pickImageFromCamera();
  Future<File?> pickImageFromGallery();
}

class ImageRepositoryImpl implements ImageRepository {
  final ImagePicker picker;

  ImageRepositoryImpl(this.picker);

  @override
  Future<File?> pickImageFromCamera() async {
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.camera);
      return pickedFile != null ? File(pickedFile.path) : null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Future<File?> pickImageFromGallery() async {
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      return pickedFile != null ? File(pickedFile.path) : null;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
