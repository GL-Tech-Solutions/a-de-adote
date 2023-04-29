import 'package:a_de_adote/app/core/ui/styles/project_fonts.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CheckboxRow extends StatelessWidget {
  final String labelText;
  final TextStyle? labelStyle;
  bool value;
  final void Function(bool?)? checkboxCallback;
  final double? gap;

  CheckboxRow({
    super.key,
    required this.labelText,
    this.labelStyle,
    required this.value,
    required this.checkboxCallback,
    this.gap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          labelText,
          style: labelStyle ?? ProjectFonts.pLight,
        ),
        SizedBox(
          width: gap ?? 0,
        ),
        Checkbox(
          value: value,
          onChanged: checkboxCallback,
          materialTapTargetSize: MaterialTapTargetSize.padded,
        ),
      ],
    );
  }
}
