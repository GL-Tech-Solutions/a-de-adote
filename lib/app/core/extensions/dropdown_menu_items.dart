import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../ui/styles/project_colors.dart';
import '../ui/styles/project_fonts.dart';

class DropdownMenuItems {
  static DropdownMenuItems? _instance;

  DropdownMenuItems._();

  static DropdownMenuItems get instance {
    _instance ??= DropdownMenuItems._();
    return _instance!;
  }

  List<DropdownMenuItem<String>> get especies => [
        DropdownMenuItem(
          value: 'Cachorro',
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(
                MaterialCommunityIcons.dog,
                color: ProjectColors.light,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                'Cachorro',
                style: ProjectFonts.pLight,
              )
            ],
          ),
        ),
        DropdownMenuItem(
          value: 'Gato',
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(
                MaterialCommunityIcons.cat,
                color: ProjectColors.light,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                'Gato',
                style: ProjectFonts.pLight,
              )
            ],
          ),
        ),
        DropdownMenuItem(
          value: 'Pássaro',
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(
                MaterialCommunityIcons.bird,
                color: ProjectColors.light,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                'Pássaro',
                style: ProjectFonts.pLight,
              )
            ],
          ),
        ),
        DropdownMenuItem(
          value: 'Outro',
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(
                Icons.pets,
                color: ProjectColors.light,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                'Outro',
                style: ProjectFonts.pLight,
              )
            ],
          ),
        ),
      ];

  List<DropdownMenuItem<String>> get porte => [
        const DropdownMenuItem(
          value: 'Mini',
          child: Text(
            'Mini',
            style: ProjectFonts.pLight,
          ),
        ),
        const DropdownMenuItem(
          value: 'Pequeno',
          child: Text(
            'Pequeno',
            style: ProjectFonts.pLight,
          ),
        ),
        const DropdownMenuItem(
          value: 'Médio',
          child: Text(
            'Médio',
            style: ProjectFonts.pLight,
          ),
        ),
        const DropdownMenuItem(
          value: 'Grande',
          child: Text(
            'Grande',
            style: ProjectFonts.pLight,
          ),
        ),
      ];

  List<DropdownMenuItem<String>> get unidadeIdade => [
        const DropdownMenuItem(
          value: 'meses',
          child: Text(
            'meses',
            style: ProjectFonts.pLight,
          ),
        ),
        const DropdownMenuItem(
          value: 'anos',
          child: Text(
            'anos',
            style: ProjectFonts.pLight,
          ),
        ),
      ];

  List<DropdownMenuItem<String>> get sexo => [
        const DropdownMenuItem(
          value: 'Masculino',
          child: Text(
            'Masculino',
            style: ProjectFonts.pLight,
          ),
        ),
        const DropdownMenuItem(
          value: 'Feminino',
          child: Text(
            'Feminino',
            style: ProjectFonts.pLight,
          ),
        ),
      ];

  List<DropdownMenuItem<String>> get donationOption => [
        const DropdownMenuItem(
          value: 'CNPJ',
          child: Text(
            'CNPJ',
            style: ProjectFonts.pLight,
          ),
        ),
        const DropdownMenuItem(
          value: 'Celular',
          child: Text(
            'Celular',
            style: ProjectFonts.pLight,
          ),
        ),
        const DropdownMenuItem(
          value: 'E-mail',
          child: Text(
            'E-mail',
            style: ProjectFonts.pLight,
          ),
        ),
      ];
}

extension DropdownMenuItemsExtension on BuildContext {
  DropdownMenuItems get dropdownMenuItems => DropdownMenuItems.instance;
}
