import 'dart:developer';
import 'package:a_de_adote/app/core/constantes/labels.dart';
import 'package:a_de_adote/app/repositories/database/db_firestore.dart';
import 'package:a_de_adote/app/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:a_de_adote/app/core/rest_client/custom_dio.dart';
import '../../core/exceptions/firestore_exception.dart';
import '../../models/ong_model.dart';
import 'ong_repository.dart';

class OngRepositoryImpl implements OngRepository {
  final CustomDio dio;
  final AuthService auth;
  late FirebaseFirestore db;

  OngRepositoryImpl({
    required this.dio,
    required this.auth,
  }) {
    _startFirestore();
  }

  _startFirestore() {
    db = DbFirestore.instance;
  }

  @override
  Future<bool> verifyCnpjDuplicity(String cnpj) async {
    final snapshot =
        await db.collection('ong').where('cnpj', isEqualTo: cnpj).get();
    if (snapshot.docs.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<OngModel> getOngDataFromWeb(String cnpj) async {
    try {
      final result = await dio.get('https://receitaws.com.br/v1/cnpj/$cnpj');
      if (result.data['situacao'] == 'ATIVA' &&
          result.data['status'] != 'ERROR') {
        return OngModel.fromMap(result.data);
      } else if (result.data['situacao'] != 'ATIVA' &&
          result.data['status'] != 'ERROR') {
        throw Exception(Labels.cnpjInapto);
      } else {
        throw Exception(Labels.cnpjNaoEncontrado);
      }
    } on DioError catch (e) {
      log(Labels.erroCnpj, error: e);
      if (e.response?.statusCode == 429) {
        return throw Exception(Labels.servidoresOcupados);
      }
      if (e.type == DioErrorType.connectionTimeout ||
          e.type == DioErrorType.sendTimeout ||
          e.type == DioErrorType.receiveTimeout) {
        return throw Exception(Labels.timeout);
      }
      if (e.type == DioErrorType.unknown) {
        return throw Exception(Labels.erroCnpj);
      }
      rethrow;
    }
  }

  @override
  Future<void> createOng(OngModel ong) async {
    try {
      await db.collection('ong').doc(ong.id).set(ong.toMap());
    } on FirebaseException catch (e, s) {
      log(Labels.erroDocOng, error: e, stackTrace: s);
      throw FirestoreException(Labels.erroCadastro);
    }
  }

  @override
  Future<List<OngModel>> getOngs() async {
    final snapshot = await db.collection('ong').get();
    final ongs = snapshot.docs
        .map(
          (ong) => OngModel.fromMap(ong.data()),
        )
        .toList();
    return ongs;
  }

  @override
  Future<OngModel> getOngById(String id) async {
    try {
      final snapshot = await db.collection('ong').doc(id).get();
      if (snapshot.exists) {
        final ong = OngModel.fromMap(snapshot.data()!);
        return ong;
      } else {
        throw FirestoreException(Labels.ongNaoEncontrada);
      }
    } on FirebaseException catch (e, s) {
      log('Ocorreu um erro ao pesquisar a ONG.', error: e, stackTrace: s);
      throw FirestoreException('Ocorreu um erro ao pesquisar a ONG.');
    }
  }

  @override
  Future<OngModel> getCurrentOngUser() async {
    try {
      if (auth.ongUser != null) {
        final snapshot =
            await db.collection('ong').doc(auth.ongUser!.uid).get();
        final currentOngUser = OngModel.fromMap(snapshot.data()!);
        return currentOngUser;
      } else {
        throw FirestoreException(Labels.ongNaoEncontrada);
      }
    } on FirebaseException catch (e, s) {
      log('Ocorreu um erro ao pesquisar a ONG.', error: e, stackTrace: s);
      throw FirestoreException('Ocorreu um erro ao pesquisar a ONG.');
    }
  }

  @override
  Future<void> updateOng(OngModel ong) async {
    try {
      return db.collection('ong').doc(ong.id).update(ong.toMap());
    } on FirebaseException catch (e, s) {
      log(Labels.erroUpdateOng, error: e, stackTrace: s);
      throw FirestoreException(Labels.erroUpdateOng);
    }
  }
}
