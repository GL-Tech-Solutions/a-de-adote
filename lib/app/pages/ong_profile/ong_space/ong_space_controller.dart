import 'dart:developer';
import 'dart:io';
import 'package:a_de_adote/app/core/exceptions/firestore_exception.dart';
import 'package:a_de_adote/app/models/ong_model.dart';
import 'package:a_de_adote/app/models/pet_model.dart';
import 'package:a_de_adote/app/repositories/ong/ong_repository.dart';
import 'package:a_de_adote/app/repositories/pet/pet_repository.dart';
import 'package:a_de_adote/app/repositories/photos/photos_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';

import 'ong_space_state.dart';

class OngSpaceController extends Cubit<OngSpaceState> {
  final OngRepository _ongRepository;
  final PetRepository _petRepository;
  final PhotosRepository _photosRepository;

  OngSpaceController(
    this._ongRepository,
    this._petRepository,
    this._photosRepository,
  ) : super(const OngSpaceState.initial());

  Future<void> loadOng() async {
    try {
      emit(state.copyWith(status: OngSpaceStatus.loading));
      final ong = await _ongRepository.getCurrentOngUser();
      emit(state.copyWith(status: OngSpaceStatus.loaded, ong: ong));
    } on Exception catch (e, s) {
      log('Erro ao procurar ONG.', error: e, stackTrace: s);
      emit(
        state.copyWith(
            status: OngSpaceStatus.error,
            ong: null,
            errorMesssage: 'Não foi possível encontrar a ONG'),
      );
    }
  }

  Future<void> pickAndSaveImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemporary = File(image.path);
      final imageCompressed = await FlutterImageCompress.compressAndGetFile(
        imageTemporary.path,
        '${imageTemporary.path}_compressed.jpeg',
        minHeight: 480,
        minWidth: 854,
        quality: 90,
      );

      emit(state.copyWith(status: OngSpaceStatus.loading));
      try {
        if (state.ong?.fotoUrl != null) {
          await _photosRepository.deleteImage(state.ong!.fotoUrl!);
        }
        String url = await _photosRepository.uploadImageOng(imageCompressed!);
        await _ongRepository.updateOng(state.ong!.copyWith(fotoUrl: url));
      } on FirestoreException catch (e) {
        emit(
          state.copyWith(
            status: OngSpaceStatus.error,
            errorMesssage: e.message,
          ),
        );
      }
      emit(state.copyWith(status: OngSpaceStatus.fieldUpdated));
    } on PlatformException catch (e, s) {
      log('Ocorreu um erro ao carregar a imagem', error: e, stackTrace: s);
      emit(
        state.copyWith(
          status: OngSpaceStatus.error,
          errorMesssage: 'Ocorreu um erro ao carregar a imagem',
        ),
      );
    }
  }

  Future<void> updateDescriptionOng(String description) async {
    try {
      emit(state.copyWith(status: OngSpaceStatus.loading));
      await _ongRepository
          .updateOng(state.ong!.copyWith(informacoes: description));
      emit(state.copyWith(status: OngSpaceStatus.fieldUpdated));
    } on FirestoreException catch (e) {
      emit(
        state.copyWith(
          status: OngSpaceStatus.error,
          errorMesssage: e.message,
        ),
      );
    }
  }

  Future<void> updateOngData(OngModel ong, bool isNameChanged) async {
    try {
      emit(state.copyWith(status: OngSpaceStatus.loading));
      await _ongRepository.updateOng(ong);
      if (isNameChanged) {
        List<PetModel> listPets = await _petRepository.getCurrentUserPets();
        // ignore: avoid_function_literals_in_foreach_calls
        listPets.forEach(
          (pet) async {
            await _petRepository.updatePet(
              pet.copyWith(ongNome: ong.fantasia),
            );
          },
        );
      }
      emit(state.copyWith(status: OngSpaceStatus.fieldUpdated));
    } on FirestoreException catch (e) {
      emit(
        state.copyWith(
          status: OngSpaceStatus.error,
          errorMesssage: e.message,
        ),
      );
    }
  }

  Future<void> updateOngPix(Map<String, dynamic>? pix) async {
    try {
      if (pix == null) {
        return;
      }
      emit(state.copyWith(status: OngSpaceStatus.loading));
      await _ongRepository.updateOng(state.ong!.copyWith(pix: pix));
      emit(state.copyWith(status: OngSpaceStatus.fieldUpdated));
    } on FirestoreException catch (e) {
      emit(
        state.copyWith(
          status: OngSpaceStatus.error,
          errorMesssage: e.message,
        ),
      );
    }
  }
}
