import 'package:firebase_storage/firebase_storage.dart';

class StorageFirebase {
  static StorageFirebase? _instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  StorageFirebase._();
  static FirebaseStorage get instance {
    _instance ??= StorageFirebase._();
    return _instance!.storage;
  }
}
