// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:a_de_adote/app/repositories/ong/ong_repository.dart';
import 'package:a_de_adote/app/services/auth_service.dart';
import '../../../core/exceptions/auth_exception.dart';
import '../../../models/ong_model.dart';
import 'ong_signup_form_state.dart';

class OngSignupFormController extends Cubit<OngSignupFormState> {
  final AuthService _authService;
  final OngRepository _ongRepository;

  OngSignupFormController(
    this._authService,
    this._ongRepository,
  ) : super(const OngSignupFormState.initial());

  Future<void> signUpOng(OngModel ong, String password) async {
    try {
      emit(state.copyWith(status: OngSignupFormStatus.loading));
      await _authService.signUp(email: ong.email, password: password);
      final ongModel = ong.copyWith(id: _authService.ongUser?.uid);
      await _ongRepository.createOng(ongModel);
      emit(state.copyWith(status: OngSignupFormStatus.userCreated));
    } on AuthException catch (e, s) {
      log('Erro ao cadastrar ONG', error: e, stackTrace: s);
      emit(
        state.copyWith(
          status: OngSignupFormStatus.error,
          errorMessage: e.message,
        ),
      );
    }
  }
}
