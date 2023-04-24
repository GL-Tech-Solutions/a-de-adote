// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pets_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension PetsStatusMatch on PetsStatus {
  T match<T>(
      {required T Function() initial,
      required T Function() loading,
      required T Function() loaded,
      required T Function() loadedSearched,
      required T Function() loadedFiltered,
      required T Function() error}) {
    final v = this;
    if (v == PetsStatus.initial) {
      return initial();
    }

    if (v == PetsStatus.loading) {
      return loading();
    }

    if (v == PetsStatus.loaded) {
      return loaded();
    }

    if (v == PetsStatus.loadedSearched) {
      return loadedSearched();
    }

    if (v == PetsStatus.loadedFiltered) {
      return loadedFiltered();
    }

    if (v == PetsStatus.error) {
      return error();
    }

    throw Exception('PetsStatus.match failed, found no match for: $this');
  }

  T matchAny<T>(
      {required T Function() any,
      T Function()? initial,
      T Function()? loading,
      T Function()? loaded,
      T Function()? loadedSearched,
      T Function()? loadedFiltered,
      T Function()? error}) {
    final v = this;
    if (v == PetsStatus.initial && initial != null) {
      return initial();
    }

    if (v == PetsStatus.loading && loading != null) {
      return loading();
    }

    if (v == PetsStatus.loaded && loaded != null) {
      return loaded();
    }

    if (v == PetsStatus.loadedSearched && loadedSearched != null) {
      return loadedSearched();
    }

    if (v == PetsStatus.loadedFiltered && loadedFiltered != null) {
      return loadedFiltered();
    }

    if (v == PetsStatus.error && error != null) {
      return error();
    }

    return any();
  }
}
