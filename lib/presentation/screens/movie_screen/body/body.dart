import 'package:flutter/material.dart';

import '../../../../constatns.dart';
import '../../../../data/models/movie_detailed.dart';
import 'youtube_player.dart';

class Body extends StatelessWidget {
  const Body({Key? key, required this.movie}) : super(key: key);

  final MovieDetailed movie;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Text(
            movie.title,
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        if (movie.tagline != '') const SizedBox(height: kPadding / 2),
        if (movie.tagline != '')
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(top: kPadding / 2),
              child: Text(
                movie.tagline,
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
          ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(top: kPadding),
            child: Text(
              movie.overview,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
        if (movie.youtubeVideoId != '') const SizedBox(height: kPadding),
        if (movie.youtubeVideoId != '')
          YouTubePlayer(youtubeVideoId: movie.youtubeVideoId)
      ],
    );
  }
}
