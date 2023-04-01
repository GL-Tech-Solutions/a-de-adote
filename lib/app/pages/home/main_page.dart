import 'package:a_de_adote/app/core/ui/styles/project_colors.dart';
import 'package:a_de_adote/app/core/ui/styles/project_fonts.dart';
import 'package:a_de_adote/app/pages/ong_profile/ong_profile_page.dart';
import 'package:a_de_adote/app/pages/ongs/ongs_page.dart';
import 'package:a_de_adote/app/pages/pets/pets_page.dart';
import 'package:a_de_adote/app/pages/pets/pets_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../ong_profile/ong_space/ong_space_router.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  ValueNotifier<int> currentPageIndex = ValueNotifier(2);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: ValueListenableBuilder(
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
                    onDestinationSelected: (page) =>
                        currentPageIndex.value = page,
                    selectedIndex: index,
                    destinations: const [
                      NavigationDestination(
                        selectedIcon: Icon(Icons.pets),
                        icon: Icon(Icons.pets_outlined),
                        label: 'Pets',
                      ),
                      NavigationDestination(
                        selectedIcon: Icon(Icons.home),
                        icon: Icon(Icons.home_outlined),
                        label: 'ONGs',
                      ),
                      NavigationDestination(
                        selectedIcon: Icon(Icons.person),
                        icon: Icon(Icons.person_outlined),
                        label: 'Perfil',
                      ),
                    ],
                  ),
                ),
                body: [
                  PetsRouter.page,
                  const OngsPage(),
                  const OngProfilePage(),
                ][index],
              ),
            );
          }),
    );
  }
}
