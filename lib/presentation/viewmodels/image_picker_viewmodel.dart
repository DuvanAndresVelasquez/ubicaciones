import 'dart:io';
import '../../domain/usecases/pick_image_usecase.dart';

class ImagePickerViewModel {
  final PickImageFromCamera _pickImageFromCameraUseCase;
  final PickImageFromGallery _pickImageFromGalleryUseCase;

  File? selectedImage;

  ImagePickerViewModel(
      this._pickImageFromCameraUseCase, this._pickImageFromGalleryUseCase);

  Future<void> pickImageUsingCamera() async {
    selectedImage = await _pickImageFromCameraUseCase();
  }

  Future<void> pickImageUsingGallery() async {
    selectedImage = await _pickImageFromGalleryUseCase();
  }
}
