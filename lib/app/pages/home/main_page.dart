import 'package:a_de_adote/app/core/ui/styles/project_colors.dart';
import 'package:a_de_adote/app/core/ui/styles/project_fonts.dart';
import 'package:a_de_adote/app/pages/ong_profile/ong_profile_page.dart';
import 'package:a_de_adote/app/pages/ongs/ongs_router.dart';
import 'package:a_de_adote/app/pages/pets/pets_router.dart';
import 'package:a_de_adote/app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../favorite_pets/favorite_pets_router.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late bool _isOng;
  late ValueNotifier<int> currentPageIndex;

  @override
  Widget build(BuildContext context) {
    _isOng = context.read<AuthService>().ongUser != null ? true : false;
    currentPageIndex = ValueNotifier(_isOng ? 2 : 0);

    return ValueListenableBuilder(
      valueListenable: currentPageIndex,
      builder: (BuildContext context, int index, Widget? child) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: const SystemUiOverlayStyle(
            systemNavigationBarColor: ProjectColors.secondaryDark,
          ),
          child: Scaffold(
            bottomNavigationBar: NavigationBarTheme(
              data: const NavigationBarThemeData(
                height: 70,
                backgroundColor: ProjectColors.secondaryDark,
                shadowColor: ProjectColors.primaryLight,
                surfaceTintColor: ProjectColors.secondaryDark,
                indicatorColor: ProjectColors.primary,
                iconTheme: MaterialStatePropertyAll(
                  IconThemeData(color: ProjectColors.light),
                ),
                labelBehavior:
                    NavigationDestinationLabelBehavior.onlyShowSelected,
                labelTextStyle: MaterialStatePropertyAll(
                  ProjectFonts.smallLight,
                ),
              ),
              child: NavigationBar(
                onDestinationSelected: (page) => currentPageIndex.value = page,
                selectedIndex: index,
                destinations: [
                  const NavigationDestination(
                    selectedIcon: Icon(Icons.pets),
                    icon: Icon(Icons.pets_outlined),
                    label: 'Pets',
                  ),
                  const NavigationDestination(
                    selectedIcon: Icon(Icons.home),
                    icon: Icon(Icons.home_outlined),
                    label: 'ONGs',
                  ),
                  NavigationDestination(
                    selectedIcon: Icon(_isOng ? Icons.person : Icons.favorite),
                    icon: Icon(
                        _isOng ? Icons.person_outline : Icons.favorite_outline),
                    label: _isOng ? 'Perfil' : 'Favoritos',
                  ),
                ],
              ),
            ),
            body: [
              PetsRouter.page,
              OngsRouter.page,
              _isOng ? const OngProfilePage() : FavoritePetsRouter.page,
            ][index],
          ),
        );
      },
    );
  }
}
