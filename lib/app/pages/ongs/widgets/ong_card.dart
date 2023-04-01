import 'package:a_de_adote/app/core/extensions/capitalize_only_first_letter_extension.dart';
import 'package:a_de_adote/app/core/ui/styles/project_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../core/ui/styles/project_fonts.dart';
import '../../../models/ong_model.dart';

class OngCard extends StatelessWidget {
  final OngModel ong;

  const OngCard({super.key, required this.ong});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {},
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: CachedNetworkImage(
                height: 170,
                width: double.infinity,
                placeholder: (context, url) => Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/images/loaders/cat_licking_loader.gif',
                      ),
                    ),
                  ),
                ),
                fadeInDuration: const Duration(milliseconds: 700),
                fadeOutDuration: const Duration(milliseconds: 300),
                imageUrl: ong.fotoUrl ??
                    'https://firebasestorage.googleapis.com/v0/b/a-de-adote.appspot.com/o/logos%2Flogo_completo_withblue.png?alt=media&token=6303a763-dc1d-4095-82be-653cfca32df2',
                fit: BoxFit.fitWidth,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 4,
                horizontal: 14,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Text(
                              ong.fantasia,
                              style: ProjectFonts.h6SecundaryDarkBold
                                  .copyWith(overflow: TextOverflow.ellipsis),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              '${ong.municipio.stringAdjusted} - ${ong.uf}',
                              style: ProjectFonts.smallSecundaryDark.copyWith(
                                color: const Color(0xFF646464),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                        width: 110,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ProjectColors.primaryLight,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            alignment: Alignment.center,
                          ),
                          child: const Text(
                            'VER ANIMAIS',
                            style: ProjectFonts.smallLightBold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          ong.informacoes ?? 'Sem informações.',
                          maxLines: 3,
                          style: ProjectFonts.smallSecundaryDark,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
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
