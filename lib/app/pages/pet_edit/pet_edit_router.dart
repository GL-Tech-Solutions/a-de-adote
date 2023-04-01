import 'package:a_de_adote/app/pages/pet_edit/pet_edit_controller.dart';
import 'package:a_de_adote/app/pages/pet_edit/pet_edit_page.dart';
import 'package:a_de_adote/app/repositories/ong/ong_repository.dart';
import 'package:a_de_adote/app/repositories/ong/ong_repository_impl.dart';
import 'package:a_de_adote/app/repositories/pet/pet_repository_impl.dart';
import 'package:a_de_adote/app/repositories/photos/photos_repository.dart';
import 'package:a_de_adote/app/repositories/photos/photos_repository_impl.dart';
import 'package:a_de_adote/app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../repositories/pet/pet_repository.dart';

class PetEditRouter {
  PetEditRouter._();

  static Widget get page => MultiProvider(
        providers: [
          Provider<PetRepository>(
            create: ((context) => PetRepositoryImpl(
                  auth: context.read<AuthService>(),
                )),
          ),
          Provider<PhotosRepository>(
            create: ((context) => PhotosRepositoryImpl()),
          ),
          Provider<PetEditController>(
            create: ((context) => PetEditController(
                  context.read<PetRepository>(),
                  context.read<PhotosRepository>(),
                )),
          ),
        ],
        child: const PetEditPage(),
      );
}
