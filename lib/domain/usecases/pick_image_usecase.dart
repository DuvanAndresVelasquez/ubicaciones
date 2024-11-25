import 'dart:io';
import '../../data/repositories/image_repository_impl.dart';


class PickImageFromCamera {
  final ImageRepository repository;

  PickImageFromCamera(this.repository);

  Future<File?> call() async {
    return await repository.pickImageFromCamera();
  }
}

class PickImageFromGallery {
  final ImageRepository repository;

  PickImageFromGallery(this.repository);

  Future<File?> call() async {
    return await repository.pickImageFromGallery();
  }
}
