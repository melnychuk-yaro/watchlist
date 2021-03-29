import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../../business_logic/cubit/single_movie_cubit.dart';
import '../../constatns.dart';
import '../../data/models/movie_detailed.dart';
import '../widgets/add_to_fav_button.dart';
import '../widgets/styled_text.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({required this.id});
  final int id;

  @override
  _MovieScreenState createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  @override
  void initState() {
    super.initState();

    context.read<SingleMovieCubit>().loadMovie(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SingleMovieCubit, SingleMovieState>(
        builder: (context, state) {
          if (state is SingleMovieLoaded) {
            return _SingleMovie(movie: state.movie);
          }
          if (state is SingleMovieError) {
            return StyledText(
              text: state.error,
              icon: Icons.error,
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class _SingleMovie extends StatelessWidget {
  _SingleMovie({Key? key, required this.movie}) : super(key: key);
  final MovieDetailed movie;
  static const double posterWidth = 120;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              _Backdrop(backdropPath: movie.fullBackgroundPath),
              Positioned(
                top: 143,
                left: 16,
                child: _Poster(
                    posterPath: movie.fullPosterPath, posterWidth: posterWidth),
              ),
              Positioned(
                top: 215,
                right: 0,
                child: _ToolBar(movie: movie),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 16.0),
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(kBorderRadius / 2),
                      boxShadow: kShadow,
                    ),
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: MediaQuery.of(context).platformBrightness ==
                              Brightness.dark
                          ? BackButton(color: kLightText)
                          : BackButton(color: kDarkText),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Container(width: posterWidth),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _InfoItem(
                            defenition: 'Rating:',
                            value: movie.rating.toString(),
                          ),
                          const SizedBox(height: 4),
                          _InfoItem(
                            defenition: 'Release Date:',
                            value: movie.releaseDate,
                          ),
                          const SizedBox(height: 4),
                          movie.budget == 0
                              ? _InfoItem(defenition: 'Budget:', value: '-')
                              : _InfoItem(
                                  defenition: 'Budget:',
                                  value: '${movie.budget.toString()}',
                                ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Genres(genres: movie.genres),
                const SizedBox(height: 16),
                Text(
                  movie.title,
                  style: Theme.of(context).textTheme.headline5,
                ),
                const SizedBox(height: 8),
                Text(
                  movie.tagline,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                const SizedBox(height: 8),
                Text(
                  movie.overview,
                  style: TextStyle(fontSize: 16),
                ),
                if (movie.youtubeVideoId != '') const SizedBox(height: 16),
                if (movie.youtubeVideoId != '')
                  YouTubePlayer(youtubeVideoId: movie.youtubeVideoId)
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _ToolBar extends StatelessWidget {
  const _ToolBar({Key? key, required this.movie}) : super(key: key);

  final MovieDetailed movie;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: kShadow,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(kBorderRadius),
          topLeft: Radius.circular(kBorderRadius),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
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

class _Poster extends StatelessWidget {
  const _Poster({
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
      child: Image.network(posterPath),
    );
  }
}

class _Backdrop extends StatelessWidget {
  const _Backdrop({
    Key? key,
    required this.backdropPath,
  }) : super(key: key);

  final String backdropPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: kShadow,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(kBorderRadius * 2),
        ),
      ),
      child: Image.network(backdropPath, fit: BoxFit.cover),
    );
  }
}

class _InfoItem extends StatelessWidget {
  final String defenition;
  final String value;
  const _InfoItem({required this.defenition, required this.value});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: [
          TextSpan(
            text: '$defenition ',
            style: TextStyle(
              fontWeight: FontWeight.w800,
            ),
          ),
          TextSpan(text: value),
        ],
      ),
    );
  }
}

class Genres extends StatelessWidget {
  final List<dynamic> genres;

  const Genres({Key? key, required this.genres}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: genres.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Chip(
              label: Text(genres[index]['name']),
            ),
          );
        },
      ),
    );
  }
}

class YouTubePlayer extends StatefulWidget {
  YouTubePlayer({Key? key, required this.youtubeVideoId}) : super(key: key);
  final String youtubeVideoId;

  @override
  _YouTubePlayerState createState() => _YouTubePlayerState();
}

class _YouTubePlayerState extends State<YouTubePlayer> {
  late final YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: widget.youtubeVideoId,
    params: YoutubePlayerParams(
      autoPlay: false,
    ),
  );

  @override
  void dispose() {
    super.dispose();
    _controller.close();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kBorderRadius),
        boxShadow: kShadow,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(kBorderRadius),
        child: YoutubePlayerIFrame(
          controller: _controller,
          aspectRatio: 16 / 9,
        ),
      ),
    );
  }
}
