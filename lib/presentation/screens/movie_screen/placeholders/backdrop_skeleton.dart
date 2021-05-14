import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';

import '../../../../constatns.dart';

class BackDropSkeleton extends StatelessWidget {
  const BackDropSkeleton({
    Key? key,
    required this.backdropHeight,
  }) : super(key: key);

  final double backdropHeight;

  @override
  Widget build(BuildContext context) {
    return SkeletonAnimation(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(kBorderRadius * 2),
      ),
      child: Container(
        height: backdropHeight,
        decoration: BoxDecoration(
          color: MediaQuery.of(context).platformBrightness == Brightness.dark
              ? kSkeletonDarkBg
              : kSkeletonLightBg,
          boxShadow: kShadow,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(kBorderRadius * 2),
          ),
        ),
      ),
    );
  }
}
