import 'package:a_de_adote/app/core/ui/styles/project_colors.dart';
import 'package:a_de_adote/app/core/ui/styles/project_fonts.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CheckboxRow extends StatelessWidget {
  final String labelText;
  bool value;
  final void Function(bool?)? checkboxCallback;
  final double? gap;

  CheckboxRow(
      {super.key,
      required this.labelText,
      required this.value,
      required this.checkboxCallback,
      this.gap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          labelText,
          style: ProjectFonts.pLight,
        ),
        SizedBox(
          width: gap ?? 11,
        ),
        Container(
          alignment: Alignment.center,
          height: 14,
          width: 14,
          color: ProjectColors.lightDark,
          child: Checkbox(
            value: value,
            onChanged: checkboxCallback,
          ),
        ),
      ],
    );
  }
}
