import 'package:a_de_adote/app/core/ui/styles/project_colors.dart';
import 'package:a_de_adote/app/core/ui/styles/project_fonts.dart';
import 'package:a_de_adote/app/services/auth_service.dart';
import 'package:a_de_adote/app/services/research_launch_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StandardDrawer extends StatelessWidget {
  const StandardDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox.shrink();
        } else {
          SharedPreferences sp = snapshot.data as SharedPreferences;

          return Drawer(
            child: Stack(
              children: [
                ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    DrawerHeader(
                      decoration: const BoxDecoration(
                        color: ProjectColors.secondary,
                      ),
                      child: Center(
                        child: Container(
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                'assets/images/logos/logo_completo_white.png',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    ListTile(
                      onTap: () async {
                        Navigator.of(context).pop();
                        await ResearchLaunchService.openForm();
                      },
                      title: Row(
                        children: [
                          const Icon(
                            Icons.open_in_new,
                            size: 22,
                            color: ProjectColors.secondaryDark,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Responda nossa pesquisa!',
                            style: ProjectFonts.pSecundaryDark
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: context.read<AuthService>().ongUser != null &&
                          sp.get('userType') == 'ong'
                      ? ListTile(
                          tileColor: ProjectColors.primary,
                          onTap: () {
                            Provider.of<AuthService>(context, listen: false)
                                .signOut();
                            Navigator.popAndPushNamed(context, '/login');
                          },
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.logout,
                                size: 22,
                                color: ProjectColors.light,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Sair',
                                style: ProjectFonts.pLight.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListTile(
                          tileColor: ProjectColors.secondary,
                          onTap: () {
                            sp.setString('userType', 'ong');
                            Navigator.popAndPushNamed(context, '/login');
                          },
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.pets,
                                size: 22,
                                color: ProjectColors.light,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Sou uma ONG',
                                style: ProjectFonts.pLight.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
