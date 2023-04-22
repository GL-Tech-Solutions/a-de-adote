import 'package:a_de_adote/app/core/ui/widgets/dropdown_ong/dropdown_ong_state.dart';
import 'package:a_de_adote/app/repositories/ong/ong_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../exceptions/firestore_exception.dart';

class DropdownOngController extends Cubit<DropdownOngState> {
  final OngRepository _ongRepository;

  DropdownOngController(this._ongRepository)
      : super(DropdownOngState.initial());

  Future<void> dropdownLoadAllOngs() async {
    try {
      emit(state.copyWith(status: DropdownOngStatus.loading));
      final listOngs = await _ongRepository.getOngs();
      emit(
        state.copyWith(
          status: DropdownOngStatus.loaded,
          listOngs: listOngs,
        ),
      );
    } on FirestoreException catch (e) {
      emit(
        state.copyWith(
          status: DropdownOngStatus.error,
          errorMessage: e.message,
        ),
      );
    }
  }
}
