// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ong_space_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension OngSpaceStatusMatch on OngSpaceStatus {
  T match<T>(
      {required T Function() initial,
      required T Function() loading,
      required T Function() loaded,
      required T Function() fieldUpdated,
      required T Function() error}) {
    final v = this;
    if (v == OngSpaceStatus.initial) {
      return initial();
    }

    if (v == OngSpaceStatus.loading) {
      return loading();
    }

    if (v == OngSpaceStatus.loaded) {
      return loaded();
    }

    if (v == OngSpaceStatus.fieldUpdated) {
      return fieldUpdated();
    }

    if (v == OngSpaceStatus.error) {
      return error();
    }

    throw Exception('OngSpaceStatus.match failed, found no match for: $this');
  }

  T matchAny<T>(
      {required T Function() any,
      T Function()? initial,
      T Function()? loading,
      T Function()? loaded,
      T Function()? fieldUpdated,
      T Function()? error}) {
    final v = this;
    if (v == OngSpaceStatus.initial && initial != null) {
      return initial();
    }

    if (v == OngSpaceStatus.loading && loading != null) {
      return loading();
    }

    if (v == OngSpaceStatus.loaded && loaded != null) {
      return loaded();
    }

    if (v == OngSpaceStatus.fieldUpdated && fieldUpdated != null) {
      return fieldUpdated();
    }

    if (v == OngSpaceStatus.error && error != null) {
      return error();
    }

    return any();
  }
}
