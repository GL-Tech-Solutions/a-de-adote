import 'package:a_de_adote/app/core/provider/application_binding.dart';
import 'package:a_de_adote/app/core/ui/theme/theme_config.dart';
import 'package:a_de_adote/app/pages/initial/initial_page_check.dart';
import 'package:a_de_adote/app/pages/ong_profile/ong_profile_page.dart';
import 'package:a_de_adote/app/pages/ongs/ongs_page.dart';
import 'package:a_de_adote/app/pages/pet_register/pet_register_page.dart';
import 'package:a_de_adote/app/pages/pet_register/pet_register_router.dart';
import 'package:a_de_adote/app/pages/pets/pets_page.dart';
import 'package:a_de_adote/app/pages/pets/pets_router.dart';
import 'package:a_de_adote/app/pages/reset_password/reset_password_router.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app/core/constantes/labels.dart';
import 'app/pages/home/main_page.dart';
import 'app/pages/login/login_router.dart';
import 'app/pages/onboarding/onboarding_screen_router.dart';
import 'app/pages/ong_register/ong_register_router.dart';

class AdeAdoteApp extends StatelessWidget {
  final SharedPreferences sp;

  const AdeAdoteApp({Key? key, required this.sp}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ApplicationBinding(
      child: MaterialApp(
        title: Labels.titulo,
        debugShowCheckedModeBanner: false,
        theme: ThemeConfig.theme,
        routes: {
          '/': (context) => InitialPageCheck(sp: sp),
          '/onboarding': (_) => OnboardingScreenRouter.page,
          '/register': (_) => const OngRegisterRouter(),
          '/login': (_) => LoginRouter.page,
          '/login/reset_password': (_) => ResetPasswordRouter.page,
          '/main': (_) => const MainPage(),
          '/pets': (_) => PetsRouter.page,
          '/ongs': (_) => const OngsPage(),
          '/ong_profile': (_) => const OngProfilePage(),
          '/pet_register': (_) => PetRegisterRouter.page,
        },
      ),
    );
  }
}
