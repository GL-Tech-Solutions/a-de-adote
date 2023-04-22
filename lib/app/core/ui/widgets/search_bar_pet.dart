import 'package:a_de_adote/app/core/ui/styles/project_colors.dart';
import 'package:a_de_adote/app/core/ui/styles/project_fonts.dart';
import 'package:a_de_adote/app/core/ui/widgets/popup_menu_button_pet_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

// ignore: must_be_immutable
class SearchBarPet extends StatelessWidget {
  final List<String> listaNomes;
  final void Function(String option) searchFunction;

  SearchBarPet({
    super.key,
    required this.listaNomes,
    required this.searchFunction,
  });

  late FocusNode focus;

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable.empty();
        }
        return listaNomes.where(
          (String option) {
            return option.toLowerCase().startsWith(
                  textEditingValue.text.toLowerCase(),
                );
          },
        ).toSet();
      },
      fieldViewBuilder:
          (context, textEditingController, focusNode, onFieldSubmitted) {
        focus = focusNode;
        return TextField(
          controller: textEditingController,
          focusNode: focusNode,
          onEditingComplete: onFieldSubmitted,
          textAlignVertical: TextAlignVertical.center,
          style: ProjectFonts.pLight.copyWith(color: ProjectColors.darkLight),
          decoration: InputDecoration(
            filled: true,
            fillColor: ProjectColors.light,
            isCollapsed: true,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(28),
              ),
            ),
            prefixIcon: const PopupMenuButtonPetFilter(),
            suffixIcon: IconButton(
              onPressed: () {
                searchFunction(textEditingController.text);
                focus.unfocus();
              },
              icon: const Icon(
                Icons.search,
              ),
            ),
            hintText: 'Pesquise um nome',
            hintStyle:
                ProjectFonts.pLight.copyWith(color: ProjectColors.darkLight),
          ),
        );
      },
      optionsViewBuilder: (context, onSelected, options) => Align(
        alignment: Alignment.topLeft,
        child: Material(
          elevation: 4,
          child: SizedBox(
            width: MediaQuery.of(context).size.width - 20,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.4),
              child: ListView.builder(
                itemCount: options.length,
                shrinkWrap: true,
                padding: const EdgeInsets.all(0),
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: 50,
                    child: ListTile(
                      title: Text(
                        options.elementAt(index), //.nome,
                        style: ProjectFonts.smallSecundaryDark.copyWith(
                          color: ProjectColors.darkLight,
                        ),
                      ),
                      onTap: () => onSelected(options.elementAt(index)),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
      onSelected: (option) {
        searchFunction(option);
        focus.unfocus();
      },
    );
  }
}
