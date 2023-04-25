import 'package:a_de_adote/app/models/pet_model.dart';
import 'package:a_de_adote/app/pages/pet_details/pet_details_controller.dart';
import 'package:a_de_adote/app/pages/pet_details/pet_details_page.dart';
import 'package:a_de_adote/app/repositories/pet/pet_repository.dart';
import 'package:a_de_adote/app/repositories/pet/pet_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/auth_service.dart';

class PetDetailsRouter {
  final PetModel pet;
  final bool? isEditable;

  PetDetailsRouter({
    required this.pet,
    this.isEditable,
  });

  Widget get page => MultiProvider(
        providers: [
          Provider<PetRepository>(
            create: ((context) => PetRepositoryImpl(
                  auth: context.read<AuthService>(),
                )),
          ),
          Provider<PetDetailsController>(
            create: ((context) => PetDetailsController(
                  context.read<PetRepository>(),
                )),
          ),
        ],
        child: PetDetailsPage(
          pet: pet,
          isEditable: isEditable,
        ),
      );
}
