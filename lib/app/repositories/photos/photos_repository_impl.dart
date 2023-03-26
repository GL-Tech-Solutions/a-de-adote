import 'dart:developer';
import 'dart:io';
import 'package:a_de_adote/app/core/exceptions/firestore_exception.dart';
import 'package:a_de_adote/app/repositories/photos/photos_repository.dart';
import 'package:a_de_adote/app/repositories/storage/storage_firebase.dart';
import 'package:firebase_storage/firebase_storage.dart';

class PhotosRepositoryImpl implements PhotosRepository {
  late FirebaseStorage storage;

  PhotosRepositoryImpl() {
    _startStorage();
  }

  _startStorage() {
    storage = StorageFirebase.instance;
  }

  @override
  Future<String> uploadImageOng(File image) async {
    try {
      String url = '';
      final String path = 'fotos_ongs/${image.hashCode.toString()}';

      final ref = storage.ref().child(path);
      await ref.putFile(image).then(
          (_) async => url = await storage.ref().child(path).getDownloadURL());

      return url;
    } on FirebaseException catch (e, s) {
      log('Ocorreu um erro ao subir a imagem', error: e, stackTrace: s);
      throw FirestoreException(e.message!);
    }
  }

  @override
  Future<String> uploadImagePet(File image) async {
    try {
      String url = '';
      final String path = 'fotos_pets/${image.hashCode.toString()}';

      final ref = storage.ref().child(path);
      await ref.putFile(image).then(
          (_) async => url = await storage.ref().child(path).getDownloadURL());

      return url;
    } on FirebaseException catch (e, s) {
      log('Ocorreu um erro ao subir a imagem', error: e, stackTrace: s);
      throw FirestoreException(e.message!);
    }
  }
}
