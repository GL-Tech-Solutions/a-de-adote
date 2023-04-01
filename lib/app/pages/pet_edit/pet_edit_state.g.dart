// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet_edit_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension PetEditStatusMatch on PetEditStatus {
  T match<T>(
      {required T Function() initial,
      required T Function() petLoaded,
      required T Function() loading,
      required T Function() petUpdated,
      required T Function() imageUpdated,
      required T Function() error}) {
    final v = this;
    if (v == PetEditStatus.initial) {
      return initial();
    }

    if (v == PetEditStatus.petLoaded) {
      return petLoaded();
    }

    if (v == PetEditStatus.loading) {
      return loading();
    }

    if (v == PetEditStatus.petUpdated) {
      return petUpdated();
    }

    if (v == PetEditStatus.imageUpdated) {
      return imageUpdated();
    }

    if (v == PetEditStatus.error) {
      return error();
    }

    throw Exception('PetEditStatus.match failed, found no match for: $this');
  }

  T matchAny<T>(
      {required T Function() any,
      T Function()? initial,
      T Function()? petLoaded,
      T Function()? loading,
      T Function()? petUpdated,
      T Function()? imageUpdated,
      T Function()? error}) {
    final v = this;
    if (v == PetEditStatus.initial && initial != null) {
      return initial();
    }

    if (v == PetEditStatus.petLoaded && petLoaded != null) {
      return petLoaded();
    }

    if (v == PetEditStatus.loading && loading != null) {
      return loading();
    }

    if (v == PetEditStatus.petUpdated && petUpdated != null) {
      return petUpdated();
    }

    if (v == PetEditStatus.imageUpdated && imageUpdated != null) {
      return imageUpdated();
    }

    if (v == PetEditStatus.error && error != null) {
      return error();
    }

    return any();
  }
}
