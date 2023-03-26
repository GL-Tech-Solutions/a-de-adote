// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ong_animals_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension OngAnimalStatusMatch on OngAnimalStatus {
  T match<T>(
      {required T Function() initial,
      required T Function() loading,
      required T Function() loaded,
      required T Function() error}) {
    final v = this;
    if (v == OngAnimalStatus.initial) {
      return initial();
    }

    if (v == OngAnimalStatus.loading) {
      return loading();
    }

    if (v == OngAnimalStatus.loaded) {
      return loaded();
    }

    if (v == OngAnimalStatus.error) {
      return error();
    }

    throw Exception('OngAnimalStatus.match failed, found no match for: $this');
  }

  T matchAny<T>(
      {required T Function() any,
      T Function()? initial,
      T Function()? loading,
      T Function()? loaded,
      T Function()? error}) {
    final v = this;
    if (v == OngAnimalStatus.initial && initial != null) {
      return initial();
    }

    if (v == OngAnimalStatus.loading && loading != null) {
      return loading();
    }

    if (v == OngAnimalStatus.loaded && loaded != null) {
      return loaded();
    }

    if (v == OngAnimalStatus.error && error != null) {
      return error();
    }

    return any();
  }
}
