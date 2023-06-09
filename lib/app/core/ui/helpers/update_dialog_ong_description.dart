import 'dart:async';

import 'package:a_de_adote/app/core/constants/buttons.dart';
import 'package:a_de_adote/app/core/constants/labels.dart';
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
        surfaceTintColor: ProjectColors.secondary,
        titlePadding: const EdgeInsets.only(
          left: 12,
          right: 12,
          top: 24,
          bottom: 0,
        ),
        title: const Text(
          Labels.atualizarDescricao,
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
              labelText: Labels.sobre,
              maxLength: 600,
              validator: Validatorless.required(Labels.sobreValido),
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
                FocusManager.instance.primaryFocus?.unfocus();
                descricao = _sobre.text;
                Timer(
                  const Duration(milliseconds: 100),
                  () => Navigator.of(context).pop(),
                );
              }
            },
            child: Text(
              Buttons.salvar,
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
              Buttons.cancelar,
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
