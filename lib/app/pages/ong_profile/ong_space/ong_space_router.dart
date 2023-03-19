import 'package:a_de_adote/app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../repositories/ong/ong_repository.dart';
import '../../../repositories/ong/ong_repository_impl.dart';
import 'ong_space_controller.dart';
import 'ong_space_page.dart';

class OngSpaceRouter {
  OngSpaceRouter._();

  static Widget get page => MultiProvider(
        providers: [
          Provider<OngRepository>(
            create: ((context) => OngRepositoryImpl(
                  dio: context.read(),
                  auth: context.read<AuthService>(),
                )),
          ),
          Provider<OngSpaceController>(
            create: ((context) => OngSpaceController(
                  context.read(),
                )),
          ),
        ],
        child: const OngSpacePage(),
      );
}
