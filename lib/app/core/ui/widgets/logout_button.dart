import 'package:a_de_adote/app/core/ui/styles/project_colors.dart';
import 'package:a_de_adote/app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final navigator = Navigator.of(context);
        await context.read<AuthService>().signOut();
        navigator.pushNamedAndRemoveUntil('/login', (_) => true);
      },
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: ProjectColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      child: const Icon(
        Icons.logout,
        size: 23,
        color: ProjectColors.light,
      ),
    );
  }
}
