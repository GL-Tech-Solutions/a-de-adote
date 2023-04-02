import 'package:a_de_adote/app/core/ui/styles/project_colors.dart';
import 'package:a_de_adote/app/core/ui/styles/project_fonts.dart';
import 'package:flutter/material.dart';

class InfoChip extends StatelessWidget {
  final String info;
  final bool infoState;

  const InfoChip({
    super.key,
    required this.info,
    required this.infoState,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: ProjectColors.lightDark),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            info,
            style: ProjectFonts.smallLight
                .copyWith(color: ProjectColors.lightDark),
          ),
          const SizedBox(
            width: 8,
          ),
          infoState
              ? const Icon(
                  Icons.check,
                  size: 12,
                  color: Color(0xFFBDFF9E),
                )
              : const Icon(
                  Icons.close,
                  size: 12,
                  color: Color(0xFFFFA666),
                ),
        ],
      ),
    );
  }
}
