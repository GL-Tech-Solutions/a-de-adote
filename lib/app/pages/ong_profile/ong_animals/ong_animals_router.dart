import 'package:a_de_adote/app/pages/ong_profile/ong_animals/ong_animals_controller.dart';
import 'package:a_de_adote/app/pages/ong_profile/ong_animals/ong_animals_page.dart';
import 'package:a_de_adote/app/repositories/pet/pet_repository.dart';
import 'package:a_de_adote/app/repositories/pet/pet_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OngAnimalsRouter {
  OngAnimalsRouter._();

  static Widget get page => MultiProvider(
        providers: [
          Provider<PetRepository>(
            create: ((context) => PetRepositoryImpl(
                  auth: context.read(),
                )),
          ),
          Provider<OngAnimalsController>(
            create: ((context) => OngAnimalsController(
                  context.read(),
                )),
          ),
        ],
        child: const OngAnimalsPage(),
      );
}
