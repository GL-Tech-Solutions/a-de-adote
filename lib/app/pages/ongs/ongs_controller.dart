import 'package:a_de_adote/app/models/ong_model.dart';
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

  void loadOngsSearched(String option) {
    emit(state.copyWith(status: OngsStatus.loading));
    if (option == '') {
      emit(
        state.copyWith(
          status: OngsStatus.error,
          errorMessage: 'Por favor, digite um nome.',
        ),
      );
    } else {
      final listOngsSearched = state.listOngs
          .where((ong) => ong.fantasia.toLowerCase() == option.toLowerCase())
          .toList();
      if (listOngsSearched.isNotEmpty) {
        emit(
          state.copyWith(
            status: OngsStatus.loadedSearched,
            listOngsSearched: listOngsSearched,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: OngsStatus.error,
            errorMessage: 'Não foi encontrada nenhuma ong.',
          ),
        );
      }
    }
  }

  void loadOngsFiltered(Map<String, dynamic>? filters) {
    if (filters == null) {
      clearOngsFiltered();
      return;
    }

    List<OngModel> currentList = state.listOngsSearched.isNotEmpty
        ? state.listOngsSearched
        : state.listOngs;
    List<OngModel> newListFiltered = currentList.where(
      (ong) {
        if (filters['municipio'] != 'Todos') {
          return ong.municipio == filters['municipio'];
        }
        return true;
      },
    ).toList();

    if (newListFiltered.isNotEmpty) {
      emit(
        state.copyWith(
          status: OngsStatus.loadedFiltered,
          listOngsFiltered: newListFiltered,
          currentFilters: filters,
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: OngsStatus.error,
          errorMessage: 'Não foi possível encontrar nenhuma ong.',
        ),
      );
    }
  }

  void clearOngsSearched() {
    state.listOngsSearched = [];
    emit(state.copyWith(status: OngsStatus.loaded));
  }

  void clearOngsFiltered() {
    state.listOngsFiltered = [];
    state.currentFilters = null;
    emit(
      state.copyWith(status: OngsStatus.loaded),
    );
  }
}
