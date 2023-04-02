import 'package:flutter/material.dart';
import '../../../core/ui/styles/project_colors.dart';
import '../../../core/ui/styles/project_fonts.dart';

class InfoContainer extends StatelessWidget {
  final String title;
  final String info;
  final IconData icon;

  const InfoContainer({
    super.key,
    required this.title,
    required this.info,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      decoration: BoxDecoration(
        color: ProjectColors.secondaryLight,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    title,
                    style: ProjectFonts.pLightBold,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Icon(
                    icon,
                    size: 14,
                    color: ProjectColors.primaryLight,
                  ),
                ],
              ),
              Text(
                info,
                style: ProjectFonts.pLight,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
