import 'dart:developer';

import 'package:a_de_adote/app/core/exceptions/auth_exception.dart';
import 'package:a_de_adote/app/pages/reset_password/reset_password_state.dart';
import 'package:bloc/bloc.dart';

import '../../services/auth_service.dart';

class ResetPasswordController extends Cubit<ResetPasswordState> {
  final AuthService _authService;

  ResetPasswordController(this._authService)
      : super(const ResetPasswordState.initial());

  Future<void> resetPasswordOng(String email) async {
    try {
      emit(state.copyWith(status: ResetPasswordStatus.loading));
      await _authService.resetPassword(email);
      emit(state.copyWith(status: ResetPasswordStatus.loaded));
    } on AuthException catch (e, s) {
      log('Erro ao enviar e-mail de redefinição de senha',
          error: e, stackTrace: s);
      emit(
        state.copyWith(
          status: ResetPasswordStatus.error,
          errorMessage: e.message,
        ),
      );
    }
  }
}
