import 'package:a_de_adote/app/pages/ong_register/signup_form/ong_signup_form.dart';
import 'package:flutter/material.dart';
import '../../core/ui/widgets/standard_appbar.dart';
import 'cnpj_form/ong_cnpj_form_page.dart';
import 'informations_form/ong_informations_form_page.dart';

class OngRegisterRouter extends StatefulWidget {
  const OngRegisterRouter({Key? key}) : super(key: key);

  @override
  State<OngRegisterRouter> createState() => _OngRegisterRouterState();
}

class _OngRegisterRouterState extends State<OngRegisterRouter> {
  var navKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        var canPopRegister = navKey.currentState?.canPop() ?? false;
        if (canPopRegister) {
          navKey.currentState?.pop();
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
          appBar: const StandardAppBar(title: 'Cadastro'),
          body: Navigator(
            key: navKey,
            initialRoute: '/cnpj',
            onGenerateRoute: (settings) {
              var route = settings.name;
              Widget page;
              switch (route) {
                case '/cnpj':
                  page = const ONGCNPJFormPage();
                  break;
                case '/informacoes':
                  page = const ONGInformationsFormPage();
                  break;
                case '/usuario':
                  page = const ONGSignUpForm();
                  break;
                default:
                  return null;
              }
              return MaterialPageRoute(
                builder: (context) => page,
                settings: settings,
              );
            },
          )),
    );
  }
}