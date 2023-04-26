import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../styles/project_colors.dart';
import '../styles/project_fonts.dart';

class StandardFormInput extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String? hintText;
  final int? maxLength;
  final bool? fullSelectionText;
  final Widget? trailing;
  final List<TextInputFormatter>? mask;
  final TextInputType? inputType;
  final TextCapitalization? capitalization;
  final String? Function(String?)? validator;

  const StandardFormInput({
    super.key,
    required this.controller,
    required this.labelText,
    this.hintText,
    this.maxLength,
    this.fullSelectionText,
    this.trailing,
    this.mask,
    this.inputType,
    this.capitalization,
    this.validator,
  });

  @override
  State<StandardFormInput> createState() => _StandardFormInputState();
}

class _StandardFormInputState extends State<StandardFormInput> {
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    (widget.fullSelectionText == null || widget.fullSelectionText == false)
        ? null
        : _focusNode.addListener(() {
            if (_focusNode.hasFocus) {
              widget.controller.selection = TextSelection(
                baseOffset: 0,
                extentOffset: widget.controller.value.text.length,
              );
            }
          });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: widget.controller,
        focusNode: _focusNode,
        style: ProjectFonts.pLight,
        maxLength: widget.maxLength,
        decoration: InputDecoration(
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(6),
              ),
              borderSide: BorderSide(
                color: ProjectColors.light,
              ),
            ),
            errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(6),
              ),
              borderSide: BorderSide(
                color: ProjectColors.danger,
              ),
            ),
            isCollapsed: true,
            contentPadding:
                const EdgeInsets.only(left: 14, top: 16, bottom: 16),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(6),
              ),
            ),
            filled: true,
            fillColor: ProjectColors.light.withOpacity(0.2),
            counterText: '',
            hintText: widget.hintText,
            hintStyle: const TextStyle(
              color: ProjectColors.secondary,
            ),
            labelText: widget.labelText,
            labelStyle: ProjectFonts.pLight,
            errorStyle: const TextStyle(
              color: ProjectColors.danger,
              fontWeight: FontWeight.bold,
            ),
            suffixIcon: widget.trailing),
        keyboardType: widget.inputType,
        inputFormatters: widget.mask,
        textCapitalization: widget.capitalization ?? TextCapitalization.none,
        validator: widget.validator);
  }
}
