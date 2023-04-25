import 'package:a_de_adote/app/core/ui/styles/project_colors.dart';
import 'package:a_de_adote/app/core/ui/styles/project_fonts.dart';
import 'package:a_de_adote/app/core/ui/widgets/standard_search_bar.dart';
import 'package:a_de_adote/app/core/ui/widgets/standard_shimmer_effect.dart';
import 'package:a_de_adote/app/pages/ong_profile/ong_animals/ong_animals_controller.dart';
import 'package:a_de_adote/app/pages/ong_profile/ong_animals/ong_animals_state.dart';
import 'package:a_de_adote/app/pages/ong_profile/ong_animals/widgets/ong_animal_card.dart';
import 'package:a_de_adote/app/pages/pet_details/pet_details_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../../../core/ui/helpers/alert_dialog_confirmation_message.dart';
import '../../../core/ui/helpers/bottom_sheet_pet_filter.dart';

class OngAnimalsPage extends StatefulWidget {
  const OngAnimalsPage({super.key});

  @override
  State<OngAnimalsPage> createState() => _OngAnimalsPageState();
}

class _OngAnimalsPageState extends State<OngAnimalsPage>
    with AlertDialogConfirmationMessage, BottomSheetPetFilter {
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
            loadedSearched: () => true,
            loadedFiltered: () => true,
          ),
          builder: (context, state) {
            int lengthListPets = state.listPets.length;
            int lengthListPetsSearched = state.listPetsSearched.length;
            int lengthListPetsFiltered = state.listPetsFiltered.length;

            return _isLoading
                ? Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(
                          left: 10,
                          right: 10,
                          top: 10,
                          bottom: 0,
                        ),
                        child: SizedBox(
                          height: 48,
                          child: StandardShimmerEffect(radiusValue: 28),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
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
                        ),
                      ),
                    ],
                  )
                : lengthListPets == 0
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
                    : Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 10, bottom: 0),
                            child: StandardSearchBar(
                              listaNomes: state.listPets
                                  .map((pet) => pet.nome)
                                  .toList(),
                              searchFunction: context
                                  .read<OngAnimalsController>()
                                  .loadPetsSearched,
                              cancelSearchFunction: () {
                                context
                                    .read<OngAnimalsController>()
                                    .clearPetsFiltered();
                                context
                                    .read<OngAnimalsController>()
                                    .clearPetsSearched();
                              },
                              onTapFunction: context
                                  .read<OngAnimalsController>()
                                  .clearPetsFiltered,
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              padding: const EdgeInsets.all(10),
                              itemCount: lengthListPetsFiltered != 0
                                  ? lengthListPetsFiltered
                                  : lengthListPetsSearched != 0
                                      ? lengthListPetsSearched
                                      : lengthListPets,
                              itemBuilder: (context, index) {
                                return OngAnimalCard(
                                  pet: state.listPetsFiltered.isNotEmpty
                                      ? state.listPetsFiltered[index]
                                      : state.listPetsSearched.isNotEmpty
                                          ? state.listPetsSearched[index]
                                          : state.listPets[index],
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
                                    bool? action = await confirmAction(
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
                                  onTap: () async {
                                    bool? wasDeletedOrUpdated =
                                        await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PetDetailsRouter(
                                          pet: state.listPetsFiltered.isNotEmpty
                                              ? state.listPetsFiltered[index]
                                              : state.listPetsSearched
                                                      .isNotEmpty
                                                  ? state
                                                      .listPetsSearched[index]
                                                  : state.listPets[index],
                                          isEditable: true,
                                        ).page,
                                      ),
                                    );

                                    if (wasDeletedOrUpdated ?? false) {
                                      // ignore: use_build_context_synchronously
                                      context
                                          .read<OngAnimalsController>()
                                          .loadCurrentUserPets();
                                    }
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      );
          },
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            BlocBuilder<OngAnimalsController, OngAnimalsState>(
              builder: (context, state) {
                return FloatingActionButton(
                  mini: true,
                  backgroundColor: ProjectColors.lightDark,
                  onPressed: () async => context
                      .read<OngAnimalsController>()
                      .loadPetsFiltered(
                          await setPetFilter(false, state.currentFilters)),
                  heroTag: null,
                  child: Badge(
                    isLabelVisible: state.currentFilters != null,
                    backgroundColor: ProjectColors.primaryLight,
                    label: const Text('!'),
                    child: const Icon(
                      MaterialCommunityIcons.filter_variant,
                      color: ProjectColors.darkLight,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 10,
            ),
            FloatingActionButton(
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
          ],
        ),
      ),
    );
  }
}
