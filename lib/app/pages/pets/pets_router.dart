import 'package:a_de_adote/app/pages/pets/pets_controller.dart';
import 'package:a_de_adote/app/pages/pets/pets_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/rest_client/custom_dio.dart';
import '../../repositories/ong/ong_repository.dart';
import '../../repositories/ong/ong_repository_impl.dart';
import '../../repositories/pet/pet_repository.dart';
import '../../repositories/pet/pet_repository_impl.dart';
import '../../services/auth_service.dart';

class PetsRouter {
  PetsRouter._();

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
          Provider<PetsController>(
            create: ((context) => PetsController(
                  context.read<PetRepository>(),
                )),
          ),
        ],
        child: const PetsPage(),
      );
}
