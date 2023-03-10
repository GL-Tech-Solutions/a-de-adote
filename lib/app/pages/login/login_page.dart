import 'dart:ui';
import 'package:a_de_adote/app/pages/login/login_controller.dart';
import 'package:a_de_adote/app/pages/login/login_state.dart';
import 'package:a_de_adote/app/pages/login/widgets/login_form_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/ui/styles/project_colors.dart';
import '../../core/ui/styles/project_fonts.dart';
import '../../core/ui/widgets/form_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _senha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: ProjectColors.secondary,
        body: BlocListener<LoginController, LoginState>(
          listener: (context, state) {
            state.status.matchAny(
              any: () => null,
              loaded: () => Navigator.pushNamed(context, '/ong_space'),
              error: (() => ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.errorMessage ?? ''),
                    ),
                  )),
            );
          },
          child: AnnotatedRegion<SystemUiOverlayStyle>(
            value: const SystemUiOverlayStyle(
                systemNavigationBarColor: ProjectColors.secondary),
            child: Stack(
              children: [
                ShaderMask(
                  shaderCallback: (rect) {
                    return LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent.withOpacity(0.5),
                        Colors.transparent
                      ],
                    ).createShader(
                        Rect.fromLTRB(0, 0, rect.width, rect.height));
                  },
                  blendMode: BlendMode.dstIn,
                  child: Container(
                    width: 500,
                    height: 500,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/images/background/login_page_pets.png'),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 2,
                        sigmaY: 2,
                      ),
                      child: Container(
                        color: Colors.black.withOpacity(0),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: SingleChildScrollView(
                    reverse: true,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                          maxHeight:
                              (MediaQuery.of(context).viewInsets.bottom > 0)
                                  ? MediaQuery.of(context).size.height / 1.8
                                  : MediaQuery.of(context).size.height / 1.4),
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
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 45),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  LoginFormInput(
                                    type: 'login',
                                    controller: _email,
                                    labelText: 'E-mail',
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  LoginFormInput(
                                    type: 'senha',
                                    controller: _senha,
                                    labelText: 'Senha',
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      SizedBox(
                                        height: 30,
                                        child: TextButton(
                                          style: ButtonStyle(
                                            overlayColor:
                                                MaterialStateProperty.all(
                                              ProjectColors.primary
                                                  .withOpacity(0.2),
                                            ),
                                          ),
                                          onPressed: (() => null),
                                          child: const Text(
                                              'Esqueci minha senha.',
                                              style: ProjectFonts.smallLight),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  BlocBuilder<LoginController, LoginState>(
                                    builder: (context, state) {
                                      return FormButton(
                                        formKey: _formKey,
                                        text: 'ENTRAR',
                                        action: () {
                                          bool valid = _formKey.currentState
                                                  ?.validate() ??
                                              false;
                                          if (valid) {
                                            context
                                                .read<LoginController>()
                                                .loginOng(
                                                    _email.text, _senha.text);
                                          }
                                        },
                                        isLoading: state.status.matchAny(
                                          any: () => false,
                                          loading: () => true,
                                        ),
                                      );
                                    },
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  TextButton(
                                    onPressed: (() => null),
                                    style: ButtonStyle(
                                      overlayColor: MaterialStateProperty.all(
                                        ProjectColors.primary.withOpacity(0.2),
                                      ),
                                    ),
                                    child: RichText(
                                      text: const TextSpan(
                                        children: [
                                          TextSpan(
                                              text:
                                                  'Ainda não possui cadastro? ',
                                              style: ProjectFonts.smallLight),
                                          TextSpan(
                                            text: 'Crie uma conta.',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: ProjectColors.primaryLight,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Divider(
                        color: ProjectColors.lightDark,
                      ),
                      TextButton(
                        onPressed: (() => null),
                        style: ButtonStyle(
                          overlayColor: MaterialStateProperty.all(
                            ProjectColors.primary.withOpacity(0.2),
                          ),
                        ),
                        child: RichText(
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                  text: 'Não é uma ONG? ',
                                  style: ProjectFonts.smallLight),
                              TextSpan(
                                text: 'Entrar como Adotante.',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: ProjectColors.light,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
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
    );
  }
}
