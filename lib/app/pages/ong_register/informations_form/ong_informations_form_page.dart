import 'package:a_de_adote/app/core/constants/buttons.dart';
import 'package:a_de_adote/app/core/constants/labels.dart';
import 'package:a_de_adote/app/core/extensions/mask_formatters.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/ui/styles/project_colors.dart';
import '../../../core/ui/styles/project_fonts.dart';
import '../../../core/ui/widgets/form_button.dart';
import '../../../core/ui/widgets/standard_form_input.dart';
import '../../../models/ong_model.dart';

class ONGInformationsFormPage extends StatefulWidget {
  const ONGInformationsFormPage({super.key});

  @override
  State<ONGInformationsFormPage> createState() =>
      _ONGInformationsFormPageState();
}

class _ONGInformationsFormPageState extends State<ONGInformationsFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeFantasia = TextEditingController();
  final _razaoSocial = TextEditingController();
  final _telefone = TextEditingController();
  final _cep = TextEditingController();
  final _logradouro = TextEditingController();
  final _numero = TextEditingController();
  final _bairro = TextEditingController();
  final _complemento = TextEditingController();
  final _cidade = TextEditingController();
  final _uf = TextEditingController();
  final _controller = ScrollController();

  late OngModel? ongModel;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ongModel = ModalRoute.of(context)?.settings.arguments as OngModel;
      _nomeFantasia.text = ongModel?.fantasia ?? '';
      _razaoSocial.text = ongModel?.nome ?? '';
      _telefone.text = ongModel?.telefone ?? '';
      _cep.text = ongModel?.cep ?? '';
      _logradouro.text = ongModel?.logradouro ?? '';
      _numero.text = ongModel?.numero ?? '';
      _bairro.text = ongModel?.bairro ?? '';
      _complemento.text = ongModel?.complemento ?? '';
      _cidade.text = ongModel?.municipio ?? '';
      _uf.text = ongModel?.uf ?? '';
    });
  }

  @override
  void dispose() {
    _nomeFantasia.dispose();
    _razaoSocial.dispose();
    _telefone.dispose();
    _cep.dispose();
    _logradouro.dispose();
    _numero.dispose();
    _bairro.dispose();
    _complemento.dispose();
    _cidade.dispose();
    _uf.dispose();
    super.dispose();
  }

  void salvar() {
    if (_formKey.currentState!.validate()) {
      var model = ongModel?.copyWith(
        fantasia: _nomeFantasia.text,
        nome: _razaoSocial.text,
        telefone: _telefone.text,
        whatsapp: '',
        cep: _cep.text,
        logradouro: _logradouro.text,
        numero: _numero.text,
        bairro: _bairro.text,
        complemento: _complemento.text,
        municipio: _cidade.text,
        uf: _uf.text,
      );
      Navigator.pushNamed(context, '/usuario', arguments: model);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProjectColors.secondary,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          systemNavigationBarColor: ProjectColors.secondary,
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 30,
            ),
            child: SingleChildScrollView(
              controller: _controller,
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Text(
                              Labels.confirmacaoOng,
                              style: ProjectFonts.h4LightBold,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Flexible(
                              child: Text(
                                Labels.alterarDados,
                                style: ProjectFonts.h6Light,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          StandardFormInput(
                            controller: _nomeFantasia,
                            labelText: Labels.nomeFantasia,
                            mask: [LengthLimitingTextInputFormatter(50)],
                            validator: (value) {
                              if (value!.isEmpty) {
                                return Labels.nomeValido;
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          StandardFormInput(
                            controller: _razaoSocial,
                            labelText: Labels.razaoSocial,
                            mask: [LengthLimitingTextInputFormatter(150)],
                            validator: (value) {
                              if (value!.isEmpty) {
                                return Labels.razaoValida;
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          StandardFormInput(
                            controller: _telefone,
                            labelText: Labels.tel,
                            mask: [context.maskFormatters.maskTelFormatter],
                            inputType: TextInputType.phone,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          StandardFormInput(
                            controller: _cep,
                            labelText: Labels.cep,
                            mask: [context.maskFormatters.maskCEPFormatter],
                            inputType: TextInputType.number,
                            validator: (value) {
                              if ((value!.isEmpty) || (value.length < 10)) {
                                return Labels.cepValido;
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 4,
                                child: StandardFormInput(
                                  controller: _logradouro,
                                  labelText: Labels.logradouro,
                                  mask: [LengthLimitingTextInputFormatter(100)],
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return Labels.logValido;
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              Expanded(
                                child: StandardFormInput(
                                  controller: _numero,
                                  labelText: Labels.n,
                                  mask: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(4),
                                  ],
                                  inputType: TextInputType.number,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return Labels.invalido;
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          StandardFormInput(
                            controller: _bairro,
                            labelText: Labels.bairro,
                            mask: [LengthLimitingTextInputFormatter(30)],
                            validator: (value) {
                              if (value!.isEmpty) {
                                return Labels.bairroValido;
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          StandardFormInput(
                            controller: _complemento,
                            labelText: Labels.complemento,
                            mask: [LengthLimitingTextInputFormatter(100)],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 4,
                                child: StandardFormInput(
                                  controller: _cidade,
                                  labelText: Labels.cidade,
                                  mask: [LengthLimitingTextInputFormatter(30)],
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return Labels.cidadeValida;
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              Expanded(
                                child: StandardFormInput(
                                  controller: _uf,
                                  labelText: Labels.uf,
                                  mask: [
                                    FilteringTextInputFormatter.allow(
                                      RegExp(
                                        '[a-zA-Z]',
                                      ),
                                    ),
                                    LengthLimitingTextInputFormatter(2),
                                  ],
                                  inputType: TextInputType.text,
                                  capitalization: TextCapitalization.characters,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return Labels.invalido;
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          FormButton(
                            formKey: _formKey,
                            text: Buttons.proximo,
                            action: salvar,
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
      ),
    );
  }
}
