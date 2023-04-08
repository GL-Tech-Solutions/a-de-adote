import 'package:a_de_adote/app/core/ui/widgets/standard_drawer.dart';
import 'package:a_de_adote/app/core/ui/widgets/standard_shimmer_effect.dart';
import 'package:a_de_adote/app/pages/ongs/ongs_controller.dart';
import 'package:a_de_adote/app/pages/ongs/ongs_state.dart';
import 'package:a_de_adote/app/pages/ongs/widgets/ong_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/ui/widgets/container_research.dart';
import '../../core/ui/widgets/standard_sliver_appbar.dart';

class OngsPage extends StatefulWidget {
  const OngsPage({super.key});

  @override
  State<OngsPage> createState() => _OngsPageState();
}

class _OngsPageState extends State<OngsPage> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<OngsController>().loadAllOngs();
    });
  }

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
                title: 'ONGs',
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
          body: BlocConsumer<OngsController, OngsState>(
            listener: (context, state) {
              state.status.matchAny(
                any: () => _isLoading = false,
                loading: () => _isLoading = true,
                error: () {
                  _isLoading = false;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.errorMessage ?? ''),
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
              int length = state.listOngs.length;

              return _isLoading
                  ? ListView.builder(
                      padding: const EdgeInsets.all(10),
                      itemCount: 2,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(top: index == 0 ? 0 : 15.0),
                          child: const SizedBox(
                            height: 285,
                            child: StandardShimmerEffect(),
                          ),
                        );
                      },
                    )
                  //const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      padding: const EdgeInsets.all(10),
                      itemCount: length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(top: index == 0 ? 0 : 10.0),
                          child: OngCard(ong: state.listOngs[index]),
                        );
                      },
                    );
            },
          ),
        ),
      ),
    );
  }
}
