import 'package:a_de_adote/app/pages/ongs/ongs_controller.dart';
import 'package:a_de_adote/app/pages/ongs/ongs_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/rest_client/custom_dio.dart';
import '../../repositories/ong/ong_repository.dart';
import '../../repositories/ong/ong_repository_impl.dart';
import '../../services/auth_service.dart';

class OngsRouter {
  OngsRouter._();

  static Widget get page => MultiProvider(
        providers: [
          Provider<OngRepository>(
            create: (context) => OngRepositoryImpl(
              dio: context.read<CustomDio>(),
              auth: context.read<AuthService>(),
            ),
          ),
          Provider<OngsController>(
            create: (context) => OngsController(
              context.read<OngRepository>(),
            ),
          ),
        ],
        child: const OngsPage(),
      );
}
