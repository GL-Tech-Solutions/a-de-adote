import 'package:a_de_adote/app/core/constants/buttons.dart';
import 'package:a_de_adote/app/core/constants/labels.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/ui/styles/project_colors.dart';
import '../../core/ui/styles/project_fonts.dart';
import 'widgets/initial_animation.dart';

class InitialPageAnimation extends StatelessWidget {
  const InitialPageAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProjectColors.secondaryLight,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          systemNavigationBarColor: ProjectColors.secondaryLight,
        ),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  ProjectColors.secondary,
                  ProjectColors.secondaryLight,
                ]),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 125, bottom: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 40, right: 40),
                    child: Image.asset(
                      'assets/images/logos/logo_completo_white.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                  const InitalAnimation(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                          text: const TextSpan(
                        children: [
                          TextSpan(
                            text: Labels.boasVindas,
                            style: ProjectFonts.h5LightBold,
                          ),
                          TextSpan(
                            text: Labels.selecioneOpcao,
                            style: ProjectFonts.h6Light,
                          ),
                        ],
                      )),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            decoration: const BoxDecoration(
                              color: ProjectColors.primary,
                              borderRadius: BorderRadius.all(
                                Radius.circular(6),
                              ),
                            ),
                            child: InkWell(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(6),
                              ),
                              onTap: (() {
                                Navigator.pushNamed(context, '/onboarding',
                                    arguments: 'adotante');
                              }),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.favorite,
                                    size: 25,
                                    color: ProjectColors.light,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    Buttons.souAdotante,
                                    style: ProjectFonts.pLightBold,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            decoration: const BoxDecoration(
                              color: ProjectColors.secondary,
                              borderRadius: BorderRadius.all(
                                Radius.circular(6),
                              ),
                            ),
                            child: InkWell(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(6),
                              ),
                              onTap: (() {
                                Navigator.pushNamed(context, '/onboarding',
                                    arguments: 'ong');
                              }),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.pets,
                                    size: 25,
                                    color: ProjectColors.light,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    Buttons.souOng,
                                    style: ProjectFonts.pLightBold,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
