import 'package:flutter/material.dart';

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
      child: Image.network(
        posterPath,
        errorBuilder: (context, exception, stackTrace) {
          return AspectRatio(
            aspectRatio: 2 / 3,
            child: Container(color: Colors.grey),
          );
        },
        loadingBuilder: (_, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return AspectRatio(
            aspectRatio: 2 / 3,
            child: Container(color: Theme.of(context).cardColor),
          );
        },
      ),
    );
  }
}
