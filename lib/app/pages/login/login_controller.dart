import 'dart:developer';

import 'package:a_de_adote/app/core/exceptions/auth_exception.dart';
import 'package:a_de_adote/app/pages/login/login_state.dart';
import 'package:a_de_adote/app/services/auth_service.dart';
import 'package:bloc/bloc.dart';

class LoginController extends Cubit<LoginState> {
  final AuthService _authService;

  LoginController(this._authService) : super(const LoginState.initial());

  Future<void> loginOng(String email, String password) async {
    try {
      emit(state.copyWith(status: LoginStatus.loading));
      await _authService.login(email: email, password: password);
      emit(state.copyWith(status: LoginStatus.loaded));
    } on AuthException catch (e, s) {
      log('Erro ao logar', error: e, stackTrace: s);
      emit(
        state.copyWith(
          status: LoginStatus.error,
          errorMessage: e.message,
        ),
      );
    }
  }
}
