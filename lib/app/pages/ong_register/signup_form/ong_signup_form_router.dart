import 'package:a_de_adote/app/pages/ong_register/signup_form/ong_signup_form_page.dart';
import 'package:a_de_adote/app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../repositories/ong/ong_repository.dart';
import '../../../repositories/ong/ong_repository_impl.dart';
import 'ong_signup_form_controller.dart';

class OngSignupFormRouter {
  OngSignupFormRouter._();

  static Widget get page => MultiProvider(
        providers: [
          Provider<OngRepository>(
            create: ((context) => OngRepositoryImpl(
                  dio: context.read(),
                  auth: context.read(),
                )),
          ),
          Provider<OngSignupFormController>(
            create: ((context) => OngSignupFormController(
                  context.read<AuthService>(),
                  context.read(),
                )),
          ),
        ],
        child: const ONGSignUpFormPage(),
      );
}
