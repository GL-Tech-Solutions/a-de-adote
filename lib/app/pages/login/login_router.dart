import 'package:a_de_adote/app/pages/login/login_controller.dart';
import 'package:a_de_adote/app/pages/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginRouter {
  LoginRouter._();

  static Widget get page => MultiProvider(
        providers: [
          Provider<LoginController>(
            create: ((context) => LoginController(
                  context.read(),
                )),
          ),
        ],
        child: const LoginPage(),
      );
}
