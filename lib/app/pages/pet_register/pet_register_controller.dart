import 'dart:developer';
import 'dart:io';
import 'package:a_de_adote/app/core/exceptions/firestore_exception.dart';
import 'package:a_de_adote/app/repositories/ong/ong_repository.dart';
import 'package:a_de_adote/app/repositories/photos/photos_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:a_de_adote/app/pages/pet_register/pet_register_state.dart';
import 'package:a_de_adote/app/repositories/pet/pet_repository.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '../../models/pet_model.dart';

class PetRegisterController extends Cubit<PetRegisterState> {
  final OngRepository _ongRepository;
  final PetRepository _petRepository;
  final PhotosRepository _photosRepository;

  PetRegisterController(
    this._ongRepository,
    this._petRepository,
    this._photosRepository,
  ) : super(PetRegisterState.initial());

  Future<void> registerPet(PetModel petModel, File? petPhoto) async {
    try {
      emit(state.copyWith(status: PetRegisterStatus.loading));
      final currentOngUser = await _ongRepository.getCurrentOngUser();
      String? fotoUrl;
      if (petPhoto != null) {
        fotoUrl = await _photosRepository.uploadImagePet(petPhoto);
      }
      await _petRepository.createPet(
        petModel.copyWith(
          ongId: currentOngUser.id,
          ongNome: currentOngUser.fantasia,
          fotoUrl: fotoUrl,
        ),
      );
      emit(state.copyWith(status: PetRegisterStatus.petCreated));
    } on FirestoreException catch (e) {
      emit(
        state.copyWith(
          status: PetRegisterStatus.error,
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
          status: PetRegisterStatus.imageLoaded,
          image: imageTemporary,
        ),
      );
    } on PlatformException catch (e, s) {
      log('Ocorreu um erro ao carregar a imagem', error: e, stackTrace: s);
      emit(
        state.copyWith(
          status: PetRegisterStatus.error,
          errorMessage: 'Ocorreu um erro ao carregar a imagem',
        ),
      );
    }
  }
}
