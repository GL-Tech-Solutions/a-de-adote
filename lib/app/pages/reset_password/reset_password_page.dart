import 'package:a_de_adote/app/core/ui/widgets/standard_appbar.dart';
import 'package:a_de_adote/app/pages/login/widgets/login_form_input.dart';
import 'package:a_de_adote/app/pages/reset_password/reset_password_controller.dart';
import 'package:a_de_adote/app/pages/reset_password/reset_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:a_de_adote/app/core/constantes/labels.dart';
import 'package:a_de_adote/app/core/constantes/botoes.dart';
import '../../core/ui/styles/project_colors.dart';
import '../../core/ui/styles/project_fonts.dart';
import '../../core/ui/widgets/form_button.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  var _isLoading = false;

  void salvar() async {}

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const StandardAppBar(title: Labels.redefinirSenha),
      backgroundColor: ProjectColors.secondary,
      body: BlocConsumer<ResetPasswordController, ResetPasswordState>(
        listener: (context, state) {
          state.status.matchAny(
            any: () => _isLoading = false,
            loading: () => _isLoading = true,
            loaded: () {
              _isLoading = false;
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: ProjectColors.success,
                  content: Text(
                      'E-mail de redefinição de senha enviado com sucesso.'),
                ),
              );
            },
            error: () {
              _isLoading = false;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage ?? ''),
                ),
              );
            },
          );
        },
        builder: (context, state) {
          return AnnotatedRegion<SystemUiOverlayStyle>(
            value: const SystemUiOverlayStyle(
              systemNavigationBarColor: ProjectColors.secondary,
            ),
            child: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height / 2.5,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  Labels.esqueceuSenha,
                                  style: ProjectFonts.h3LightBold,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  Labels.insiraEmail,
                                  style: ProjectFonts.h5Light,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 45),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              LoginFormInput(
                                type: 'login',
                                controller: _email,
                                labelText: Labels.email,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              FormButton(
                                formKey: _formKey,
                                text: Botoes.enviar,
                                action: () {
                                  final valid =
                                      _formKey.currentState?.validate() ??
                                          false;
                                  if (valid) {
                                    context
                                        .read<ResetPasswordController>()
                                        .resetPasswordOng(_email.text);
                                  }
                                },
                                isLoading: _isLoading,
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
          );
        },
      ),
    );
  }
}
