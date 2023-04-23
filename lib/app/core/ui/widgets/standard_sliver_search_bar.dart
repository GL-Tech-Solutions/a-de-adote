import 'package:a_de_adote/app/core/ui/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import '../../../core/ui/styles/project_colors.dart';

class StandardSliverSearchBar extends StatelessWidget
    implements PreferredSizeWidget {
  final List<String> listaNomes;
  final void Function(String option) searchFunction;
  final void Function() backButtonFunction;
  final PreferredSize? bottom;

  const StandardSliverSearchBar({
    super.key,
    required this.listaNomes,
    required this.searchFunction,
    required this.backButtonFunction,
    required this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    //* Usando theme porque a cor do BackButton fica sempre preto se utilizado o Material 3.
    return Theme(
      data: ThemeData(
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(color: ProjectColors.secondaryDark),
        ),
        useMaterial3: false,
      ),
      child: SliverAppBar(
        backgroundColor: ProjectColors.light,
        title: SearchBar(
          listaNomes: listaNomes,
          searchFunction: searchFunction,
        ),
        pinned: true,
        floating: true,
        snap: true,
        leading: IconButton(
          onPressed: backButtonFunction,
          icon: const Icon(
            Icons.arrow_back,
            color: ProjectColors.secondaryDark,
          ),
          splashColor: Colors.transparent,
        ),
        automaticallyImplyLeading: false,
        bottom: bottom,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
