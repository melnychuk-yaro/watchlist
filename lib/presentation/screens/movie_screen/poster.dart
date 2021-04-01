import 'package:flutter/material.dart';

import '../../../constatns.dart';
import '../../widgets/poster.dart';

class SingleMoviePoster extends StatelessWidget {
  const SingleMoviePoster({
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
            child: Poster(posterUrl: posterPath),
          ),
        ),
      ),
    );
  }
}
