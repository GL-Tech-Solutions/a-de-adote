import 'package:a_de_adote/app/pages/favorite_pets/favorite_pets_controller.dart';
import 'package:a_de_adote/app/pages/favorite_pets/favorite_pets_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../repositories/pet/pet_repository.dart';
import '../../repositories/pet/pet_repository_impl.dart';
import '../../services/auth_service.dart';

class FavoritePetsRouter {
  FavoritePetsRouter._();

  static Widget get page => MultiProvider(
        providers: [
          Provider<PetRepository>(
            create: ((context) => PetRepositoryImpl(
                  auth: context.read<AuthService>(),
                )),
          ),
          Provider<FavoritePetsController>(
            create: ((context) => FavoritePetsController(
                  context.read<PetRepository>(),
                )),
          ),
        ],
        child: const FavoritePetsPage(),
      );
}
