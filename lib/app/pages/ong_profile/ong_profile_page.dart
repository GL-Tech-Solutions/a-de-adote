import 'package:a_de_adote/app/core/ui/styles/project_colors.dart';
import 'package:a_de_adote/app/pages/ong_profile/ong_animals/ong_animals_router.dart';
import 'package:a_de_adote/app/pages/ong_profile/ong_space/ong_space_router.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../core/ui/widgets/standard_drawer.dart';
import '../../core/ui/widgets/standard_sliver_appbar.dart';

class OngProfilePage extends StatefulWidget {
  const OngProfilePage({super.key});

  @override
  State<OngProfilePage> createState() => _OngProfilePageState();
}

class _OngProfilePageState extends State<OngProfilePage>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  final ValueNotifier<int> _currentTab = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
      animationDuration: const Duration(milliseconds: 200),
    );
    _tabController.animation?.addListener(() {
      _currentTab.value = _tabController.index;
    });
  }

  @override
  void dispose() {
    _currentTab.dispose();
    super.dispose();
  }

  TabBar get _tabBar => TabBar(
        indicatorColor: ProjectColors.primaryLight,
        labelColor: ProjectColors.light,
        unselectedLabelColor: ProjectColors.light.withOpacity(0.7),
        controller: _tabController,
        tabs: const [
          Tab(
            text: 'Meus dados',
          ),
          Tab(
            text: 'Meus animais',
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const StandardDrawer(),
      body: ValueListenableBuilder(
        valueListenable: _currentTab,
        builder: (BuildContext context, int tab, Widget? child) {
          return NestedScrollView(
            headerSliverBuilder: (BuildContext context, innerBoxIsScrolled) {
              return [
                StandardSliverAppbar(
                  title: 'Perfil',
                  bottom: PreferredSize(
                    preferredSize: _tabBar.preferredSize,
                    child: Material(
                      color: ProjectColors.secondaryDark,
                      child: _tabBar,
                    ),
                  ),
                ),
              ];
            },
            body: TabBarView(
              dragStartBehavior: DragStartBehavior.start,
              controller: _tabController,
              physics: const ClampingScrollPhysics(),
              children: [
                OngSpaceRouter.page,
                OngAnimalsRouter.page,
              ],
            ),
          );
        },
      ),
    );
  }
}
