import 'package:a_de_adote/app/core/ui/styles/project_colors.dart';
import 'package:a_de_adote/app/core/ui/styles/project_fonts.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class StandardDropdown extends StatelessWidget {
  final String labelText;
  final List<DropdownMenuItem<String>>? items;
  String value;
  final void Function(String?)? dropdownCallback;
  final String? Function(String?)? validator;

  StandardDropdown({
    super.key,
    required this.labelText,
    required this.items,
    required this.value,
    required this.dropdownCallback,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      items: items,
      value: value,
      onChanged: dropdownCallback,
      validator: validator,
      dropdownColor: ProjectColors.secondaryLight,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: ProjectColors.light),
        ),
        isCollapsed: true,
        filled: true,
        fillColor: ProjectColors.secondaryLight,
        contentPadding: const EdgeInsets.only(left: 14, top: 16, bottom: 16),
        labelText: labelText,
        labelStyle: ProjectFonts.pLight,
      ),
    );
  }
}
