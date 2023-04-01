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
}
