import 'package:a_de_adote/app/core/ui/styles/project_fonts.dart';
import 'package:a_de_adote/app/core/ui/widgets/standard_appbar.dart';
import 'package:a_de_adote/app/core/ui/widgets/standard_drawer.dart';
import 'package:flutter/material.dart';

import '../../core/ui/widgets/container_research.dart';
import '../../core/ui/widgets/standard_sliver_appbar.dart';

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
        child: Scaffold(
          drawer: const StandardDrawer(),
          body: NestedScrollView(
            headerSliverBuilder: (BuildContext context, innerBoxIsScrolled) {
              return [
                StandardSliverAppbar(
                  title: 'Pets',
                  canPop: false,
                  bottom: PreferredSize(
                    preferredSize: Size(
                      MediaQuery.of(context).size.width,
                      MediaQuery.of(context).size.height * 0.05,
                    ),
                    child: const ContainerResearch(),
                  ),
                ),
              ];
            },
            body: const Center(
              child: Text(
                'ONGs',
                style: ProjectFonts.pLight,
              ),
            ),
          ),
        ));
  }
}
