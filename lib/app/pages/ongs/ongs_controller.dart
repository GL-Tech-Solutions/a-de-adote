import 'package:a_de_adote/app/pages/ongs/ongs_state.dart';
import 'package:a_de_adote/app/repositories/ong/ong_repository.dart';
import 'package:bloc/bloc.dart';

import '../../core/exceptions/firestore_exception.dart';

class OngsController extends Cubit<OngsState> {
  final OngRepository _ongRepository;

  OngsController(
    this._ongRepository,
  ) : super(OngsState.initial());

  Future<void> loadAllOngs() async {
    try {
      emit(state.copyWith(status: OngsStatus.loading));
      final listOngs = await _ongRepository.getOngs();
      emit(
        state.copyWith(
          status: OngsStatus.loaded,
          listOngs: listOngs,
        ),
      );
    } on FirestoreException catch (e) {
      emit(
        state.copyWith(
          status: OngsStatus.error,
          errorMessage: e.message,
        ),
      );
    }
  }
}
