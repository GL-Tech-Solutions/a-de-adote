import 'dart:developer';
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
  late FirebaseFirestore db;
  late AuthService auth;

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
  Future<OngModel> getOngDataFromWeb(String cnpj) async {
    try {
      final result = await dio.get('https://receitaws.com.br/v1/cnpj/$cnpj');
      if (result.data['situacao'] == 'ATIVA' &&
          result.data['status'] != 'ERROR') {
        return OngModel.fromMap(result.data);
      } else if (result.data['situacao'] != 'ATIVA' &&
          result.data['status'] != 'ERROR') {
        throw Exception(
            'CNPJ com situação inapta. Por favor, insira um CNPJ ativo.');
      } else {
        throw Exception('CNPJ não encontrado.');
      }
    } on DioError catch (e) {
      log('Erro ao buscar CNPJ', error: e);
      if (e.response?.statusCode == 429) {
        return throw Exception(
            'Servidores ocupados. Tente novamente daqui 1 min.');
      }
      if (e.type == DioErrorType.connectionTimeout ||
          e.type == DioErrorType.sendTimeout ||
          e.type == DioErrorType.receiveTimeout) {
        return throw Exception('Tempo de busca excedido. Tente novamente.');
      }
      if (e.type == DioErrorType.unknown) {
        return throw Exception('Erro ao buscar CNPJ.');
      }
      rethrow;
    }
  }

  @override
  Future<void> createOng(OngModel ong) async {
    try {
      await db.collection('ong').doc(ong.id).set(ong.toMap());
    } on FirebaseException catch (e, s) {
      log('Erro ao criar documento ong', error: e, stackTrace: s);
      throw FirestoreException('Erro ao cadastrar.');
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
  Future<OngModel> getCurrentOngUser() async {
    if (auth.ongUser != null) {
      final snapshot = await db
          .collection('ong')
          .where('id', isEqualTo: auth.ongUser!.uid)
          .get();
      final currentOngUser = OngModel.fromMap(snapshot.docs.last.data());
      return currentOngUser;
    } else {
      throw Exception('Não foi possível encontar a ONG');
    }
  }

  @override
  Future<void> updateOng(OngModel ong) async {
    try {
      return db.collection('ong').doc(ong.id).update(ong.toMap()).then(
            (_) => log('User document updated.'),
          );
    } on FirebaseException catch (e, s) {
      log('Erro ao atualizar documento ong', error: e, stackTrace: s);
      throw FirestoreException('Erro ao atualizar ong.');
    }
  }
}
