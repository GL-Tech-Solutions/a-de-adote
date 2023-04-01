import 'package:a_de_adote/app/core/ui/widgets/container_research.dart';
import 'package:a_de_adote/app/core/ui/widgets/standard_appbar.dart';
import 'package:a_de_adote/app/core/ui/widgets/standard_drawer.dart';
import 'package:a_de_adote/app/core/ui/widgets/standard_sliver_appbar.dart';
import 'package:a_de_adote/app/models/pet_model.dart';
import 'package:a_de_adote/app/pages/pets/pets_controller.dart';
import 'package:a_de_adote/app/pages/pets/pets_state.dart';
import 'package:a_de_adote/app/pages/pets/widgets/pet_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                  ? const Center(child: CircularProgressIndicator())
                  : GridView.builder(
                      padding: const EdgeInsets.all(10),
                      itemCount: length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 5),
                      itemBuilder: (context, index) {
                        return PetCard(pet: state.listPets[index]);
                      },
                    );
            },
          ),
        ),
      ),
    );
  }
}
