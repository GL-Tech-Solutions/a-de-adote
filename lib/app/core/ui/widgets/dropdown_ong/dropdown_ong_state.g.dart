// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dropdown_ong_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension DropdownOngStatusMatch on DropdownOngStatus {
  T match<T>(
      {required T Function() initial,
      required T Function() loading,
      required T Function() loaded,
      required T Function() error}) {
    final v = this;
    if (v == DropdownOngStatus.initial) {
      return initial();
    }

    if (v == DropdownOngStatus.loading) {
      return loading();
    }

    if (v == DropdownOngStatus.loaded) {
      return loaded();
    }

    if (v == DropdownOngStatus.error) {
      return error();
    }

    throw Exception(
        'DropdownOngStatus.match failed, found no match for: $this');
  }

  T matchAny<T>(
      {required T Function() any,
      T Function()? initial,
      T Function()? loading,
      T Function()? loaded,
      T Function()? error}) {
    final v = this;
    if (v == DropdownOngStatus.initial && initial != null) {
      return initial();
    }

    if (v == DropdownOngStatus.loading && loading != null) {
      return loading();
    }

    if (v == DropdownOngStatus.loaded && loaded != null) {
      return loaded();
    }

    if (v == DropdownOngStatus.error && error != null) {
      return error();
    }

    return any();
  }
}
