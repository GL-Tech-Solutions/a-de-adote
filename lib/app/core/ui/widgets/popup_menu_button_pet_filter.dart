import 'package:a_de_adote/app/core/ui/styles/project_colors.dart';
import 'package:a_de_adote/app/core/ui/widgets/dropdown_ong/dropdown_ong_router.dart';
import 'package:a_de_adote/app/core/ui/widgets/standard_choice_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../styles/project_fonts.dart';

class PopupMenuButtonPetFilter extends StatefulWidget {
  const PopupMenuButtonPetFilter({super.key});

  @override
  State<PopupMenuButtonPetFilter> createState() =>
      _PopupMenuButtonPetFilterState();
}

class _PopupMenuButtonPetFilterState extends State<PopupMenuButtonPetFilter> {
  final ValueNotifier<String?> _ong = ValueNotifier('Todas');
  final ValueNotifier<bool> _dog = ValueNotifier(false);
  final ValueNotifier<bool> _cat = ValueNotifier(false);
  final ValueNotifier<bool> _bird = ValueNotifier(false);
  final ValueNotifier<bool> _other = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      shadowColor: ProjectColors.lightDark,
      surfaceTintColor: ProjectColors.lightDark,
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width,
      ),
      position: PopupMenuPosition.under,
      icon: const Icon(
        MaterialCommunityIcons.filter_variant,
      ),
      itemBuilder: (context) => [
        PopupMenuItem(
          enabled: false,
          child: Container(
            padding: const EdgeInsets.all(6),
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Text(
                          'ONG',
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
                          'Espécie',
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
                                label: 'Cachorro',
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
                                label: 'Gato',
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
                                label: 'Pássaro',
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
                                label: 'Outros',
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
              ],
            ),
          ),
        ),
      ],
    );
  }
}
