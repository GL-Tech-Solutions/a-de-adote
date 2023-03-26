import 'dart:io';

abstract class PhotosRepository {
  Future<String> uploadImageOng(File image);
  Future<String> uploadImagePet(File image);
}
