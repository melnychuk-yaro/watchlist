import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';

import '../../../constatns.dart';

class Poster extends StatelessWidget {
  const Poster({
    Key? key,
    required this.posterPath,
    required this.posterWidth,
  }) : super(key: key);

  final String posterPath;
  final double posterWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: posterWidth,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kBorderRadius),
        boxShadow: kShadow,
      ),
      child: AspectRatio(
        aspectRatio: 2 / 3,
        child: Hero(
          tag: posterPath,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(kBorderRadius),
            child: Image.network(
              posterPath,
              fit: BoxFit.cover,
              errorBuilder: (context, exception, stackTrace) {
                return Container(color: Theme.of(context).cardColor);
              },
              frameBuilder: (_, child, frame, wasSynchronouslyLoaded) {
                return wasSynchronouslyLoaded || frame != null
                    ? child
                    : SkeletonAnimation(
                        child: Container(color: Theme.of(context).cardColor),
                      );
              },
            ),
          ),
        ),
      ),
    );
  }
}
