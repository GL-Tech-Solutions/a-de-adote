import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:a_de_adote/app/pages/ong_register/cnpj_form/ong_cnpj_form_state.dart';
import '../../../repositories/ong/ong_repository.dart';

class OngCnpjFormController extends Cubit<OngCnpjFormState> {
  final OngRepository _ongRepository;

  OngCnpjFormController(
    this._ongRepository,
  ) : super(const OngCnpjFormState.initial());

  Future<void> loadOng(String cnpj) async {
    try {
      emit(state.copyWith(status: OngCnpjFormStatus.loading));
      final ong = await _ongRepository.getOngDataFromWeb(cnpj);
      emit(state.copyWith(status: OngCnpjFormStatus.loaded, ong: ong));
    } on Exception catch (e, s) {
      log('Erro ao buscar CNPJ', error: e, stackTrace: s);
      emit(
        state.copyWith(
          status: OngCnpjFormStatus.error,
          errorMessage: e.toString().substring(11),
        ),
      );
    }
  }
}
