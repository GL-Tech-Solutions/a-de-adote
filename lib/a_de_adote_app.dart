import 'package:a_de_adote/app/core/provider/application_binding.dart';
import 'package:a_de_adote/app/core/ui/theme/theme_config.dart';
import 'package:flutter/material.dart';
import 'app/core/constantes/labels.dart';
import 'app/pages/home/main_page.dart';
import 'app/pages/initial/initial_page_animation.dart';
import 'app/pages/login/login_router.dart';
import 'app/pages/onboarding/onboarding_screen_router.dart';
import 'app/pages/ong_register/ong_register_router.dart';
import 'app/pages/ong_space/ong_space_router.dart';

class AdeAdoteApp extends StatelessWidget {
  const AdeAdoteApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ApplicationBinding(
      child: MaterialApp(
        title: Labels.titulo,
        debugShowCheckedModeBanner: false,
        theme: ThemeConfig.theme,
        routes: {
          '/': (_) => const InitialPageAnimation(),
          '/onboarding': (_) => OnboardingScreenRouter.page,
          '/register': (_) => const OngRegisterRouter(),
          '/login': (_) => LoginRouter.page,
          '/main': (_) => const MainPage(),
          '/ong_space': (_) => OngSpaceRouter.page,
        },
      ),
    );
  }
}
