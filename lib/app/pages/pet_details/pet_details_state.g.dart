// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet_details_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension PetDetailsStatusMatch on PetDetailsStatus {
  T match<T>(
      {required T Function() initial,
      required T Function() petLoaded,
      required T Function() petEdited,
      required T Function() petDeleted,
      required T Function() error}) {
    final v = this;
    if (v == PetDetailsStatus.initial) {
      return initial();
    }

    if (v == PetDetailsStatus.petLoaded) {
      return petLoaded();
    }

    if (v == PetDetailsStatus.petEdited) {
      return petEdited();
    }

    if (v == PetDetailsStatus.petDeleted) {
      return petDeleted();
    }

    if (v == PetDetailsStatus.error) {
      return error();
    }

    throw Exception('PetDetailsStatus.match failed, found no match for: $this');
  }

  T matchAny<T>(
      {required T Function() any,
      T Function()? initial,
      T Function()? petLoaded,
      T Function()? petEdited,
      T Function()? petDeleted,
      T Function()? error}) {
    final v = this;
    if (v == PetDetailsStatus.initial && initial != null) {
      return initial();
    }

    if (v == PetDetailsStatus.petLoaded && petLoaded != null) {
      return petLoaded();
    }

    if (v == PetDetailsStatus.petEdited && petEdited != null) {
      return petEdited();
    }

    if (v == PetDetailsStatus.petDeleted && petDeleted != null) {
      return petDeleted();
    }

    if (v == PetDetailsStatus.error && error != null) {
      return error();
    }

    return any();
  }
}
