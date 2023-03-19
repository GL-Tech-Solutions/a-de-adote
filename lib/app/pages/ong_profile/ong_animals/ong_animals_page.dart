import 'package:a_de_adote/app/core/ui/styles/project_colors.dart';
import 'package:flutter/material.dart';

class OngAnimalsPage extends StatefulWidget {
  const OngAnimalsPage({super.key});

  @override
  State<OngAnimalsPage> createState() => _OngAnimalsPageState();
}

class _OngAnimalsPageState extends State<OngAnimalsPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: const Center(
          child: Text('Pets'),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: ProjectColors.primary,
          onPressed: () => Navigator.pushNamed(context, '/pet_register'),
          child: const Icon(
            Icons.add,
            color: ProjectColors.light,
          ),
        ),
      ),
    );
  }
}
