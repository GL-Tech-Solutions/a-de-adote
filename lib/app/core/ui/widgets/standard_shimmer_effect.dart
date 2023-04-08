import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../styles/project_colors.dart';

class StandardShimmerEffect extends StatelessWidget {
  final double? radiusValue;

  const StandardShimmerEffect({super.key, this.radiusValue});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      direction: ShimmerDirection.ltr,
      baseColor: ProjectColors.secondaryLight.withOpacity(0.8),
      highlightColor: ProjectColors.secondaryLight.withOpacity(0.5),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radiusValue ?? 12),
          color: ProjectColors.secondaryLight.withOpacity(0.8),
        ),
      ),
    );
  }
}
