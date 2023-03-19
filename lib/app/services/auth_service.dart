import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../core/exceptions/auth_exception.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? ongUser;

  AuthService() {
    _authCheck();
  }

  _authCheck() {
    _auth.authStateChanges().listen(
      (User? user) {
        ongUser = (user == null) ? null : user;
        notifyListeners();
      },
    );
  }

  _getUser() {
    ongUser = _auth.currentUser;
    log(ongUser?.uid ?? 'Não há usuário');
    notifyListeners();
  }

  Future<void> signUp({required String email, required String password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      _getUser();
    } on FirebaseAuthException catch (e, s) {
      log('Erro ao cadastrar', error: e, stackTrace: s);
      if (e.code == 'weak-password') {
        throw AuthException('A senha é muito fraca!');
      } else if (e.code == 'email-already-in-use') {
        throw AuthException('Este e-mail já está em uso.');
      } else if (e.code == 'invalid-email') {
        throw AuthException('E-mail inválido.');
      } else {
        throw AuthException('E-mail ou senha inválidos.');
      }
    } catch (e, s) {
      log('Erro ao logar', error: e, stackTrace: s);
      throw AuthException('Houve um problema. Tenta novamente mais tarde.');
    }
  }

  Future<void> login({required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _getUser();
    } on FirebaseAuthException catch (e, s) {
      log('Erro ao logar', error: e, stackTrace: s);
      if (e.code == 'user-not-found') {
        throw AuthException('E-mail não encontrado. Cadastre-se.');
      } else if (e.code == 'wrong-password') {
        throw AuthException('Senha incorreta. Tente novamente.');
      } else {
        throw AuthException('E-mail ou senha incorretos.');
      }
    } catch (e, s) {
      log('Erro ao logar', error: e, stackTrace: s);
      throw AuthException('Houve um problema. Tenta novamente mais tarde.');
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e, s) {
      log('Erro ao enviar e-mail de redefinição de senha.',
          error: e, stackTrace: s);
      if (e.code == 'invalid-email') {
        throw AuthException(
            'E-mail inválido. Por favor, verifique o e-email inserido.');
      } else if (e.code == 'user-not-found') {
        throw AuthException('Nenhum usuário encontrado com este e-mail.');
      } else {
        throw AuthException('Houve um problema. Tenta novamente mais tarde.');
      }
    } catch (e, s) {
      log('Erro ao enviar e-mail de redefinição de senha.',
          error: e, stackTrace: s);
      throw AuthException('Houve um problema. Tenta novamente mais tarde.');
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    ongUser = null;
    _getUser();
  }
}
