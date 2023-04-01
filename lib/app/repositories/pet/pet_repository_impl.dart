import 'dart:convert';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:a_de_adote/app/models/pet_model.dart';
import 'package:a_de_adote/app/repositories/pet/pet_repository.dart';
import 'package:crypto/crypto.dart';
import '../../core/exceptions/firestore_exception.dart';
import '../../services/auth_service.dart';
import '../database/db_firestore.dart';

class PetRepositoryImpl implements PetRepository {
  late FirebaseFirestore db;
  final AuthService auth;

  PetRepositoryImpl({
    required this.auth,
  }) {
    _startFirestore();
  }

  _startFirestore() {
    db = DbFirestore.instance;
  }

  /*@override
  Future<List<PetModel>> getPets() {
   
  }*/

  String generateIdPet(String imageUrl) {
    var bytes = utf8.encode(imageUrl);
    var id = md5.convert(bytes);
    return id.toString();
  }

  @override
  Future<List<PetModel>> getCurrentUserPets() async {
    try {
      List<PetModel> listaPets = [];
      final snapshot =
          await db.collection('ong/${auth.ongUser?.uid}/animais').get();
      if (snapshot.docs.isNotEmpty) {
        listaPets = snapshot.docs
            .map(
              (pet) => PetModel.fromMap(
                pet.data(),
              ),
            )
            .toList();
      }
      return listaPets;
    } on FirebaseException catch (e, s) {
      log('Houve um erro ao consultar os pets deste usuário.',
          error: e, stackTrace: s);
      throw FirestoreException(
          'Houve um erro ao consultar os animais. Por favor, tente novamente mais tarde.');
    }
  }

  @override
  Future<void> createPet(PetModel pet) async {
    try {
      String id = generateIdPet(pet.fotoUrl!);
      await db
          .collection('ong/${auth.ongUser?.uid}/animais')
          .doc(id)
          .set(pet.copyWith(id: id).toMap());
    } on FirebaseException catch (e, s) {
      log('Houve um erro ao cadastrar o pet.', error: e, stackTrace: s);
      throw FirestoreException(
          'Houve um erro ao cadastrar o pet. Por favor, tente novamente mais tarde.');
    }
  }

  @override
  Future<void> deletePet(PetModel pet) async {
    try {
      await db
          .collection('ong/${auth.ongUser?.uid}/animais')
          .doc(pet.id)
          .delete();
    } on FirebaseException catch (e, s) {
      log('Houve um erro ao excluir o pet.', error: e, stackTrace: s);
      throw FirestoreException(
          'Houve um erro ao excluir o pet. Por favor, tente novamente mais tarde.');
    }
  }

  @override
  Future<void> updatePet(PetModel pet) async {
    try {
      await db
          .collection('ong/${auth.ongUser?.uid}/animais')
          .doc(pet.id)
          .update(pet.toMap());
    } on FirebaseException catch (e, s) {
      log('Houve um erro ao atualizar o pet.', error: e, stackTrace: s);
      throw FirestoreException(
          'Houve um erro ao atualizar o pet. Por favor, tente novamente mais tarde.');
    }
  }
}
