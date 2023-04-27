import 'package:a_de_adote/app/core/constants/buttons.dart';
import 'package:a_de_adote/app/core/constants/labels.dart';
import 'package:a_de_adote/app/core/ui/helpers/filters_state.dart';
import 'package:flutter/material.dart';
import 'package:stepper_counter_swipe/stepper_counter_swipe.dart';
import '../styles/project_colors.dart';
import '../styles/project_fonts.dart';
import '../widgets/checkbox_row.dart';
import '../widgets/dropdown_ong/dropdown_ong_router.dart';
import '../widgets/radio_row.dart';
import '../widgets/standard_choice_chip.dart';

mixin BottomSheetPetFilter<T extends StatefulWidget> on State<T> {
  final ValueNotifier<String?> _ong = ValueNotifier('Todas');
  final ValueNotifier<bool> _dog = ValueNotifier(false);
  final ValueNotifier<bool> _cat = ValueNotifier(false);
  final ValueNotifier<bool> _bird = ValueNotifier(false);
  final ValueNotifier<bool> _other = ValueNotifier(false);
  final ValueNotifier<int> _idadeMaxima = ValueNotifier(20);
  final ValueNotifier<int> _sexo = ValueNotifier(0);
  final ValueNotifier<bool> _mini = ValueNotifier(false);
  final ValueNotifier<bool> _pequeno = ValueNotifier(false);
  final ValueNotifier<bool> _medio = ValueNotifier(false);
  final ValueNotifier<bool> _grande = ValueNotifier(false);

  @override
  void dispose() {
    _ong.dispose();
    _dog.dispose();
    _cat.dispose();
    _bird.dispose();
    _other.dispose();
    _idadeMaxima.dispose();
    _sexo.dispose();
    _mini.dispose();
    _pequeno.dispose();
    _medio.dispose();
    _grande.dispose();
    super.dispose();
  }

  Future<Map<String, dynamic>?> setPetFilter(
      bool haveOngDropdown, Map<String, dynamic>? currentFilters) async {
    Map<String, dynamic>? filters;

    if (currentFilters == null) {
      _ong.value = 'Todas';
      _dog.value = false;
      _cat.value = false;
      _bird.value = false;
      _other.value = false;
      _idadeMaxima.value = 20;
      _sexo.value = 0;
      _mini.value = false;
      _pequeno.value = false;
      _medio.value = false;
      _grande.value = false;
    } else {
      _ong.value = currentFilters['ong'];
      _dog.value = currentFilters['dog'];
      _cat.value = currentFilters['cat'];
      _bird.value = currentFilters['bird'];
      _other.value = currentFilters['other'];
      _idadeMaxima.value = currentFilters['idadeMaxima'];
      _sexo.value = currentFilters['sexo'];
      _mini.value = currentFilters['mini'];
      _pequeno.value = currentFilters['pequeno'];
      _medio.value = currentFilters['medio'];
      _grande.value = currentFilters['grande'];

      filters = currentFilters;
    }

    await showModalBottomSheet(
      context: context,
      builder: (_) {
        return Container(
          padding: const EdgeInsets.all(15),
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      Labels.filtros,
                      style: ProjectFonts.h6SecundaryDarkBold,
                    ),
                    TextButton.icon(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(
                        Icons.close,
                        size: 16,
                        color: ProjectColors.danger,
                      ),
                      label: Text(
                        Buttons.fechar,
                        style: ProjectFonts.smallLight
                            .copyWith(color: ProjectColors.danger),
                      ),
                    ),
                  ],
                ),
                Visibility(
                  visible: haveOngDropdown,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Text(
                            Labels.ong,
                            style: ProjectFonts.smallSecundaryDarkBold,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ValueListenableBuilder(
                              valueListenable: _ong,
                              builder: (BuildContext context, String? value,
                                  Widget? child) {
                                return DropdownOngRouter(
                                  value: value!,
                                  dropdownCallback: (selected) {
                                    _ong.value = selected;
                                  },
                                ).page;
                              },
                            ),
                          ),
                        ],
                      ),
                      const Divider(),
                    ],
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Text(
                          Labels.especie,
                          style: ProjectFonts.smallSecundaryDarkBold,
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Wrap(
                        spacing: 10,
                        children: [
                          ValueListenableBuilder(
                            valueListenable: _dog,
                            builder: (BuildContext context, bool isSelected,
                                Widget? child) {
                              return StandardChoiceChip(
                                label: Labels.cachorro,
                                selected: isSelected,
                                choiceChipCallback: (state) {
                                  _dog.value = state!;
                                },
                              );
                            },
                          ),
                          ValueListenableBuilder(
                            valueListenable: _cat,
                            builder: (BuildContext context, bool isSelected,
                                Widget? child) {
                              return StandardChoiceChip(
                                label: Labels.gato,
                                selected: isSelected,
                                choiceChipCallback: (state) {
                                  _cat.value = state!;
                                },
                              );
                            },
                          ),
                          ValueListenableBuilder(
                            valueListenable: _bird,
                            builder: (BuildContext context, bool isSelected,
                                Widget? child) {
                              return StandardChoiceChip(
                                label: Labels.passaro,
                                selected: isSelected,
                                choiceChipCallback: (state) {
                                  _bird.value = state!;
                                },
                              );
                            },
                          ),
                          ValueListenableBuilder(
                            valueListenable: _other,
                            builder: (BuildContext context, bool isSelected,
                                Widget? child) {
                              return StandardChoiceChip(
                                label: Labels.outros,
                                selected: isSelected,
                                choiceChipCallback: (state) {
                                  _other.value = state!;
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: Labels.idadeMaxima,
                            style: ProjectFonts.smallSecundaryDarkBold,
                          ),
                          TextSpan(
                            text: Labels.deslizeParaAlterar,
                            style: ProjectFonts.smallSecundaryDark
                                .copyWith(fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          height: 45,
                          padding: const EdgeInsets.all(4),
                          child: StepperSwipe(
                            initialValue: _idadeMaxima.value,
                            speedTransitionLimitCount: 3,
                            onChanged: (int value) {
                              _idadeMaxima.value = value;
                            },
                            firstIncrementDuration: const Duration(
                              milliseconds: 250,
                            ),
                            secondIncrementDuration: const Duration(
                              milliseconds: 100,
                            ),
                            direction: Axis.horizontal,
                            dragButtonColor: ProjectColors.primary,
                            iconsColor: ProjectColors.secondaryDark,
                            withBackground: true,
                            withSpring: true,
                            withFastCount: true,
                            withPlusMinus: true,
                            maxValue: 20,
                            minValue: 1,
                            stepperValue: 1,
                          ),
                        ),
                        const Text(
                          Labels.anos,
                          style: ProjectFonts.smallSecundaryDark,
                        ),
                      ],
                    )
                  ],
                ),
                const Divider(),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Text(
                          Labels.sexo,
                          style: ProjectFonts.smallSecundaryDarkBold,
                        ),
                      ],
                    ),
                    ValueListenableBuilder(
                      valueListenable: _sexo,
                      builder: (BuildContext context, int sexo, Widget? child) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            RadioRow(
                              labelText: Labels.ambos,
                              labelStyle: ProjectFonts.smallSecundaryDark,
                              state: sexo,
                              value: 0,
                              radioCallback: (value) {
                                _sexo.value = value!;
                              },
                            ),
                            RadioRow(
                              labelText: Labels.masculino,
                              labelStyle: ProjectFonts.smallSecundaryDark,
                              state: sexo,
                              value: 1,
                              radioCallback: (value) {
                                _sexo.value = value!;
                              },
                            ),
                            RadioRow(
                              labelText: Labels.feminino,
                              labelStyle: ProjectFonts.smallSecundaryDark,
                              state: sexo,
                              value: 2,
                              radioCallback: (value) {
                                _sexo.value = value!;
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
                const Divider(),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Text(
                          Labels.porte,
                          style: ProjectFonts.smallSecundaryDarkBold,
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Wrap(
                        spacing: 5,
                        runSpacing: 5,
                        children: [
                          ValueListenableBuilder(
                            valueListenable: _mini,
                            builder: (BuildContext context, bool value,
                                Widget? child) {
                              return CheckboxRow(
                                labelText: Labels.mini,
                                labelStyle: ProjectFonts.smallSecundaryDark,
                                value: value,
                                checkboxCallback: (state) {
                                  _mini.value = state!;
                                },
                              );
                            },
                          ),
                          ValueListenableBuilder(
                            valueListenable: _pequeno,
                            builder: (BuildContext context, bool value,
                                Widget? child) {
                              return CheckboxRow(
                                labelText: Labels.pequeno,
                                labelStyle: ProjectFonts.smallSecundaryDark,
                                value: value,
                                checkboxCallback: (state) {
                                  _pequeno.value = state!;
                                },
                              );
                            },
                          ),
                          ValueListenableBuilder(
                            valueListenable: _medio,
                            builder: (BuildContext context, bool value,
                                Widget? child) {
                              return CheckboxRow(
                                labelText: Labels.medio,
                                labelStyle: ProjectFonts.smallSecundaryDark,
                                value: value,
                                checkboxCallback: (state) {
                                  _medio.value = state!;
                                },
                              );
                            },
                          ),
                          ValueListenableBuilder(
                            valueListenable: _grande,
                            builder: (BuildContext context, bool value,
                                Widget? child) {
                              return CheckboxRow(
                                labelText: Labels.grande,
                                labelStyle: ProjectFonts.smallSecundaryDark,
                                value: value,
                                checkboxCallback: (state) {
                                  _grande.value = state!;
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          _ong.value = 'Todas';
                          _dog.value = false;
                          _cat.value = false;
                          _bird.value = false;
                          _other.value = false;
                          _idadeMaxima.value = 20;
                          _sexo.value = 0;
                          _mini.value = false;
                          _pequeno.value = false;
                          _medio.value = false;
                          _grande.value = false;

                          filters = null;
                          FiltersState.petCurrentFilters = null;
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ProjectColors.light,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: const BorderSide(
                              color: ProjectColors.secondaryDark,
                            ),
                          ),
                        ),
                        child: const Text(
                          Buttons.limparFiltros,
                          style: ProjectFonts.smallSecundaryDarkBold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          filters = {
                            'ong': _ong.value,
                            'dog': _dog.value,
                            'cat': _cat.value,
                            'bird': _bird.value,
                            'other': _other.value,
                            'idadeMaxima': _idadeMaxima.value,
                            'sexo': _sexo.value,
                            'mini': _mini.value,
                            'pequeno': _pequeno.value,
                            'medio': _medio.value,
                            'grande': _grande.value,
                          };

                          FiltersState.petCurrentFilters = filters;
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ProjectColors.primary,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          Buttons.aplicar,
                          style: ProjectFonts.smallLightBold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );

    return filters;
  }
}
