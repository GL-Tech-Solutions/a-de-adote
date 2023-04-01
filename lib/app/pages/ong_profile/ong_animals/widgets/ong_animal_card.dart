import 'package:a_de_adote/app/core/ui/styles/project_colors.dart';
import 'package:a_de_adote/app/core/ui/styles/project_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class OngAnimalCard extends StatelessWidget {
  final String? fotoUrl;
  final String nome;
  final String especie;
  Function() deleteMethod;

  OngAnimalCard(
      {super.key,
      required this.fotoUrl,
      required this.nome,
      required this.especie,
      required this.deleteMethod});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                fotoUrl == null
                    ? const SizedBox(
                        height: 60,
                        width: 110,
                      )
                    : ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomLeft: Radius.circular(12),
                        ),
                        child: CachedNetworkImage(
                          placeholder: (context, url) => Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  'assets/images/loaders/filled_fading_balls.gif',
                                ),
                              ),
                            ),
                          ),
                          fadeInDuration: const Duration(milliseconds: 700),
                          fadeOutDuration: const Duration(milliseconds: 300),
                          imageUrl: fotoUrl ??
                              'https://firebasestorage.googleapis.com/v0/b/a-de-adote.appspot.com/o/logos%2Flogo_icon_white_1024.png?alt=media&token=8545f858-a26d-4a17-8b3c-3cdad23ae727',
                          height: 70,
                          width: 110,
                          fit: BoxFit.fitWidth,
                          errorWidget: (context, url, error) => const Icon(
                            Icons.error,
                            color: ProjectColors.danger,
                          ),
                        ),
                      ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nome,
                      style: ProjectFonts.h6SecundaryDarkBold,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          especie == 'Cachorro'
                              ? MaterialCommunityIcons.dog
                              : especie == 'Gato'
                                  ? MaterialCommunityIcons.cat
                                  : especie == 'Pássaro'
                                      ? MaterialCommunityIcons.bird
                                      : especie == 'Outro'
                                          ? MaterialCommunityIcons.paw
                                          : MaterialCommunityIcons.paw,
                          size: 14,
                          color: const Color(0xFF646464),
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        Text(
                          especie,
                          style: ProjectFonts.smallSecundaryDark.copyWith(
                            color: const Color(0xFF646464),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {},
                        child: const Padding(
                          padding: EdgeInsets.all(10),
                          child: Icon(
                            Icons.edit,
                            size: 22,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: deleteMethod,
                        child: const Padding(
                          padding: EdgeInsets.all(10),
                          child: Icon(
                            Icons.cancel_outlined,
                            size: 22,
                            color: ProjectColors.danger,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
