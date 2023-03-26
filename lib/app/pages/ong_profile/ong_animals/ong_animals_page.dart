import 'package:a_de_adote/app/core/ui/styles/project_colors.dart';
import 'package:a_de_adote/app/pages/ong_profile/ong_animals/ong_animals_controller.dart';
import 'package:a_de_adote/app/pages/ong_profile/ong_animals/ong_animals_state.dart';
import 'package:a_de_adote/app/pages/ong_profile/ong_animals/widgets/ong_animal_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            int lenght = state.listPets.length;

            return _isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: lenght,
                    itemBuilder: (context, index) {
                      return OngAnimalCard(
                        fotoUrl: state.listPets[index].fotoUrl,
                        nome: state.listPets[index].nome,
                        especie: state.listPets[index].especie,
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
