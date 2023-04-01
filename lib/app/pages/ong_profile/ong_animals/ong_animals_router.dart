import 'package:a_de_adote/app/pages/ong_profile/ong_animals/ong_animals_controller.dart';
import 'package:a_de_adote/app/pages/ong_profile/ong_animals/ong_animals_page.dart';
import 'package:a_de_adote/app/repositories/ong/ong_repository.dart';
import 'package:a_de_adote/app/repositories/ong/ong_repository_impl.dart';
import 'package:a_de_adote/app/repositories/pet/pet_repository.dart';
import 'package:a_de_adote/app/repositories/pet/pet_repository_impl.dart';
import 'package:a_de_adote/app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/rest_client/custom_dio.dart';

class OngAnimalsRouter {
  OngAnimalsRouter._();

  static Widget get page => MultiProvider(
        providers: [
          Provider<OngRepository>(
            create: ((context) => OngRepositoryImpl(
                  dio: context.read<CustomDio>(),
                  auth: context.read<AuthService>(),
                )),
          ),
          Provider<PetRepository>(
            create: ((context) => PetRepositoryImpl(
                  auth: context.read<AuthService>(),
                  ongRepository: context.read<OngRepository>(),
                )),
          ),
          Provider<OngAnimalsController>(
            create: ((context) => OngAnimalsController(
                  context.read<PetRepository>(),
                )),
          ),
        ],
        child: const OngAnimalsPage(),
      );
}
