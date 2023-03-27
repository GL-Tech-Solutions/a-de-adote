import 'package:a_de_adote/app/core/ui/widgets/standard_appbar.dart';
import 'package:a_de_adote/app/core/ui/widgets/standard_drawer.dart';
import 'package:a_de_adote/app/models/pet_model.dart';
import 'package:a_de_adote/app/pages/pets/widgets/pet_card.dart';
import 'package:flutter/material.dart';

class PetsPage extends StatefulWidget {
  const PetsPage({super.key});

  @override
  State<PetsPage> createState() => _PetsPageState();
}

class _PetsPageState extends State<PetsPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: const StandardAppBar(
          title: 'Pets',
          canPop: false,
        ),
        drawer: const StandardDrawer(),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              PetCard(
                pet: PetModel(
                  nome: 'Bob',
                  ongNome: 'UPAR - Indaiatuba',
                  idadeAproximada: '6 meses',
                  porte: 'Pequeno',
                  especie: 'Cachorro',
                  sexo: 'Masculino',
                  fotoUrl:
                      'https://firebasestorage.googleapis.com/v0/b/a-de-adote.appspot.com/o/fotos_pets%2F646374663?alt=media&token=d397edf0-8e16-47ae-86ec-fc442dddfe70',
                  castrado: true,
                ),
              ),
              PetCard(
                pet: PetModel(
                  nome: 'Bob',
                  ongNome: 'UPAR - Indaiatuba',
                  idadeAproximada: '6 meses',
                  porte: 'Pequeno',
                  especie: 'Cachorro',
                  sexo: 'Masculino',
                  fotoUrl:
                      'https://firebasestorage.googleapis.com/v0/b/a-de-adote.appspot.com/o/fotos_pets%2F646374663?alt=media&token=d397edf0-8e16-47ae-86ec-fc442dddfe70',
                  castrado: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
