import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';

import '../../../../constatns.dart';

class YouTubeSkeleton extends StatelessWidget {
  const YouTubeSkeleton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SkeletonAnimation(
      borderRadius: BorderRadius.circular(kBorderRadius),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Container(
          decoration: BoxDecoration(
            color: MediaQuery.of(context).platformBrightness == Brightness.dark
                ? kSkeletonDarkBg
                : kSkeletonLightBg,
            boxShadow: kShadow,
            borderRadius: BorderRadius.circular(kBorderRadius),
          ),
        ),
      ),
    );
  }
}
