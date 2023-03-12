import 'package:flutter/material.dart';
import '../../core/ui/styles/project_colors.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: const Scaffold(
        backgroundColor: ProjectColors.lightDark,
        body: Center(
          child: Text('MainPage'),
        ),
      ),
    );
  }
}
