import 'dart:developer';
import 'package:a_de_adote/app/pages/ong_space/ong_space_state.dart';
import 'package:a_de_adote/app/repositories/ong/ong_repository.dart';
import 'package:bloc/bloc.dart';

class OngSpaceController extends Cubit<OngSpaceState> {
  final OngRepository _ongRepository;

  OngSpaceController(this._ongRepository)
      : super(const OngSpaceState.initial());

  Future<void> loadOng() async {
    try {
      emit(state.copyWith(status: OngSpaceStatus.loading));
      final ong = await _ongRepository.getCurrentOngUser();
      emit(state.copyWith(status: OngSpaceStatus.loaded, ong: ong));
    } on Exception catch (e, s) {
      log('Erro ao procurar ONG.', error: e, stackTrace: s);
      emit(
        state.copyWith(
            status: OngSpaceStatus.error,
            ong: null,
            errorMesssage: 'Não foi possível encontrar a ONG'),
      );
    }
  }
}
