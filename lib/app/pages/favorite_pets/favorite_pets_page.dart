import 'dart:async';
import 'package:a_de_adote/app/core/ui/widgets/container_research.dart';
import 'package:a_de_adote/app/pages/favorite_pets/favorite_pets_controller.dart';
import 'package:a_de_adote/app/pages/favorite_pets/favorite_pets_state.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../../core/ui/styles/project_colors.dart';
import '../../core/ui/styles/project_fonts.dart';
import '../../core/ui/widgets/standard_drawer.dart';
import '../../core/ui/widgets/standard_shimmer_effect.dart';
import '../../core/ui/widgets/standard_sliver_appbar.dart';
import '../pet_details/pet_details_router.dart';
import '../pets/widgets/pet_card.dart';

class FavoritePetsPage extends StatefulWidget {
  const FavoritePetsPage({super.key});

  @override
  State<FavoritePetsPage> createState() => _FavoritePetsPageState();
}

class _FavoritePetsPageState extends State<FavoritePetsPage> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<FavoritePetsController>().loadFavoritePets(true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const StandardDrawer(),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, innerBoxIsScrolled) {
          return [
            StandardSliverAppbar(
              title: 'Favoritos',
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
        body: BlocConsumer<FavoritePetsController, FavoritePetsState>(
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
            int lengthFavoriteList = state.listFavoritePets.length;
            ValueNotifier<bool> loadMessage = ValueNotifier(false);

            if (lengthFavoriteList == 0) {
              Timer(
                const Duration(milliseconds: 100),
                () => loadMessage.value = true,
              );
            }

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
                  )
                : lengthFavoriteList == 0
                    ? ValueListenableBuilder(
                        valueListenable: loadMessage,
                        builder: (BuildContext context, bool canBeVisible,
                            Widget? child) {
                          return Visibility(
                            visible: canBeVisible,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    MaterialCommunityIcons.paw,
                                    size: 18,
                                    color: ProjectColors.light,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Flexible(
                                        child: Text(
                                          'Você ainda não possui nenhum animal favorito.',
                                          style: ProjectFonts.pLight,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        })
                    : GridView.builder(
                        padding: const EdgeInsets.all(10),
                        itemCount: lengthFavoriteList,
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
                            openBuilder: (context, _) => PetDetailsRouter(
                              pet: state.listFavoritePets[index],
                            ).page,
                            onClosed: (petWasRemoved) {
                              context
                                  .read<FavoritePetsController>()
                                  .loadFavoritePets(false);
                            },
                            closedBuilder:
                                (context, VoidCallback openContainer) =>
                                    PetCard(
                              pet: state.listFavoritePets[index],
                              onTap: openContainer,
                            ),
                          );
                        },
                      );
          },
        ),
      ),
    );
  }
}
