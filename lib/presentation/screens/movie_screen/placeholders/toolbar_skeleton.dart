import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';

import '../../../../constatns.dart';

class ToolBarSkeleton extends StatelessWidget {
  const ToolBarSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SkeletonAnimation(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(kBorderRadius),
        topLeft: Radius.circular(kBorderRadius),
      ),
      child: Container(
        height: 64.0,
        width: 64.0,
        decoration: BoxDecoration(
          color: MediaQuery.of(context).platformBrightness == Brightness.dark
              ? kSkeletonDarkBg
              : kSkeletonLightBg,
          boxShadow: kShadow,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(kBorderRadius),
            topLeft: Radius.circular(kBorderRadius),
          ),
        ),
      ),
    );
  }
}
