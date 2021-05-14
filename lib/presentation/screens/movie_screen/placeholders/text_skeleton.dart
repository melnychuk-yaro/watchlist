import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';

import '../../../../constatns.dart';

class TextSkeleton extends StatelessWidget {
  const TextSkeleton({
    Key? key,
    this.height = 16.0,
    this.width = double.infinity,
  }) : super(key: key);

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SkeletonAnimation(
      borderRadius: BorderRadius.circular(kBorderRadius),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: MediaQuery.of(context).platformBrightness == Brightness.dark
              ? kSkeletonDarkBg
              : kSkeletonLightBg,
          borderRadius: BorderRadius.circular(kBorderRadius),
        ),
      ),
    );
  }
}
