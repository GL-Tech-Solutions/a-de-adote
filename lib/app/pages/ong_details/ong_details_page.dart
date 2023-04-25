import 'dart:async';

import 'package:a_de_adote/app/core/extensions/capitalize_only_first_letter_extension.dart';
import 'package:a_de_adote/app/core/ui/styles/project_fonts.dart';
import 'package:a_de_adote/app/core/ui/widgets/standard_drawer.dart';
import 'package:a_de_adote/app/pages/ong_profile/ong_space/widgets/custom_expansion_tile.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../../core/ui/helpers/filters_state.dart';
import '../../core/ui/styles/project_colors.dart';
import '../../models/ong_model.dart';
import '../home/tabs_state.dart';

class OngDetailsPage extends StatelessWidget {
  final OngModel ong;

  const OngDetailsPage({super.key, required this.ong});

  @override
  Widget build(BuildContext context) {
    String enderecoConcat =
        '${ong.logradouro.stringAdjusted}, ${ong.numero} - ${ong.bairro.stringAdjusted} / ${ong.municipio.stringAdjusted} - ${ong.uf} / ${ong.cep}';

    return Scaffold(
      drawer: const StandardDrawer(),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.27,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: ProjectColors.lightDark,
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
                          imageUrl: ong.fotoUrl ??
                              'https://firebasestorage.googleapis.com/v0/b/a-de-adote.appspot.com/o/logos%2Flogo_completo_withblue.png?alt=media&token=6303a763-dc1d-4095-82be-653cfca32df2',
                          height: 60,
                          width: 110,
                          fit: BoxFit.fitWidth,
                          errorWidget: (context, url, error) => const Icon(
                            Icons.error,
                            color: ProjectColors.danger,
                          ),
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.048,
                        width: double.infinity,
                        color: ProjectColors.primaryDark,
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                ong.fantasia,
                                style: ProjectFonts.h6LightBold,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                for (int i = 0; i < 5; i++)
                                  Padding(
                                    padding: EdgeInsets.only(
                                      bottom: i == 4 ? 0.0 : 4.0,
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          i == 0
                                              ? Icons.info_outline_rounded
                                              : i == 1
                                                  ? Icons.email_outlined
                                                  : i == 2
                                                      ? Icons.phone_outlined
                                                      : i == 3
                                                          ? MaterialCommunityIcons
                                                              .whatsapp
                                                          : i == 4
                                                              ? Icons
                                                                  .home_outlined
                                                              : null,
                                          color: ProjectColors.light,
                                          size: 18,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Flexible(
                                          child: RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: i == 0
                                                      ? 'CNPJ: '
                                                      : i == 1
                                                          ? 'E-mail: '
                                                          : i == 2
                                                              ? 'Telefone: '
                                                              : i == 3
                                                                  ? 'WhatsApp: '
                                                                  : i == 4
                                                                      ? 'Endereço: '
                                                                      : '',
                                                  style:
                                                      ProjectFonts.pLightBold,
                                                ),
                                                TextSpan(
                                                  text: i == 0
                                                      ? ong.cnpj
                                                      : i == 1
                                                          ? ong.email
                                                          : i == 2
                                                              ? ong.telefone ??
                                                                  '-'
                                                              : i == 3
                                                                  ? ong.whatsapp ??
                                                                      '-'
                                                                  : i == 4
                                                                      ? enderecoConcat
                                                                      : '',
                                                  style: ProjectFonts.pLight,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              CustomExpansionTile(
                                isOng: false,
                                title: 'Doação - Pix',
                                isInitialExpanded: true,
                                bodyPadding: EdgeInsets.symmetric(
                                  vertical: ong.pix == null ? 10 : 0,
                                  horizontal: 10,
                                ),
                                body: ong.pix == null
                                    ? Text(
                                        'Sem informações de Pix.',
                                        style: ProjectFonts.pLight.copyWith(
                                          fontStyle: FontStyle.italic,
                                        ),
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            ong.pix?.keys.first == 'CNPJ'
                                                ? Icons.info_outline_rounded
                                                : ong.pix?.keys.first ==
                                                        'Celular'
                                                    ? MaterialCommunityIcons
                                                        .whatsapp
                                                    : ong.pix?.keys.first ==
                                                            'E-mail'
                                                        ? Icons.email_outlined
                                                        : null,
                                            color: ProjectColors.light,
                                            size: 18,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Flexible(
                                            child: RichText(
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text:
                                                        '${ong.pix?.keys.first}: ',
                                                    style:
                                                        ProjectFonts.pLightBold,
                                                  ),
                                                  TextSpan(
                                                    text: ong.pix?.values.first,
                                                    style: ProjectFonts.pLight,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () => Clipboard.setData(
                                              ClipboardData(
                                                text: ong.pix?.values.first
                                                    as String,
                                              ),
                                            ).then(
                                              (_) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    content: Text(
                                                      'Pix copiado!',
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                            icon: const Icon(
                                              Icons.copy,
                                              size: 16,
                                              color: ProjectColors.primaryLight,
                                            ),
                                          ),
                                        ],
                                      ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              CustomExpansionTile(
                                isOng: false,
                                title: 'Sobre',
                                isInitialExpanded: true,
                                body: ong.informacoes == null
                                    ? Text(
                                        'Sem informações sobre a ONG.',
                                        style: ProjectFonts.smallLight.copyWith(
                                          fontStyle: FontStyle.italic,
                                        ),
                                      )
                                    : Text(
                                        ong.informacoes!,
                                        style: ProjectFonts.smallLight,
                                      ),
                              ),
                            ],
                          ),
                        ],
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
                  onPressed: () {
                    final filter = {
                      'ong': ong.fantasia,
                      'dog': false,
                      'cat': false,
                      'bird': false,
                      'other': false,
                      'idadeMaxima': 20,
                      'sexo': 0,
                      'mini': false,
                      'pequeno': false,
                      'medio': false,
                      'grande': false,
                    };

                    Navigator.of(context).pop();
                    FiltersState.petCurrentFilters = filter;
                    context.read<TabsState>().setTabIndex(0);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'VER ANIMAIS',
                        style: ProjectFonts.pLightBold,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 3),
                        child: Icon(
                          MaterialCommunityIcons.paw,
                          size: 24,
                          color: ProjectColors.light,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.02,
              top: MediaQuery.of(context).size.height * 0.04,
            ),
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
