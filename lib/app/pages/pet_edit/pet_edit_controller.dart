import 'dart:developer';
import 'dart:io';
import 'package:a_de_adote/app/core/exceptions/firestore_exception.dart';
import 'package:a_de_adote/app/pages/pet_edit/pet_edit_state.dart';
import 'package:a_de_adote/app/repositories/photos/photos_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:a_de_adote/app/repositories/pet/pet_repository.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '../../models/pet_model.dart';

class PetEditController extends Cubit<PetEditState> {
  final PetRepository _petRepository;
  final PhotosRepository _photosRepository;

  PetEditController(
    this._petRepository,
    this._photosRepository,
  ) : super(PetEditState.initial());

  updateStateToLoaded() =>
      emit(state.copyWith(status: PetEditStatus.petLoaded));

  Future<void> updatePet(PetModel pet, File? file) async {
    try {
      emit(state.copyWith(status: PetEditStatus.loading));
      if (file != null) {
        String? fotoUrl;
        await _photosRepository.deleteImage(pet.fotoUrl!);
        fotoUrl = await _photosRepository.uploadImagePet(file);
        await _petRepository.updatePet(pet.copyWith(fotoUrl: fotoUrl));
      } else {
        await _petRepository.updatePet(pet);
      }
      emit(state.copyWith(status: PetEditStatus.petUpdated));
    } on FirestoreException catch (e) {
      emit(
        state.copyWith(
          status: PetEditStatus.error,
          errorMessage: e.message,
        ),
      );
    }
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemporary = File(image.path);
      emit(
        state.copyWith(
          status: PetEditStatus.imageUpdated,
          image: imageTemporary,
        ),
      );
    } on PlatformException catch (e, s) {
      log('Ocorreu um erro ao carregar a imagem', error: e, stackTrace: s);
      emit(
        state.copyWith(
          status: PetEditStatus.error,
          errorMessage: 'Ocorreu um erro ao carregar a imagem',
        ),
      );
    }
  }
}
