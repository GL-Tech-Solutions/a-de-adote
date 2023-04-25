import 'package:a_de_adote/app/core/exceptions/firestore_exception.dart';
import 'package:a_de_adote/app/models/pet_model.dart';
import 'package:a_de_adote/app/pages/favorite_pets/favorite_pets_state.dart';
import 'package:a_de_adote/app/repositories/pet/pet_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritePetsController extends Cubit<FavoritePetsState> {
  final PetRepository _petRepository;

  FavoritePetsController(this._petRepository)
      : super(FavoritePetsState.initial());

  Future<void> loadFavoritePets(bool showLoading) async {
    try {
      if (showLoading) {
        emit(state.copyWith(status: FavoritePetsStatus.loading));
      }
      SharedPreferences sp = await SharedPreferences.getInstance();
      List<PetModel> listPets = await _petRepository.getPets();
      List<String>? listIds = sp.getStringList('favoriteList');

      listIds = listIds ?? [];
      List<PetModel> listFavoritePets = listPets.where(
        (pet) {
          if (listIds!.contains(pet.id)) {
            return true;
          }
          return false;
        },
      ).toList();

      emit(
        state.copyWith(
          status: FavoritePetsStatus.loaded,
          listFavoritePets: listFavoritePets,
        ),
      );
    } on FirestoreException catch (e) {
      emit(
        state.copyWith(
          status: FavoritePetsStatus.error,
          errorMessage: e.message,
        ),
      );
    }
  }
}
