import 'package:a_de_adote/app/pages/pet_details/pet_details_state.dart';
import 'package:a_de_adote/app/repositories/pet/pet_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/exceptions/firestore_exception.dart';
import '../../models/pet_model.dart';

class PetDetailsController extends Cubit<PetDetailsState> {
  final PetRepository _petRepository;

  PetDetailsController(this._petRepository)
      : super(const PetDetailsState.initial());

  void loadPetState(PetModel petModel) {
    emit(
      state.copyWith(
        status: PetDetailsStatus.petLoaded,
        pet: petModel,
      ),
    );
  }

  void petEdited(PetModel petModel) {
    emit(
      state.copyWith(
        status: PetDetailsStatus.petEdited,
        pet: petModel,
      ),
    );
  }

  Future<void> deletePet(PetModel pet) async {
    try {
      await _petRepository.deletePet(pet);
      emit(state.copyWith(status: PetDetailsStatus.petDeleted));
    } on FirestoreException catch (e) {
      emit(
        state.copyWith(
          status: PetDetailsStatus.error,
          errorMessage: e.message,
        ),
      );
    }
  }
}
