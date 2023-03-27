import 'package:a_de_adote/app/pages/pet_register/pet_register_controller.dart';
import 'package:a_de_adote/app/pages/pet_register/pet_register_page.dart';
import 'package:a_de_adote/app/repositories/ong/ong_repository.dart';
import 'package:a_de_adote/app/repositories/ong/ong_repository_impl.dart';
import 'package:a_de_adote/app/repositories/pet/pet_repository_impl.dart';
import 'package:a_de_adote/app/repositories/photos/photos_repository.dart';
import 'package:a_de_adote/app/repositories/photos/photos_repository_impl.dart';
import 'package:a_de_adote/app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../repositories/pet/pet_repository.dart';

class PetRegisterRouter {
  PetRegisterRouter._();

  static Widget get page => MultiProvider(
        providers: [
          Provider<OngRepository>(
            create: ((context) => OngRepositoryImpl(
                  dio: context.read(),
                  auth: context.read<AuthService>(),
                )),
          ),
          Provider<PetRepository>(
            create: ((context) => PetRepositoryImpl(
                  auth: context.read<AuthService>(),
                )),
          ),
          Provider<PhotosRepository>(
            create: ((context) => PhotosRepositoryImpl()),
          ),
          Provider<PetRegisterController>(
            create: ((context) => PetRegisterController(
                  context.read<OngRepository>(),
                  context.read<PetRepository>(),
                  context.read<PhotosRepository>(),
                )),
          ),
        ],
        child: const PetRegisterPage(),
      );
}
