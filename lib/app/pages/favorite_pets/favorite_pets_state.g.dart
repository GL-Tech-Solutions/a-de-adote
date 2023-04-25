// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_pets_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension FavoritePetsStatusMatch on FavoritePetsStatus {
  T match<T>(
      {required T Function() initial,
      required T Function() loading,
      required T Function() loaded,
      required T Function() error}) {
    final v = this;
    if (v == FavoritePetsStatus.initial) {
      return initial();
    }

    if (v == FavoritePetsStatus.loading) {
      return loading();
    }

    if (v == FavoritePetsStatus.loaded) {
      return loaded();
    }

    if (v == FavoritePetsStatus.error) {
      return error();
    }

    throw Exception(
        'FavoritePetsStatus.match failed, found no match for: $this');
  }

  T matchAny<T>(
      {required T Function() any,
      T Function()? initial,
      T Function()? loading,
      T Function()? loaded,
      T Function()? error}) {
    final v = this;
    if (v == FavoritePetsStatus.initial && initial != null) {
      return initial();
    }

    if (v == FavoritePetsStatus.loading && loading != null) {
      return loading();
    }

    if (v == FavoritePetsStatus.loaded && loaded != null) {
      return loaded();
    }

    if (v == FavoritePetsStatus.error && error != null) {
      return error();
    }

    return any();
  }
}
