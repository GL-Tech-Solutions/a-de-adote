import 'package:a_de_adote/app/core/ui/styles/project_colors.dart';
import 'package:a_de_adote/app/core/ui/styles/project_fonts.dart';
import 'package:a_de_adote/app/core/ui/widgets/standard_shimmer_effect.dart';
import 'package:a_de_adote/app/pages/ong_profile/ong_animals/ong_animals_controller.dart';
import 'package:a_de_adote/app/pages/ong_profile/ong_animals/ong_animals_state.dart';
import 'package:a_de_adote/app/pages/ong_profile/ong_animals/widgets/ong_animal_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../../../core/ui/helpers/alert_dialog_confirmation_message.dart';

class OngAnimalsPage extends StatefulWidget {
  const OngAnimalsPage({super.key});

  @override
  State<OngAnimalsPage> createState() => _OngAnimalsPageState();
}

class _OngAnimalsPageState extends State<OngAnimalsPage>
    with AlertDialogConfirmationMessage {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<OngAnimalsController>().loadCurrentUserPets();
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: BlocConsumer<OngAnimalsController, OngAnimalsState>(
          listener: (context, state) {
            state.status.matchAny(
              any: () => _isLoading = false,
              loading: () => _isLoading = true,
              petDeleted: () =>
                  context.read<OngAnimalsController>().loadCurrentUserPets(),
              error: () {
                _isLoading = false;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.errorMessage ?? ''),
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
            int length = state.listPets.length;

            return _isLoading
                ? ListView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: 8,
                    itemBuilder: (context, index) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 4),
                        child: SizedBox(
                          height: 70,
                          child: StandardShimmerEffect(),
                        ),
                      );
                    },
                  ) //const Center(child: CircularProgressIndicator())
                : length == 0
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  MaterialCommunityIcons.dog,
                                  size: 18,
                                  color: ProjectColors.light,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  MaterialCommunityIcons.cat,
                                  size: 18,
                                  color: ProjectColors.light,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  MaterialCommunityIcons.bird,
                                  size: 18,
                                  color: ProjectColors.light,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  Icons.pets,
                                  size: 18,
                                  color: ProjectColors.light,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Flexible(
                                  child: Text(
                                    'Você ainda não possui nenhum animal cadastrado.',
                                    style: ProjectFonts.pLight,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(10),
                        itemCount: length,
                        itemBuilder: (context, index) {
                          return OngAnimalCard(
                            pet: state.listPets[index],
                            editMethod: () async {
                              await Navigator.pushNamed(
                                context,
                                '/pet_edit',
                                arguments: state.listPets[index],
                              );
                              // ignore: use_build_context_synchronously
                              context
                                  .read<OngAnimalsController>()
                                  .loadCurrentUserPets();
                            },
                            deleteMethod: () async {
                              bool? action = await confimAction(
                                  'Você tem certeza que gostaria de excluir este animal?');
                              if (action == null || action == false) {
                                null;
                              } else {
                                // ignore: use_build_context_synchronously
                                context
                                    .read<OngAnimalsController>()
                                    .deletePet(state.listPets[index]);
                              }
                            },
                          );
                        },
                      );
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: ProjectColors.primary,
          onPressed: () async {
            await Navigator.pushNamed(context, '/pet_register');
            // ignore: use_build_context_synchronously
            context.read<OngAnimalsController>().loadCurrentUserPets();
          },
          child: const Icon(
            Icons.add,
            color: ProjectColors.light,
          ),
        ),
      ),
    );
  }
}
