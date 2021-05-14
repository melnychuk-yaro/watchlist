import 'package:flutter/material.dart';

import '../../../../constatns.dart';
import '../../../../data/models/movie_detailed.dart';
import '../../../widgets/add_to_fav_button.dart';

class ToolBar extends StatelessWidget {
  const ToolBar({Key? key, required this.movie}) : super(key: key);

  final MovieDetailed movie;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: kShadow,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(kBorderRadius),
          topLeft: Radius.circular(kBorderRadius),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(kPadding / 2),
        child: Row(
          children: [
            AddToFavButton(
              key: ValueKey(movie.id),
              movie: movie,
              color: Theme.of(context).accentColor.withOpacity(0.1),
            )
          ],
        ),
      ),
    );
  }
}
