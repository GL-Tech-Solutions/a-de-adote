import 'package:flutter/material.dart';
import '../../../core/ui/styles/project_colors.dart';
import '../../../core/ui/styles/project_fonts.dart';

class OngProfileAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final TabBar tabBar;

  const OngProfileAppbar({
    super.key,
    required this.title,
    required this.tabBar,
  });

  @override
  Widget build(BuildContext context) {
    //* Usando theme porque a cor do BackButton fica sempre preto se utilizado o Material 3.
    return Theme(
      data: ThemeData(
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(color: ProjectColors.light),
        ),
        useMaterial3: false,
      ),
      child: SliverAppBar(
        backgroundColor: ProjectColors.primary,
        title: Text(
          title,
          style: ProjectFonts.h6Light,
        ),
        pinned: true,
        floating: true,
        snap: true,
        leading: IconButton(
          onPressed: () => Scaffold.of(context).openDrawer(),
          icon: const Icon(Icons.menu),
        ),
        bottom: PreferredSize(
          preferredSize: tabBar.preferredSize,
          child: Material(
            color: ProjectColors.secondaryDark,
            child: tabBar,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
