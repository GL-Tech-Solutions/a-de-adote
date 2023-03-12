// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_password_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension ResetPasswordStatusMatch on ResetPasswordStatus {
  T match<T>(
      {required T Function() initial,
      required T Function() loading,
      required T Function() loaded,
      required T Function() error}) {
    final v = this;
    if (v == ResetPasswordStatus.initial) {
      return initial();
    }

    if (v == ResetPasswordStatus.loading) {
      return loading();
    }

    if (v == ResetPasswordStatus.loaded) {
      return loaded();
    }

    if (v == ResetPasswordStatus.error) {
      return error();
    }

    throw Exception(
        'ResetPasswordStatus.match failed, found no match for: $this');
  }

  T matchAny<T>(
      {required T Function() any,
      T Function()? initial,
      T Function()? loading,
      T Function()? loaded,
      T Function()? error}) {
    final v = this;
    if (v == ResetPasswordStatus.initial && initial != null) {
      return initial();
    }

    if (v == ResetPasswordStatus.loading && loading != null) {
      return loading();
    }

    if (v == ResetPasswordStatus.loaded && loaded != null) {
      return loaded();
    }

    if (v == ResetPasswordStatus.error && error != null) {
      return error();
    }

    return any();
  }
}
