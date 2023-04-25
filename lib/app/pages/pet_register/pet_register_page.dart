import 'package:a_de_adote/app/core/extensions/dropdown_menu_items.dart';
import 'package:a_de_adote/app/core/ui/helpers/alert_dialog_alert.dart';
import 'package:a_de_adote/app/core/ui/styles/project_colors.dart';
import 'package:a_de_adote/app/core/ui/widgets/checkbox_row.dart';
import 'package:a_de_adote/app/core/ui/widgets/expanded_form_input.dart';
import 'package:a_de_adote/app/core/ui/widgets/form_button.dart';
import 'package:a_de_adote/app/core/ui/widgets/standard_appbar.dart';
import 'package:a_de_adote/app/core/ui/widgets/standard_dropdown.dart';
import 'package:a_de_adote/app/core/ui/widgets/standard_form_input.dart';
import 'package:a_de_adote/app/models/pet_model.dart';
import 'package:a_de_adote/app/pages/pet_register/pet_register_controller.dart';
import 'package:a_de_adote/app/pages/pet_register/pet_register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validatorless/validatorless.dart';
import '../../core/ui/helpers/bottom_sheet_image_source.dart';

class PetRegisterPage extends StatefulWidget {
  const PetRegisterPage({super.key});

  @override
  State<PetRegisterPage> createState() => _PetRegisterPageState();
}

class _PetRegisterPageState extends State<PetRegisterPage>
    with BottomSheetImageSource, AlertDialogAlert {
  final _formKey = GlobalKey<FormState>();
  final _nome = TextEditingController();
  final ValueNotifier<String?> _especie = ValueNotifier('Cachorro');
  final ValueNotifier<String?> _porte = ValueNotifier('Pequeno');
  final ValueNotifier<String?> _unidadeIdade = ValueNotifier('meses');
  final ValueNotifier<String?> _sexo = ValueNotifier('Masculino');
  final _idadeAproximada = TextEditingController();
  final ValueNotifier<bool> _castrado = ValueNotifier(true);
  final ValueNotifier<bool> _vacina1 = ValueNotifier(false);
  final ValueNotifier<bool> _vacina2 = ValueNotifier(false);
  final ValueNotifier<bool> _vacina3 = ValueNotifier(false);
  final _sobre = TextEditingController();

  //TODO Alterar o salvamento de "anos" para o singular quando for apenas 1
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const StandardAppBar(title: 'Cadastrar animal'),
      body: BlocListener<PetRegisterController, PetRegisterState>(
        listener: (context, state) {
          state.status.matchAny(
            any: () => null,
            petCreated: () => Navigator.of(context).pop(),
            error: () => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? ''),
              ),
            ),
          );
        },
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: const SystemUiOverlayStyle(
              systemNavigationBarColor: ProjectColors.secondary),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: SingleChildScrollView(
                reverse: true,
                physics: const ClampingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BlocBuilder<PetRegisterController, PetRegisterState>(
                        builder: (context, state) {
                          return Container(
                            height: MediaQuery.of(context).size.height * 0.24,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: ProjectColors.lightDark,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: ProjectColors.primaryLight,
                                width: 2,
                              ),
                              image: DecorationImage(
                                image: state.status.matchAny(
                                  any: () => const AssetImage(
                                    'assets/images/support/add_a_photo_pet.png',
                                  ),
                                  loading: () => Image.file(
                                    state.image!,
                                  ).image,
                                  imageLoaded: () => Image.file(
                                    state.image!,
                                  ).image,
                                ),
                                fit: state.status.matchAny(
                                  any: () => BoxFit.scaleDown,
                                  loading: () => BoxFit.cover,
                                  imageLoaded: () => BoxFit.cover,
                                ),
                              ),
                            ),
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: InkWell(
                                    onTap: () async {
                                      final source = await setImageSorce();
                                      if (source != null) {
                                        // ignore: use_build_context_synchronously
                                        context
                                            .read<PetRegisterController>()
                                            .pickImage(source);
                                      }
                                    },
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.05,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: ProjectColors.secondaryDark
                                            .withOpacity(0.9),
                                        borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(9),
                                          bottomRight: Radius.circular(9),
                                        ),
                                      ),
                                      child: Center(
                                        child: Icon(
                                          Icons.photo_camera_outlined,
                                          color: ProjectColors.light,
                                          size: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.025,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            StandardFormInput(
                              controller: _nome,
                              labelText: 'Nome',
                              validator: Validatorless.required(
                                'Por favor, insira um nome!',
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ValueListenableBuilder(
                              valueListenable: _especie,
                              builder: (BuildContext context, String? value,
                                  Widget? child) {
                                return StandardDropdown(
                                  labelText: 'Espécie',
                                  items: context.dropdownMenuItems.especies,
                                  value: value!,
                                  dropdownCallback: (selected) {
                                    _especie.value = selected;
                                  },
                                  validator: Validatorless.required(
                                    'Por favor, insira uma espécie!',
                                  ),
                                );
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: ValueListenableBuilder(
                                    valueListenable: _porte,
                                    builder: (BuildContext context,
                                        String? value, Widget? child) {
                                      return StandardDropdown(
                                        labelText: 'Porte',
                                        items: context.dropdownMenuItems.porte,
                                        value: value!,
                                        dropdownCallback: (selected) {
                                          _porte.value = selected;
                                        },
                                        validator: Validatorless.required(
                                          'Por favor, insira um porte!',
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: ValueListenableBuilder(
                                    valueListenable: _sexo,
                                    builder: (BuildContext context,
                                        String? value, Widget? child) {
                                      return StandardDropdown(
                                        labelText: 'Sexo',
                                        items: context.dropdownMenuItems.sexo,
                                        value: value!,
                                        dropdownCallback: (selected) {
                                          _sexo.value = selected;
                                        },
                                        validator: Validatorless.required(
                                          'Válor inválido!',
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: StandardFormInput(
                                    controller: _idadeAproximada,
                                    labelText: 'Idade aproximada',
                                    validator: Validatorless.required(
                                      'Insira uma idade!',
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: ValueListenableBuilder(
                                    valueListenable: _unidadeIdade,
                                    builder: (BuildContext context,
                                        String? value, Widget? child) {
                                      return StandardDropdown(
                                        labelText: '',
                                        items: context
                                            .dropdownMenuItems.unidadeIdade,
                                        value: value!,
                                        dropdownCallback: (selected) {
                                          _unidadeIdade.value = selected;
                                        },
                                        validator: Validatorless.required(
                                          'Válor inválido!',
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ValueListenableBuilder(
                                    valueListenable: _castrado,
                                    builder: (BuildContext context, bool value,
                                        Widget? child) {
                                      return CheckboxRow(
                                        labelText: 'Castrado',
                                        value: value,
                                        checkboxCallback: (state) {
                                          _castrado.value = state!;
                                        },
                                      );
                                    },
                                  ),
                                  ValueListenableBuilder(
                                    valueListenable: _vacina1,
                                    builder: (BuildContext context, bool value,
                                        Widget? child) {
                                      return CheckboxRow(
                                        labelText: 'Vacina 1',
                                        value: value,
                                        checkboxCallback: (state) {
                                          _vacina1.value = state!;
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 0,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ValueListenableBuilder(
                                    valueListenable: _vacina2,
                                    builder: (BuildContext context, bool value,
                                        Widget? child) {
                                      return CheckboxRow(
                                        labelText: 'Vacina 2',
                                        value: value,
                                        gap: 3,
                                        checkboxCallback: (state) {
                                          _vacina2.value = state!;
                                        },
                                      );
                                    },
                                  ),
                                  ValueListenableBuilder(
                                    valueListenable: _vacina3,
                                    builder: (BuildContext context, bool value,
                                        Widget? child) {
                                      return CheckboxRow(
                                        labelText: 'Vacina 3',
                                        value: value,
                                        checkboxCallback: (state) {
                                          _vacina3.value = state!;
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            ExpandedFormInput(
                              controller: _sobre,
                              labelText: 'Sobre',
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            BlocBuilder<PetRegisterController,
                                PetRegisterState>(
                              builder: (context, state) {
                                return FormButton(
                                  formKey: _formKey,
                                  text: 'CADASTRAR',
                                  action: () {
                                    final valid =
                                        (_formKey.currentState?.validate() ??
                                                false) &&
                                            state.image != null;
                                    if (state.image == null) {
                                      showAlert('Por favor, insira uma foto.');
                                    }
                                    if (valid) {
                                      final PetModel pet = PetModel(
                                        nome: _nome.text,
                                        idadeAproximada:
                                            '${_idadeAproximada.text} ${_unidadeIdade.value}',
                                        especie: _especie.value!,
                                        sexo: _sexo.value!,
                                        porte: _porte.value!,
                                        castrado: _castrado.value,
                                        vacinas: {
                                          'vacina1': _vacina1.value,
                                          'vacina2': _vacina2.value,
                                          'vacina3': _vacina3.value,
                                        },
                                        descricao: _sobre.text,
                                      );
                                      context
                                          .read<PetRegisterController>()
                                          .registerPet(pet, state.image);
                                    }
                                  },
                                  isLoading: state.status.matchAny(
                                    any: () => false,
                                    loading: () => true,
                                  ),
                                );
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
