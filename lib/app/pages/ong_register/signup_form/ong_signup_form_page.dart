import 'package:a_de_adote/app/core/extensions/mask_formatters.dart';
import 'package:a_de_adote/app/core/ui/widgets/standard_form_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validatorless/validatorless.dart';
import '../../../core/ui/styles/project_colors.dart';
import '../../../core/ui/styles/project_fonts.dart';
import '../../../core/ui/widgets/form_button.dart';
import '../../../models/ong_model.dart';
import '../../login/widgets/login_form_input.dart';
import 'ong_signup_form_controller.dart';
import 'ong_signup_form_state.dart';

class ONGSignUpFormPage extends StatefulWidget {
  const ONGSignUpFormPage({super.key});

  @override
  State<ONGSignUpFormPage> createState() => _ONGSignUpFormPageState();
}

class _ONGSignUpFormPageState extends State<ONGSignUpFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _whatsapp = TextEditingController();
  final _email = TextEditingController();
  final _senha = TextEditingController();
  final _confirmarSenha = TextEditingController();
  bool _isLoading = false;

  late OngModel ongModel;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ongModel = ModalRoute.of(context)?.settings.arguments as OngModel;
      _email.text = ongModel.email;
    });
  }

  @override
  void dispose() {
    _whatsapp.dispose();
    _email.dispose();
    _senha.dispose();
    _confirmarSenha.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProjectColors.secondary,
      body: BlocConsumer<OngSignupFormController, OngSignupFormState>(
        listener: (context, state) {
          state.status.matchAny(
            any: () => _isLoading = false,
            loading: () => _isLoading = true,
            userCreated: () {
              _isLoading = false;
              Navigator.of(context, rootNavigator: true)
                  .popAndPushNamed('/main');
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
                    maxHeight: MediaQuery.of(context).size.height / 1.5,
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
                                  'Último passo!',
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
                                  'Vamos agora criar seu usuário.',
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
                              StandardFormInput(
                                controller: _whatsapp,
                                labelText: 'WhatsApp',
                                mask: [context.maskFormatters.maskTelFormatter],
                                inputType: TextInputType.phone,
                                trailing: const Tooltip(
                                  triggerMode: TooltipTriggerMode.tap,
                                  preferBelow: false,
                                  message:
                                      'Será a forma direta que o adotante irá entrar em contato.',
                                  child: Icon(
                                    Icons.info_outline,
                                    color: ProjectColors.lightDark,
                                  ),
                                ),
                                validator: Validatorless.required(
                                    'Forneça um WhatsApp!'),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              LoginFormInput(
                                type: 'login',
                                controller: _email,
                                labelText: 'E-mail',
                                maxLength: 256,
                                fullSelectionText: true,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              LoginFormInput(
                                type: 'signup_senha',
                                controller: _senha,
                                labelText: 'Senha',
                                maxLength: 50,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              LoginFormInput(
                                type: 'signup_senha',
                                controller: _confirmarSenha,
                                labelText: 'Confirmar Senha',
                                maxLength: 50,
                                validator: (value) {
                                  if (value != _senha.text) {
                                    return 'Senhas não conferem!';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              FormButton(
                                formKey: _formKey,
                                text: 'CADASTRAR',
                                action: () {
                                  if (_formKey.currentState!.validate()) {
                                    final ong = ongModel.copyWith(
                                        email: _email.text,
                                        whatsapp: _whatsapp.text);
                                    context
                                        .read<OngSignupFormController>()
                                        .signUpOng(ong, _senha.text);
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
