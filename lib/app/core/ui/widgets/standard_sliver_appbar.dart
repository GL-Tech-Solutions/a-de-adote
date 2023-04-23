import 'package:flutter/material.dart';
import '../../../core/ui/styles/project_colors.dart';
import '../../../core/ui/styles/project_fonts.dart';

class StandardSliverAppbar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final PreferredSize? bottom;
  final bool? canPop;
  final void Function()? alternateAppbar;

  const StandardSliverAppbar({
    super.key,
    required this.title,
    required this.bottom,
    this.canPop,
    this.alternateAppbar,
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
        automaticallyImplyLeading: canPop ?? true,
        leading: canPop == true || canPop == null
            ? null
            : IconButton(
                onPressed: () => Scaffold.of(context).openDrawer(),
                icon: const Icon(Icons.menu),
              ),
        bottom: bottom,
        actions: alternateAppbar == null
            ? null
            : [
                IconButton(
                  onPressed: alternateAppbar,
                  icon: const Icon(Icons.search),
                  splashColor: Colors.transparent,
                ),
              ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
