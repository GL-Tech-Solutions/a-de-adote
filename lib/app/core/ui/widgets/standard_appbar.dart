import 'package:flutter/material.dart';

import '../styles/project_colors.dart';
import '../styles/project_fonts.dart';

class StandardAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool? canPop;

  const StandardAppBar({
    super.key,
    required this.title,
    this.canPop,
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
      child: AppBar(
        backgroundColor: ProjectColors.primary,
        title: Text(
          title,
          style: ProjectFonts.h6Light,
        ),
        automaticallyImplyLeading: canPop ?? true,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
