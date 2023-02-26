import '../../models/ong_model.dart';

abstract class OngRepository {
  Future<OngModel> getOngDataFromWeb(String cnpj);
  Stream<OngModel> getOng(String ongId);
  Future<void> createOng(OngModel ong, String uid);
  Future<void> updateOng(OngModel ong);
}