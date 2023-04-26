import '../../models/ong_model.dart';

abstract class OngRepository {
  Future<bool> verifyCnpjDuplicity(String cnpj);
  Future<OngModel> getOngDataFromWeb(String cnpj);
  Future<List<OngModel>> getOngs();
  Future<OngModel> getOngById(String id);
  Future<OngModel> getCurrentOngUser();
  Future<void> createOng(OngModel ong);
  Future<void> updateOng(OngModel ong);
}
