import 'dart:async';

import 'package:a_de_adote/app/core/constants/buttons.dart';
import 'package:a_de_adote/app/core/extensions/dropdown_menu_items.dart';
import 'package:a_de_adote/app/core/extensions/mask_formatters.dart';
import 'package:a_de_adote/app/core/ui/styles/project_colors.dart';
import 'package:a_de_adote/app/core/ui/styles/project_fonts.dart';
import 'package:a_de_adote/app/core/ui/widgets/standard_dropdown.dart';
import 'package:flutter/material.dart';
import '../../constants/labels.dart';
import '../widgets/standard_form_input.dart';

mixin UpdateDialogOngPix<T extends StatefulWidget> on State<T> {
  final _formKey = GlobalKey<FormState>();
  final _donationOptionEC = TextEditingController();
  final ValueNotifier<String?> _donationOptionDBX = ValueNotifier('CNPJ');

  @override
  void dispose() {
    _donationOptionEC.dispose();
    _donationOptionDBX.dispose();
    super.dispose();
  }

  Future<Map<String, dynamic>?> showChangeOngPix(
      Map<String, dynamic>? donationForms) async {
    Map<String, dynamic>? updatedDonationForms;

    if (donationForms != null) {
      _donationOptionDBX.value = donationForms.keys.first;
      _donationOptionEC.text = donationForms.values.first;
    }

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
          Labels.atualizarPix,
          style: ProjectFonts.pLightBold,
        ),
        contentPadding: const EdgeInsets.all(10),
        content: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Form(
            key: _formKey,
            child: ValueListenableBuilder(
              valueListenable: _donationOptionDBX,
              builder: (BuildContext context, String? value, Widget? child) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: StandardDropdown(
                              labelText: value ?? '',
                              items: context.dropdownMenuItems.donationOption,
                              value: value!,
                              dropdownCallback: (selected) {
                                _donationOptionDBX.value = selected;
                              },
                              validator: (option) {
                                if (option!.isEmpty || option == '') {
                                  return Labels.campoInvalido;
                                }
                                return null;
                              }),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: StandardFormInput(
                            controller: _donationOptionEC,
                            labelText: value,
                            fullSelectionText: true,
                            mask: value == Labels.cnpj
                                ? [context.maskFormatters.maskCNPJFormatter]
                                : value == Labels.celular
                                    ? [context.maskFormatters.maskTelFormatter]
                                    : [],
                            inputType: value == Labels.cnpj
                                ? TextInputType.number
                                : value == Labels.celular
                                    ? TextInputType.phone
                                    : TextInputType.emailAddress,
                            validator: (text) {
                              switch (value) {
                                case Labels.cnpj:
                                  if ((text!.isEmpty) || (text.length < 18)) {
                                    return Labels.cnpjValido;
                                  }
                                  break;
                                case Labels.celular:
                                  if ((text!.isEmpty) || (text.length < 15)) {
                                    return Labels.celularValido;
                                  }
                                  break;
                                case Labels.email:
                                  if (text!.isEmpty) {
                                    return Labels.emailValido;
                                  }
                                  break;
                                default:
                                  if (text!.isEmpty) {
                                    return Labels.invalido;
                                  }
                                  break;
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
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
                updatedDonationForms = {
                  _donationOptionDBX.value ?? '': _donationOptionEC.text,
                };
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
            onPressed: () => Navigator.of(context).pop(),
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
    return updatedDonationForms;
  }
}
