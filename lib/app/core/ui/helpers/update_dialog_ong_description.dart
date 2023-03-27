import 'package:a_de_adote/app/core/ui/styles/project_colors.dart';
import 'package:a_de_adote/app/core/ui/styles/project_fonts.dart';
import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';
import '../widgets/expanded_form_input.dart';

mixin UpdateDialogOngDescription<T extends StatefulWidget> on State<T> {
  final _formKey = GlobalKey<FormState>();
  final _sobre = TextEditingController();

  @override
  void dispose() {
    _sobre.dispose();
    super.dispose();
  }

  Future<String?> showChangeDescription(String? currentDescription) async {
    String? descricao;
    _sobre.text = currentDescription ?? '';
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: ProjectColors.secondary,
        //shadowColor: ProjectColors.secondary,
        surfaceTintColor: ProjectColors.secondary,
        titlePadding: const EdgeInsets.only(
          left: 12,
          right: 12,
          top: 24,
          bottom: 0,
        ),
        title: const Text(
          'Atualizar descrição da ONG',
          style: ProjectFonts.pLightBold,
        ),
        contentPadding: const EdgeInsets.all(10),
        content: SizedBox(
          height: MediaQuery.of(context).size.width * 0.8,
          width: MediaQuery.of(context).size.width,
          child: Form(
            key: _formKey,
            child: ExpandedFormInput(
              controller: _sobre,
              labelText: 'Sobre',
              validator:
                  Validatorless.required('Por favor, insira uma descrição.'),
            ),
          ),
        ),
        actionsPadding: const EdgeInsets.only(
          bottom: 10,
          right: 10,
        ),
        actions: [
          TextButton(
            onPressed: () {
              final valid = _formKey.currentState?.validate() ?? false;
              if (valid) {
                descricao = _sobre.text;
                Navigator.of(context).pop();
              }
            },
            child: Text(
              'SALVAR',
              style: ProjectFonts.pSecundaryDark.copyWith(
                color: ProjectColors.primaryLight,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'CANCELAR',
              style: ProjectFonts.pSecundaryDark.copyWith(
                color: ProjectColors.lightDark,
              ),
            ),
          ),
        ],
      ),
    );
    return descricao;
  }
}
