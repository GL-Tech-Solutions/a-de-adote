import 'package:a_de_adote/app/core/ui/styles/project_colors.dart';
import 'package:a_de_adote/app/core/ui/styles/project_fonts.dart';
import 'package:a_de_adote/app/models/pet_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class SearchBarPet extends StatelessWidget {
  final List<PetModel> listaPets;

  const SearchBarPet({super.key, required this.listaPets});

  @override
  Widget build(BuildContext context) {
    return Autocomplete<PetModel>(
      displayStringForOption: (PetModel pet) => pet.nome,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable.empty();
        }
        return listaPets.where(
          (PetModel option) {
            return option.nome.toLowerCase().contains(
                  textEditingValue.text.toLowerCase(),
                );
          },
        );
      },
      fieldViewBuilder:
          (context, textEditingController, focusNode, onFieldSubmitted) =>
              TextField(
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
          prefixIcon: IconButton(
            onPressed: () {},
            icon: const Icon(
              MaterialCommunityIcons.filter_variant,
            ),
          ),
          suffixIcon: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
            ),
          ),
          hintText: 'Pesquise um nome',
          hintStyle:
              ProjectFonts.pLight.copyWith(color: ProjectColors.darkLight),
        ),
      ),
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
                        options.elementAt(index).nome,
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
    );
  }
}
