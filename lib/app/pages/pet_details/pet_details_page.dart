import 'package:a_de_adote/app/core/ui/styles/project_colors.dart';
import 'package:a_de_adote/app/core/ui/styles/project_fonts.dart';
import 'package:a_de_adote/app/pages/pet_details/widgets/info_chip.dart';
import 'package:a_de_adote/app/pages/pet_details/widgets/info_container.dart';
import 'package:animated_icon_button/animated_icon_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../../models/pet_model.dart';

class PetDetailsPage extends StatelessWidget {
  final PetModel pet;

  const PetDetailsPage({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CachedNetworkImage(
                        height: MediaQuery.of(context).size.height * 0.35,
                        width: double.infinity,
                        placeholder: (context, url) => Container(
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                'assets/images/loaders/dog_run_loader_secondary.gif',
                              ),
                            ),
                          ),
                        ),
                        fadeInDuration: const Duration(milliseconds: 700),
                        fadeOutDuration: const Duration(milliseconds: 300),
                        imageUrl: pet.fotoUrl ??
                            'https://firebasestorage.googleapis.com/v0/b/a-de-adote.appspot.com/o/logos%2Flogo_icon_white_1024.png?alt=media&token=8545f858-a26d-4a17-8b3c-3cdad23ae727',
                        fit: BoxFit.fitWidth,
                      ),
                      Container(
                        width: double.infinity,
                        color: ProjectColors.secondaryDark,
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  pet.nome,
                                  style: ProjectFonts.h5LightBold,
                                ),
                                Text(
                                  pet.ongNome ?? '-',
                                  style: ProjectFonts.pLight
                                      .copyWith(color: ProjectColors.lightDark),
                                ),
                              ],
                            ),
                            AnimatedIconButton(
                              size: 26,
                              onPressed: () {},
                              duration: const Duration(milliseconds: 500),
                              splashColor: Colors.transparent,
                              icons: const [
                                AnimatedIconItem(
                                  icon: Icon(
                                    Icons.favorite_outline_outlined,
                                    color: ProjectColors.light,
                                  ),
                                ),
                                AnimatedIconItem(
                                  icon: Icon(
                                    Icons.favorite,
                                    color: ProjectColors.primaryLight,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 12, right: 12, top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: InfoContainer(
                                title: 'Espécie',
                                info: pet.especie,
                                icon: MaterialCommunityIcons.paw_outline,
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: InfoContainer(
                                title: 'Porte',
                                info: pet.porte,
                                icon: MaterialCommunityIcons.tape_measure,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: InfoContainer(
                                title: 'Idade Aprox.',
                                info: pet.idadeAproximada,
                                icon: Icons.info_outline,
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: InfoContainer(
                                title: 'Sexo',
                                info: pet.sexo,
                                icon: MaterialCommunityIcons.gender_male_female,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Divider(),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 12,
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: [
                              InfoChip(
                                  info: 'Castrado', infoState: pet.castrado),
                              InfoChip(
                                  info: 'Vacina 1',
                                  infoState: pet.vacinas!['vacina1']),
                              InfoChip(
                                  info: 'Vacina 2',
                                  infoState: pet.vacinas!['vacina2']),
                              InfoChip(
                                  info: 'Vacina 3',
                                  infoState: pet.vacinas!['vacina3']),
                            ],
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Divider(),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 16,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Text(
                              'Sobre',
                              style: ProjectFonts.pLightBold,
                            ),
                            Text(
                              pet.descricao ?? 'Sem descrição.',
                              style: ProjectFonts.smallLight,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: MediaQuery.of(context).size.width * 0.1,
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: ProjectColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 10)),
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'FALE COM A ONG',
                        style: ProjectFonts.pLightBold,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        MaterialCommunityIcons.whatsapp,
                        size: 24,
                        color: ProjectColors.light,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Align(
              alignment: AlignmentDirectional.topStart,
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  size: 24,
                  color: ProjectColors.light,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
