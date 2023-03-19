import 'package:a_de_adote/app/pages/home/main_page.dart';
import 'package:a_de_adote/app/pages/initial/initial_page_animation.dart';
import 'package:a_de_adote/app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../login/login_router.dart';
import '../ong_space/ong_space_router.dart';

class InitialPageCheck extends StatelessWidget {
  final SharedPreferences sp;

  const InitialPageCheck({super.key, required this.sp});

  @override
  Widget build(BuildContext context) {
    bool isFirstAccess = sp.getBool('isFirstAccess') ?? true;
    String userType = sp.getString('userType') ?? '';
    if (isFirstAccess) {
      return const InitialPageAnimation();
    } else {
      if (userType == 'adotante') {
        return const MainPage();
      } else if (userType == 'ong') {
        if (Provider.of<AuthService>(context).ongUser == null) {
          return LoginRouter.page;
        }
        return const MainPage();
      } else {
        return const InitialPageAnimation();
      }
    }
  }
}
