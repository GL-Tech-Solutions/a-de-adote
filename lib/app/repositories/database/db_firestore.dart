import 'package:cloud_firestore/cloud_firestore.dart';

class DbFirestore {
  static DbFirestore? _instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  DbFirestore._();
  static FirebaseFirestore get instance {
    _instance ??= DbFirestore._();
    return _instance!.firestore;
  }
}
