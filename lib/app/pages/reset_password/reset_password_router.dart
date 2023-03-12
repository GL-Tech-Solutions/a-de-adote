import 'package:a_de_adote/app/pages/reset_password/reset_password_controller.dart';
import 'package:a_de_adote/app/pages/reset_password/reset_password_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResetPasswordRouter {
  ResetPasswordRouter._();

  static Widget get page => MultiProvider(
        providers: [
          Provider<ResetPasswordController>(
            create: ((context) => ResetPasswordController(
                  context.read(),
                )),
          ),
        ],
        child: const ResetPasswordPage(),
      );
}
