import 'package:flutter/material.dart';

import '../styles/project_colors.dart';
import '../styles/project_fonts.dart';

class ContainerResearch extends StatelessWidget {
  const ContainerResearch({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: MediaQuery.of(context).size.height * 0.05,
        width: MediaQuery.of(context).size.width,
        color: ProjectColors.dark,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Responda nossa pesquisa!',
              style: ProjectFonts.pLight.copyWith(
                color: ProjectColors.lightDark,
              ),
            ),
            const Icon(
              Icons.open_in_new,
              size: 20,
              color: ProjectColors.lightDark,
            ),
          ],
        ),
      ),
    );
  }
}
