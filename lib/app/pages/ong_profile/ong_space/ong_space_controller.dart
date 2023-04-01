import 'dart:developer';
import 'dart:io';
import 'package:a_de_adote/app/core/exceptions/firestore_exception.dart';
import 'package:a_de_adote/app/repositories/ong/ong_repository.dart';
import 'package:a_de_adote/app/repositories/photos/photos_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'ong_space_state.dart';

class OngSpaceController extends Cubit<OngSpaceState> {
  final OngRepository _ongRepository;
  final PhotosRepository _photosRepository;

  OngSpaceController(this._ongRepository, this._photosRepository)
      : super(const OngSpaceState.initial());

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
      emit(state.copyWith(status: OngSpaceStatus.loading));
      try {
        if (state.ong?.fotoUrl != null) {
          await _photosRepository.deleteImage(state.ong!.fotoUrl!);
        }
        String url = await _photosRepository.uploadImageOng(imageTemporary);
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
}
