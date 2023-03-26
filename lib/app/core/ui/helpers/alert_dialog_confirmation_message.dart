import 'package:a_de_adote/app/core/ui/styles/project_colors.dart';
import 'package:a_de_adote/app/core/ui/styles/project_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

mixin AlertDialogConfirmationMessage<T extends StatefulWidget> on State<T> {
  Future<bool?> confimAction(String message) async {
    bool? confirm;
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(
          MaterialCommunityIcons.alert_circle_outline,
          size: 32,
          color: ProjectColors.danger,
        ),
        content: Text(
          message,
          style: ProjectFonts.pSecundaryDark,
        ),
        actions: [
          TextButton(
            onPressed: () {
              confirm = true;
              Navigator.of(context).pop();
            },
            child: Text(
              'CONFIRMAR',
              style: ProjectFonts.pSecundaryDark.copyWith(
                color: const Color.fromARGB(255, 158, 158, 158),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              confirm = false;
              Navigator.of(context).pop();
            },
            child: Text(
              'CANCELAR',
              style: ProjectFonts.pSecundaryDark.copyWith(
                color: ProjectColors.danger,
              ),
            ),
          ),
        ],
      ),
    );
    return confirm;
  }
}
