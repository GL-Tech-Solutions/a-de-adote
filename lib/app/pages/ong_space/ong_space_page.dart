import 'dart:ui';

import 'package:a_de_adote/app/core/ui/styles/project_fonts.dart';
import 'package:a_de_adote/app/core/ui/widgets/logout_button.dart';
import 'package:a_de_adote/app/core/ui/widgets/standard_appbar.dart';
import 'package:a_de_adote/app/pages/ong_space/ong_space_controller.dart';
import 'package:a_de_adote/app/pages/ong_space/ong_space_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/ui/styles/project_colors.dart';

class OngSpacePage extends StatefulWidget {
  const OngSpacePage({super.key});

  @override
  State<OngSpacePage> createState() => _OngSpacePageState();
}

class _OngSpacePageState extends State<OngSpacePage> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<OngSpaceController>().loadOng();
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: const StandardAppBar(
          title: 'Dados Ong',
          canPop: false,
        ),
        body: BlocConsumer<OngSpaceController, OngSpaceState>(
          listener: (context, state) {
            state.status.matchAny(
              any: () => _isLoading = false,
              loading: () => _isLoading = true,
              error: () {
                _isLoading = false;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.errorMesssage ?? ''),
                  ),
                );
              },
            );
          },
          buildWhen: (previous, current) => current.status.matchAny(
            any: () => false,
            initial: () => false,
            loading: () => true,
            loaded: () => true,
          ),
          builder: (context, state) {
            return AnnotatedRegion<SystemUiOverlayStyle>(
              value: const SystemUiOverlayStyle(
                systemNavigationBarColor: ProjectColors.secondary,
              ),
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                      children: [
                        Text(
                          state.ong.toString(),
                          style: ProjectFonts.h6Light,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const SizedBox(
                          height: 30,
                          width: 60,
                          child: LogoutButton(),
                        ),
                      ],
                    ),
            );
          },
        ),
      ),
    );
  }
}
