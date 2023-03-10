// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ong_signup_form_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension OngSignupFormStatusMatch on OngSignupFormStatus {
  T match<T>(
      {required T Function() unknown,
      required T Function() loading,
      required T Function() userCreated,
      required T Function() error}) {
    final v = this;
    if (v == OngSignupFormStatus.unknown) {
      return unknown();
    }

    if (v == OngSignupFormStatus.loading) {
      return loading();
    }

    if (v == OngSignupFormStatus.userCreated) {
      return userCreated();
    }

    if (v == OngSignupFormStatus.error) {
      return error();
    }

    throw Exception(
        'OngSignupFormStatus.match failed, found no match for: $this');
  }

  T matchAny<T>(
      {required T Function() any,
      T Function()? unknown,
      T Function()? loading,
      T Function()? userCreated,
      T Function()? error}) {
    final v = this;
    if (v == OngSignupFormStatus.unknown && unknown != null) {
      return unknown();
    }

    if (v == OngSignupFormStatus.loading && loading != null) {
      return loading();
    }

    if (v == OngSignupFormStatus.userCreated && userCreated != null) {
      return userCreated();
    }

    if (v == OngSignupFormStatus.error && error != null) {
      return error();
    }

    return any();
  }
}
