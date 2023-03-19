import 'package:a_de_adote/app/core/ui/widgets/standard_appbar.dart';
import 'package:a_de_adote/app/core/ui/widgets/standard_drawer.dart';
import 'package:flutter/material.dart';

class OngsPage extends StatefulWidget {
  const OngsPage({super.key});

  @override
  State<OngsPage> createState() => _OngsPageState();
}

class _OngsPageState extends State<OngsPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: const Scaffold(
        appBar: StandardAppBar(
          title: 'Pets',
          canPop: false,
        ),
        drawer: StandardDrawer(),
        body: Center(
          child: Text('PetsPage'),
        ),
      ),
    );
  }
}
