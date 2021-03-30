import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../business_logic/cubit/single_movie_cubit.dart';
import '../../../constatns.dart';
import '../../../data/models/movie_detailed.dart';
import '../../widgets/styled_text.dart';
import 'backdrop.dart';
import 'genres.dart';
import 'info_item.dart';
import 'poster.dart';
import 'toolbar.dart';
import 'youtube_player.dart';

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
  final budgetFormat = NumberFormat.currency(
    locale: 'en_US',
    symbol: '\$',
    decimalDigits: 0,
  );

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Backdrop(backdropPath: movie.fullBackgroundPath),
              Positioned(
                top: 143,
                left: 16,
                child: Poster(
                  posterPath: movie.fullPosterPath,
                  posterWidth: posterWidth,
                ),
              ),
              Positioned(
                top: 215,
                right: 0,
                child: ToolBar(movie: movie),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(left: kPadding, top: kPadding),
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(kBorderRadius / 2),
                      boxShadow: kShadow,
                    ),
                    child: MediaQuery.of(context).platformBrightness ==
                            Brightness.dark
                        ? BackButton(color: kLightText)
                        : BackButton(color: kDarkText),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(kPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Container(width: posterWidth),
                    Padding(
                      padding: const EdgeInsets.only(left: kPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InfoItem(
                            defenition: 'Rating:',
                            value: movie.rating.toString(),
                          ),
                          const SizedBox(height: 4),
                          InfoItem(
                            defenition: 'Release Date:',
                            value: movie.releaseDate,
                          ),
                          const SizedBox(height: 4),
                          movie.budget == 0
                              ? InfoItem(defenition: 'Budget:', value: '-')
                              : InfoItem(
                                  defenition: 'Budget:',
                                  value: '${budgetFormat.format(movie.budget)}',
                                ),
                        ],
                      ),
                    )
                  ],
                ),
                if (movie.genres.isNotEmpty) const SizedBox(height: 20),
                if (movie.genres.isNotEmpty) Genres(genres: movie.genres),
                const SizedBox(height: kPadding),
                Text(
                  movie.title,
                  style: Theme.of(context).textTheme.headline5,
                ),
                if (movie.tagline != '') const SizedBox(height: kPadding / 2),
                if (movie.tagline != '')
                  Text(
                    movie.tagline,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                const SizedBox(height: kPadding / 2),
                Text(
                  movie.overview,
                  style: TextStyle(fontSize: kPadding),
                ),
                if (movie.youtubeVideoId != '')
                  const SizedBox(height: kPadding),
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
