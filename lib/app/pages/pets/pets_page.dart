import 'package:a_de_adote/app/core/ui/styles/project_colors.dart';
import 'package:a_de_adote/app/core/ui/widgets/container_research.dart';
import 'package:a_de_adote/app/core/ui/widgets/standard_drawer.dart';
import 'package:a_de_adote/app/core/ui/widgets/standard_shimmer_effect.dart';
import 'package:a_de_adote/app/core/ui/widgets/standard_sliver_appbar.dart';
import 'package:a_de_adote/app/pages/pet_details/pet_details_page.dart';
import 'package:a_de_adote/app/pages/pets/pets_controller.dart';
import 'package:a_de_adote/app/pages/pets/pets_state.dart';
import 'package:a_de_adote/app/pages/pets/widgets/pet_card.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/ui/widgets/search_bar_pet.dart';

class PetsPage extends StatefulWidget {
  const PetsPage({super.key});

  @override
  State<PetsPage> createState() => _PetsPageState();
}

class _PetsPageState extends State<PetsPage> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<PetsController>().loadAllPets();
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        drawer: const StandardDrawer(),
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, innerBoxIsScrolled) {
            return [
              StandardSliverAppbar(
                title: 'Pets',
                canPop: false,
                bottom: PreferredSize(
                  preferredSize: Size(
                    MediaQuery.of(context).size.width,
                    MediaQuery.of(context).size.height * 0.05,
                  ),
                  child: const ContainerResearch(),
                ),
              ),
            ];
          },
          body: BlocConsumer<PetsController, PetsState>(
            listener: (context, state) {
              state.status.matchAny(
                any: () => _isLoading = false,
                loading: () => _isLoading = true,
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
                  ? GridView.builder(
                      padding: const EdgeInsets.all(10),
                      itemCount: 8,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 17,
                        crossAxisSpacing: 12,
                      ),
                      itemBuilder: (context, index) {
                        return const StandardShimmerEffect();
                      },
                    ) //const Center(child: CircularProgressIndicator())
                  : Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 10, bottom: 0),
                          child: SearchBarPet(listaPets: state.listPets),
                        ),
                        Expanded(
                          child: GridView.builder(
                            padding: const EdgeInsets.all(10),
                            itemCount: length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 5,
                            ),
                            itemBuilder: (context, index) {
                              return OpenContainer(
                                tappable: false,
                                closedColor: Colors.transparent,
                                closedElevation: 0,
                                closedShape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                transitionDuration:
                                    const Duration(milliseconds: 500),
                                transitionType: ContainerTransitionType.fade,
                                openBuilder: (context, _) =>
                                    PetDetailsPage(pet: state.listPets[index]),
                                closedBuilder:
                                    (context, VoidCallback openContainer) =>
                                        PetCard(
                                  pet: state.listPets[index],
                                  onTap: openContainer,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
            },
          ),
        ),
      ),
    );
  }
}
