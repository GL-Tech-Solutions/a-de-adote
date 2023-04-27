import 'package:a_de_adote/app/core/ui/helpers/filters_state.dart';
import 'package:a_de_adote/app/models/pet_model.dart';
import 'package:a_de_adote/app/pages/pets/pets_state.dart';
import 'package:a_de_adote/app/repositories/pet/pet_repository.dart';
import 'package:bloc/bloc.dart';
import '../../core/exceptions/firestore_exception.dart';

class PetsController extends Cubit<PetsState> {
  final PetRepository _petRepository;

  PetsController(
    this._petRepository,
  ) : super(PetsState.initial());

  Future<void> loadAllPets() async {
    try {
      emit(state.copyWith(status: PetsStatus.loading));
      final listPets = await _petRepository.getPets();
      state.listPets = listPets;
      if (FiltersState.petCurrentFilters == null) {
        emit(state.copyWith(status: PetsStatus.loaded));
      } else {
        loadPetsFiltered(FiltersState.petCurrentFilters);
        if (state.status == PetsStatus.error) {
          clearPetsFiltered();
        }
      }
    } on FirestoreException catch (e) {
      emit(
        state.copyWith(
          status: PetsStatus.error,
          errorMessage: e.message,
        ),
      );
    }
  }

  void loadPetsSearched(String option) {
    clearPetsFiltered();
    emit(state.copyWith(status: PetsStatus.loading));
    if (option == '') {
      emit(
        state.copyWith(
          status: PetsStatus.error,
          errorMessage: 'Por favor, digite um nome.',
        ),
      );
    } else {
      final listPetsSearched = state.listPets
          .where((pet) => pet.nome.toLowerCase() == option.toLowerCase())
          .toList();
      if (listPetsSearched.isNotEmpty) {
        emit(
          state.copyWith(
            status: PetsStatus.loadedSearched,
            listPetsSearched: listPetsSearched,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: PetsStatus.error,
            errorMessage: 'Não foi encontrado nenhum animal.',
          ),
        );
      }
    }
  }

  void loadPetsFiltered(Map<String, dynamic>? filters) {
    if (filters == null) {
      clearPetsFiltered();
      return;
    }

    List<PetModel> currentList = state.listPetsSearched.isNotEmpty
        ? state.listPetsSearched
        : state.listPets;
    List<PetModel> newListFiltered = currentList.where(
      (pet) {
        if (filters['ong'] != 'Todas') {
          return pet.ongId == filters['ong'];
        }
        return true;
      },
    ).where(
      (pet) {
        if ((filters['dog'] == false) &&
            (filters['cat'] == false) &&
            (filters['bird'] == false) &&
            (filters['other'] == false)) {
          return true;
        }

        return (filters['dog'] ? pet.especie == 'Cachorro' : false) ||
            (filters['cat'] ? pet.especie == 'Gato' : false) ||
            (filters['bird'] ? pet.especie == 'Pássaro' : false) ||
            (filters['other'] ? pet.especie == 'Outro' : false);
      },
    ).where(
      (pet) {
        if (pet.idadeAproximada
                .replaceAll(RegExp('[0-9]'), '')
                .replaceAll(' ', '') ==
            'meses') {
          return true;
        }
        return int.parse(
              pet.idadeAproximada.replaceAll(RegExp(r'[^0-9]'), ''),
            ) <=
            filters['idadeMaxima'];
      },
    ).where(
      (pet) {
        if (filters['sexo'] == 1) {
          return pet.sexo == 'Masculino';
        } else if (filters['sexo'] == 2) {
          return pet.sexo == 'Feminino';
        } else {
          return true;
        }
      },
    ).where(
      (pet) {
        if ((filters['mini'] == false) &&
            (filters['pequeno'] == false) &&
            (filters['medio'] == false) &&
            (filters['grande'] == false)) {
          return true;
        }

        return (filters['mini'] ? pet.porte == 'Mini' : false) ||
            (filters['pequeno'] ? pet.porte == 'Pequeno' : false) ||
            (filters['medio'] ? pet.porte == 'Médio' : false) ||
            (filters['grande'] ? pet.porte == 'Grande' : false);
      },
    ).toList();

    if (newListFiltered.isNotEmpty) {
      emit(
        state.copyWith(
          status: PetsStatus.loadedFiltered,
          listPetsFiltered: newListFiltered,
          currentFilters: filters,
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: PetsStatus.error,
          errorMessage: 'Não foi possível encontrar nenhum animal.',
        ),
      );
    }
  }

  void clearPetsSearched() {
    state.listPetsSearched = [];
    emit(state.copyWith(status: PetsStatus.loaded));
  }

  void clearPetsFiltered() {
    state.listPetsFiltered = [];
    state.currentFilters = null;
    FiltersState.petCurrentFilters = null;
    emit(
      state.copyWith(status: PetsStatus.loaded),
    );
  }
}
