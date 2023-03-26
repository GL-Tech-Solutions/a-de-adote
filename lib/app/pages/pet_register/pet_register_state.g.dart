// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet_register_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension PetRegisterStatusMatch on PetRegisterStatus {
  T match<T>(
      {required T Function() unknown,
      required T Function() loading,
      required T Function() petCreated,
      required T Function() imageLoaded,
      required T Function() error}) {
    final v = this;
    if (v == PetRegisterStatus.unknown) {
      return unknown();
    }

    if (v == PetRegisterStatus.loading) {
      return loading();
    }

    if (v == PetRegisterStatus.petCreated) {
      return petCreated();
    }

    if (v == PetRegisterStatus.imageLoaded) {
      return imageLoaded();
    }

    if (v == PetRegisterStatus.error) {
      return error();
    }

    throw Exception(
        'PetRegisterStatus.match failed, found no match for: $this');
  }

  T matchAny<T>(
      {required T Function() any,
      T Function()? unknown,
      T Function()? loading,
      T Function()? petCreated,
      T Function()? imageLoaded,
      T Function()? error}) {
    final v = this;
    if (v == PetRegisterStatus.unknown && unknown != null) {
      return unknown();
    }

    if (v == PetRegisterStatus.loading && loading != null) {
      return loading();
    }

    if (v == PetRegisterStatus.petCreated && petCreated != null) {
      return petCreated();
    }

    if (v == PetRegisterStatus.imageLoaded && imageLoaded != null) {
      return imageLoaded();
    }

    if (v == PetRegisterStatus.error && error != null) {
      return error();
    }

    return any();
  }
}
