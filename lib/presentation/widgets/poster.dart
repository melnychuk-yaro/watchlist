import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';

import '../../constatns.dart';

class Poster extends StatelessWidget {
  const Poster({Key? key, required this.posterUrl}) : super(key: key);

  final String posterUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(kBorderRadius),
      child: CachedNetworkImage(
        imageUrl: posterUrl,
        fit: BoxFit.cover,
        errorWidget: (context, url, error) {
          return Container(color: Theme.of(context).cardColor);
        },
        placeholder: (context, url) {
          return SkeletonAnimation(
            child: Container(color: Theme.of(context).cardColor),
          );
        },
      ),
    );
  }
}
