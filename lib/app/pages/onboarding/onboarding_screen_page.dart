import 'package:a_de_adote/app/pages/onboarding/onboarding_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constants/buttons.dart';
import '../../core/constants/labels.dart';
import '../../core/ui/styles/project_colors.dart';
import '../../core/ui/styles/project_fonts.dart';
import '../../core/ui/widgets/animated_button.dart';
import 'onboarding_screen_state.dart';

class OnboardingScreenPage extends StatefulWidget {
  const OnboardingScreenPage({super.key});

  @override
  State<OnboardingScreenPage> createState() => _OnboardingScreenPageState();
}

class _OnboardingScreenPageState extends State<OnboardingScreenPage> {
  final int _numPages = 3;
  final PageController _pc = PageController(initialPage: 0);
  late String _option;

  List<Widget> _buildPageIndicator(int currentPage) {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  AnimatedContainer _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(microseconds: 200),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      height: 8,
      width: isActive ? 24 : 16,
      decoration: BoxDecoration(
        color: isActive
            ? ProjectColors.light
            : ProjectColors.light.withOpacity(0.2),
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _option = ModalRoute.of(context)?.settings.arguments as String;

    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
            systemNavigationBarColor: ProjectColors.secondaryLight),
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
          child: Padding(
            padding:
                const EdgeInsets.only(top: 40, bottom: 10, left: 15, right: 15),
            child:
                BlocBuilder<OnboardingScreenController, OnboardingScreenState>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        style: ButtonStyle(
                          overlayColor: MaterialStateProperty.all(
                            ProjectColors.primary.withOpacity(0.2),
                          ),
                        ),
                        onPressed: () => _pc.animateToPage(
                          _numPages - 1,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.ease,
                        ),
                        child: const Text(
                          Buttons.pular,
                          style: ProjectFonts.smallLightBold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 590,
                      child: PageView(
                        physics: const ClampingScrollPhysics(),
                        controller: _pc,
                        onPageChanged: (int page) => context
                            .read<OnboardingScreenController>()
                            .setPage(page),
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 40, horizontal: 25),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Image(
                                    image: AssetImage(
                                      _option == 'adotante'
                                          ? 'assets/images/onboarding/2.png'
                                          : 'assets/images/onboarding/5.png',
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  _option == 'adotante'
                                      ? Labels.msg1Adotante
                                      : Labels.msg1Ong,
                                  style: ProjectFonts.h5LightBold,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  _option == 'adotante'
                                      ? Labels.informativoAdotante1
                                      : Labels.informativoOng1,
                                  style: ProjectFonts.pLight,
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 40, horizontal: 25),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Image(
                                    image: AssetImage(
                                      _option == 'adotante'
                                          ? 'assets/images/onboarding/3.png'
                                          : 'assets/images/onboarding/4.png',
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  _option == 'adotante'
                                      ? Labels.msg2Adotante
                                      : Labels.msg2Ong,
                                  style: ProjectFonts.h5LightBold,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  _option == 'adotante'
                                      ? Labels.informativoAdotante2
                                      : Labels.informativoOng2,
                                  style: ProjectFonts.pLight,
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 40, horizontal: 25),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Image(
                                    image: AssetImage(
                                      _option == 'adotante'
                                          ? 'assets/images/onboarding/1.png'
                                          : 'assets/images/onboarding/6.png',
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  _option == 'adotante'
                                      ? Labels.msg3Adotante
                                      : Labels.msg3Ong,
                                  style: ProjectFonts.h5LightBold,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  _option == 'adotante'
                                      ? Labels.informativoAdotante3
                                      : Labels.informativoOng3,
                                  style: ProjectFonts.pLight,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _buildPageIndicator(state.currentPage),
                    ),
                    state.currentPage != _numPages - 1
                        ? Expanded(
                            child: Align(
                              alignment: FractionalOffset.bottomRight,
                              child: TextButton(
                                style: ButtonStyle(
                                  overlayColor: MaterialStateProperty.all(
                                    ProjectColors.primary.withOpacity(0.2),
                                  ),
                                ),
                                onPressed: () => _pc.nextPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.ease,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    Text(
                                      Buttons.proximo,
                                      style: ProjectFonts.pLightBold,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Icon(
                                      Icons.arrow_forward,
                                      color: ProjectColors.light,
                                      size: 30,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 5, left: 25, right: 25),
                              child: Align(
                                alignment: FractionalOffset.bottomCenter,
                                child: AnimatedButton(
                                    route: _option == 'adotante'
                                        ? () async {
                                            final navigator =
                                                Navigator.of(context);
                                            final sp = await SharedPreferences
                                                .getInstance();
                                            sp.setBool('isFirstAccess', false);
                                            sp.setString(
                                                'userType', 'adotante');
                                            navigator.popAndPushNamed(
                                              '/main',
                                            );
                                          }
                                        : () async {
                                            final navigator =
                                                Navigator.of(context);
                                            final sp = await SharedPreferences
                                                .getInstance();
                                            sp.setBool('isFirstAccess', false);
                                            sp.setString('userType', 'ong');
                                            navigator.popAndPushNamed(
                                              '/register',
                                            );
                                          }),
                              ),
                            ),
                          ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
