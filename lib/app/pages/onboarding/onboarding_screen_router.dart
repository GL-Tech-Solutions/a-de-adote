import 'package:a_de_adote/app/pages/onboarding/onboarding_screen_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'onboarding_screen_controller.dart';

class OnboardingScreenRouter {
  OnboardingScreenRouter._();

  static Widget get page => MultiProvider(
        providers: [
          Provider<OnboardingScreenController>(
            create: ((context) => OnboardingScreenController()),
          ),
        ],
        child: const OnboardingScreenPage(),
      );
}
