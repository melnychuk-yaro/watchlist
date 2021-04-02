import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';

import '../../../constatns.dart';

class Backdrop extends StatelessWidget {
  const Backdrop({
    Key? key,
    required this.backdropPath,
    required this.backdropHeight,
  }) : super(key: key);

  final String backdropPath;
  final double backdropHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      height: backdropHeight,
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: kShadow,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(kBorderRadius * 2),
        ),
      ),
      child: Image.network(
        backdropPath,
        fit: BoxFit.cover,
        errorBuilder: (context, exception, stackTrace) {
          return Container(color: Theme.of(context).cardColor);
        },
        frameBuilder: (_, child, frame, wasSynchronouslyLoaded) {
          return wasSynchronouslyLoaded || frame != null
              ? child
              : SkeletonAnimation(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(kBorderRadius * 2),
                  ),
                  child: Container(
                    color: MediaQuery.of(context).platformBrightness ==
                            Brightness.dark
                        ? kSkeletonDarkBg
                        : kSkeletonLightBg,
                  ),
                );
        },
      ),
    );
  }
}
