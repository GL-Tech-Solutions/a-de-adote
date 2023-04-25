import 'package:a_de_adote/app/core/ui/widgets/standard_drawer.dart';
import 'package:a_de_adote/app/core/ui/widgets/standard_shimmer_effect.dart';
import 'package:a_de_adote/app/pages/ongs/ongs_controller.dart';
import 'package:a_de_adote/app/pages/ongs/ongs_state.dart';
import 'package:a_de_adote/app/pages/ongs/widgets/ong_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../../core/ui/helpers/bottom_sheet_ong_filter.dart';
import '../../core/ui/styles/project_colors.dart';
import '../../core/ui/widgets/container_research.dart';
import '../../core/ui/widgets/standard_sliver_appbar.dart';
import '../../core/ui/widgets/standard_sliver_search_bar.dart';

class OngsPage extends StatefulWidget {
  const OngsPage({super.key});

  @override
  State<OngsPage> createState() => _OngsPageState();
}

class _OngsPageState extends State<OngsPage> with BottomSheetOngFilter {
  final ValueNotifier<bool> _isSearchBar = ValueNotifier(false);
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<OngsController>().loadAllOngs();
    });
  }

  @override
  void dispose() {
    _isSearchBar.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_isSearchBar.value == true) {
          context.read<OngsController>().clearOngsFiltered();
        }
        context.read<OngsController>().clearOngsSearched();
        _isSearchBar.value = false;
        return false;
      },
      child: Scaffold(
        drawer: const StandardDrawer(),
        body: ValueListenableBuilder(
          valueListenable: _isSearchBar,
          builder: (BuildContext context, bool isSearchBar, Widget? child) {
            return NestedScrollView(
              headerSliverBuilder: (BuildContext context, innerBoxIsScrolled) {
                return [
                  isSearchBar
                      ? BlocBuilder<OngsController, OngsState>(
                          builder: (context, state) {
                            return StandardSliverSearchBar(
                              listaNomes: state.listOngs
                                  .map((ong) => ong.fantasia)
                                  .toList(),
                              backButtonFunction: () {
                                context
                                    .read<OngsController>()
                                    .clearOngsFiltered();
                                context
                                    .read<OngsController>()
                                    .clearOngsSearched();
                                _isSearchBar.value = false;
                              },
                              searchFunction: context
                                  .read<OngsController>()
                                  .loadOngsSearched,
                              bottom: PreferredSize(
                                preferredSize: Size(
                                  MediaQuery.of(context).size.width,
                                  MediaQuery.of(context).size.height * 0.05,
                                ),
                                child: const ContainerResearch(),
                              ),
                            );
                          },
                        )
                      : StandardSliverAppbar(
                          title: 'ONGs',
                          canPop: false,
                          alternateAppbar: () {
                            context.read<OngsController>().clearOngsFiltered();
                            _isSearchBar.value = true;
                          },
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
              body: BlocConsumer<OngsController, OngsState>(
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
                  loadedSearched: () => true,
                  loadedFiltered: () => true,
                ),
                builder: (context, state) {
                  int lengthListOngs = state.listOngs.length;
                  int lengthListOngsSearched = state.listOngsSearched.length;
                  int lengthListOngsFiltered = state.listOngsFiltered.length;

                  return _isLoading
                      ? ListView.builder(
                          padding: const EdgeInsets.all(10),
                          itemCount: 2,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  EdgeInsets.only(top: index == 0 ? 0 : 15.0),
                              child: const SizedBox(
                                height: 285,
                                child: StandardShimmerEffect(),
                              ),
                            );
                          },
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.all(10),
                          itemCount: lengthListOngsFiltered != 0
                              ? lengthListOngsFiltered
                              : lengthListOngsSearched != 0
                                  ? lengthListOngsSearched
                                  : lengthListOngs,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  EdgeInsets.only(top: index == 0 ? 0 : 10.0),
                              child: OngCard(
                                ong: state.listOngsFiltered.isNotEmpty
                                    ? state.listOngsFiltered[index]
                                    : state.listOngsSearched.isNotEmpty
                                        ? state.listOngsSearched[index]
                                        : state.listOngs[index],
                                onTap: () {},
                              ),
                            );
                          },
                        );
                },
              ),
            );
          },
        ),
        floatingActionButton: BlocBuilder<OngsController, OngsState>(
          builder: (context, state) {
            return FloatingActionButton(
              backgroundColor: ProjectColors.primary,
              onPressed: () async => context
                  .read<OngsController>()
                  .loadOngsFiltered((await setOngFilter(state.currentFilters))
                      ?.cast<String, dynamic>()),
              child: const Icon(
                MaterialCommunityIcons.filter_variant,
                color: ProjectColors.light,
              ),
            );
          },
        ),
      ),
    );
  }
}
