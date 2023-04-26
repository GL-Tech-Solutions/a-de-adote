import 'package:flutter/material.dart';
import '../../../core/constantes/labels.dart';
import '../../../core/ui/styles/project_colors.dart';
import '../../../core/ui/styles/project_fonts.dart';

class LoginFormInput extends StatefulWidget {
  final String type;
  final TextEditingController controller;
  final String labelText;
  final int? maxLength;
  final bool? fullSelectionText;
  final String? Function(String?)? validator;

  const LoginFormInput({
    super.key,
    required this.type,
    required this.controller,
    required this.labelText,
    this.maxLength,
    this.fullSelectionText,
    this.validator,
  });

  @override
  State<LoginFormInput> createState() => _LoginFormInputState();
}

class _LoginFormInputState extends State<LoginFormInput> {
  bool visibility = true;
  bool senhaFocused = false;
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
    return FocusScope(
      child: Focus(
        onFocusChange: (focus) {
          setState(() {
            senhaFocused = focus;
          });
        },
        child: TextFormField(
          controller: widget.controller,
          focusNode: _focusNode,
          style: ProjectFonts.pLight,
          maxLength: widget.maxLength,
          decoration: InputDecoration(
            suffixIcon: widget.type == 'login' || widget.type == 'signup_senha'
                ? null
                : IconButton(
                    color: senhaFocused
                        ? ProjectColors.lightDark
                        : ProjectColors.darkLight,
                    icon: (visibility)
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                    onPressed: (() {
                      setState(() {
                        visibility = visibility == true ? false : true;
                      });
                    })),
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
            labelText: widget.labelText,
            labelStyle: ProjectFonts.pLight,
            errorStyle: const TextStyle(
              color: ProjectColors.danger,
              fontWeight: FontWeight.bold,
            ),
          ),
          obscureText: (widget.type == 'login') ? false : visibility,
          keyboardType:
              (widget.type == 'login') ? TextInputType.emailAddress : null,
          validator: widget.validator ??
              (value) {
                if (widget.type == 'login') {
                  if (value!.isEmpty) {
                    return Labels.emailValido;
                  }
                } else {
                  if (value!.isEmpty || value.length < 6) {
                    return Labels.senhaValida;
                  }
                }
                return null;
              },
        ),
      ),
    );
  }
}
