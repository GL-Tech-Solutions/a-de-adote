import 'package:a_de_adote/app/core/ui/styles/project_colors.dart';
import 'package:a_de_adote/app/core/ui/styles/project_fonts.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class StandardChoiceChip extends StatelessWidget {
  final String label;
  final Widget? avatar;
  bool selected;
  final void Function(bool?)? choiceChipCallback;

  StandardChoiceChip({
    super.key,
    required this.label,
    this.avatar,
    required this.selected,
    required this.choiceChipCallback,
  });

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      avatar: avatar,
      label: Text(
        label,
        style: ProjectFonts.smallSecundaryDark,
      ),
      selected: selected,
      onSelected: choiceChipCallback,
      side: BorderSide.none,
      backgroundColor: ProjectColors.lightDark,
      selectedColor: ProjectColors.primary.withOpacity(0.4),
    );
  }
}
