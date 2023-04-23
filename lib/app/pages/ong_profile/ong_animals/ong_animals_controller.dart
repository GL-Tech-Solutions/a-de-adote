import 'package:a_de_adote/app/core/exceptions/firestore_exception.dart';
import 'package:a_de_adote/app/models/pet_model.dart';
import 'package:bloc/bloc.dart';
import 'package:a_de_adote/app/pages/ong_profile/ong_animals/ong_animals_state.dart';
import 'package:a_de_adote/app/repositories/pet/pet_repository.dart';

class OngAnimalsController extends Cubit<OngAnimalsState> {
  final PetRepository _petRepository;

  OngAnimalsController(
    this._petRepository,
  ) : super(OngAnimalsState.initial());

  Future<void> loadCurrentUserPets() async {
    try {
      emit(state.copyWith(status: OngAnimalStatus.loading));
      final listPets = await _petRepository.getCurrentUserPets();
      emit(
        state.copyWith(
          status: OngAnimalStatus.loaded,
          listPets: listPets,
        ),
      );
    } on FirestoreException catch (e) {
      emit(
        state.copyWith(
          status: OngAnimalStatus.error,
          errorMessage: e.message,
        ),
      );
    }
  }

  Future<void> deletePet(PetModel pet) async {
    try {
      await _petRepository.deletePet(pet);
      emit(state.copyWith(status: OngAnimalStatus.petDeleted));
    } on FirestoreException catch (e) {
      emit(
        state.copyWith(
          status: OngAnimalStatus.error,
          errorMessage: e.message,
        ),
      );
    }
  }

  void loadPetsSearched(String option) {
    emit(state.copyWith(status: OngAnimalStatus.loading));
    if (option == '') {
      emit(
        state.copyWith(
          status: OngAnimalStatus.error,
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
            status: OngAnimalStatus.loadedFiltered,
            listPetsFiltered: listPetsSearched,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: OngAnimalStatus.error,
            errorMessage: 'Não foi encontrado nenhum animal.',
          ),
        );
      }
    }
  }

  void clearPetsSearched() {
    state.listPetsFiltered = [];
    emit(state.copyWith(status: OngAnimalStatus.loaded));
  }
}
