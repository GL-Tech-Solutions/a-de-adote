import 'dart:developer';

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
      emit(
        state.copyWith(
          status: PetsStatus.loaded,
          listPets: listPets,
        ),
      );
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
            status: PetsStatus.loadedFiltered,
            listPetsFiltered: listPetsSearched,
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

  void clearPetsSearched() {
    state.listPetsFiltered = [];
    emit(state.copyWith(status: PetsStatus.loaded));
  }
}
