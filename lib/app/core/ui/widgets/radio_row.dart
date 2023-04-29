import 'package:flutter/material.dart';
import '../styles/project_fonts.dart';

// ignore: must_be_immutable
class RadioRow extends StatelessWidget {
  final String labelText;
  final TextStyle? labelStyle;
  int state;
  int value;
  final void Function(int?)? radioCallback;
  final double? gap;

  RadioRow({
    super.key,
    required this.labelText,
    this.labelStyle,
    required this.state,
    required this.value,
    required this.radioCallback,
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
        Radio(
          groupValue: state,
          value: value,
          onChanged: radioCallback,
          materialTapTargetSize: MaterialTapTargetSize.padded,
        ),
      ],
    );
  }
}
