import 'package:a_de_adote/app/core/ui/helpers/bottom_sheet_image_source.dart';
import 'package:a_de_adote/app/core/ui/helpers/update_dialog_ong_description.dart';
import 'package:a_de_adote/app/core/ui/styles/project_fonts.dart';
import 'package:a_de_adote/app/core/ui/widgets/standard_drawer.dart';
import 'package:a_de_adote/app/pages/ong_profile/ong_space/ong_space_state.dart';
import 'package:a_de_adote/app/pages/ong_profile/ong_space/widgets/custom_expansion_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../../../core/ui/styles/project_colors.dart';
import 'ong_space_controller.dart';

class OngSpacePage extends StatefulWidget {
  const OngSpacePage({super.key});

  @override
  State<OngSpacePage> createState() => _OngSpacePageState();
}

class _OngSpacePageState extends State<OngSpacePage>
    with BottomSheetImageSource, UpdateDialogOngDescription {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<OngSpaceController>().loadOng();
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        drawer: const StandardDrawer(),
        body: BlocConsumer<OngSpaceController, OngSpaceState>(
          listener: (context, state) {
            state.status.matchAny(
              any: () => _isLoading = false,
              loading: () => _isLoading = true,
              fieldUpdated: () => context.read<OngSpaceController>().loadOng(),
              error: () {
                _isLoading = false;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.errorMesssage ?? ''),
                  ),
                );
              },
            );
          },
          buildWhen: (previous, current) => current.status.matchAny(
            any: () => false,
            initial: () => false,
            loading: () => true,
            loaded: () => true,
          ),
          builder: (context, state) {
            String enderecoConcat =
                '${state.ong?.logradouro}, ${state.ong?.numero} - ${state.ong?.bairro} / ${state.ong?.municipio} - ${state.ong?.uf} / ${state.ong?.cep}';

            return _isLoading
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      InkWell(
                        onTap: () async {
                          final source = await setImageSorce();
                          if (source != null) {
                            // ignore: use_build_context_synchronously
                            context
                                .read<OngSpaceController>()
                                .pickAndSaveImage(source);
                          }
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.24,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: ProjectColors.lightDark,
                            image: state.ong?.fotoUrl == null
                                ? null
                                : DecorationImage(
                                    image: Image.network(
                                      state.ong!.fotoUrl!,
                                    ).image,
                                    fit: BoxFit.fitWidth,
                                  ),
                          ),
                          child: state.ong?.fotoUrl != null
                              ? null
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(
                                      Icons.photo_camera_outlined,
                                      size: 36,
                                      color: ProjectColors.secondaryDark,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Adicione uma foto de sua ONG!',
                                      style: ProjectFonts.h6SecundaryDark,
                                    ),
                                  ],
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
                                state.ong?.fantasia ?? '',
                                style: ProjectFonts.h6LightBold,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.edit,
                                color: ProjectColors.light,
                                size: 22,
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
                                                      ? state.ong?.cnpj
                                                      : i == 1
                                                          ? state.ong?.email
                                                          : i == 2
                                                              ? state.ong
                                                                      ?.telefone ??
                                                                  '-'
                                                              : i == 3
                                                                  ? state.ong
                                                                          ?.whatsapp ??
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
                                isOng: true,
                                title: 'Doação - Pix',
                                edit: () => showChangeDescription,
                                body: state.ong?.pix == null
                                    ? Text(
                                        'Sem formas de doação disponíveis. Adicione uma!',
                                        style: ProjectFonts.pLight.copyWith(
                                          fontStyle: FontStyle.italic,
                                        ),
                                      )
                                    : Text(
                                        state.ong!.pix.toString(),
                                        style: ProjectFonts.pLight,
                                      ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              CustomExpansionTile(
                                isOng: true,
                                title: 'Sobre',
                                edit: () async {
                                  String? description =
                                      await showChangeDescription(
                                          state.ong?.informacoes);
                                  if (description != null) {
                                    // ignore: use_build_context_synchronously
                                    context
                                        .read<OngSpaceController>()
                                        .updateDescriptionOng(description);
                                  }
                                },
                                body: state.ong?.informacoes == null
                                    ? Text(
                                        'Sem informações sobre a ONG. Adicione-as!',
                                        style: ProjectFonts.smallLight.copyWith(
                                          fontStyle: FontStyle.italic,
                                        ),
                                      )
                                    : Text(
                                        state.ong!.informacoes!,
                                        style: ProjectFonts.smallLight,
                                      ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  );
          },
        ),
      ),
    );
  }
}
