import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:skeleton_text/skeleton_text.dart';

import '../../../business_logic/cubit/single_movie_cubit.dart';
import '../../../constatns.dart';
import '../../widgets/styled_text.dart';
import 'backdrop.dart';
import 'custom_back_button.dart';
import 'genres.dart';
import 'info_item.dart';
import 'poster.dart';
import 'toolbar.dart';
import 'youtube_player.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({required this.id, required this.title});
  final int id;
  final String title;

  @override
  _MovieScreenState createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  static const double posterWidth = 120.0;
  static const double backdropHeight = 250.0;
  final budgetFormat = NumberFormat.currency(
    locale: 'en_US',
    symbol: '\$',
    decimalDigits: 0,
  );

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
          if (state is SingleMovieError) {
            return StyledText(
              text: state.error,
              icon: Icons.error,
            );
          }
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    state is SingleMovieLoaded
                        ? Backdrop(
                            backdropPath: state.movie.fullBackgroundPath,
                            backdropHeight: backdropHeight,
                          )
                        : SkeletonAnimation(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(kBorderRadius * 2),
                            ),
                            child: Container(
                              height: backdropHeight,
                              decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                boxShadow: kShadow,
                                borderRadius: BorderRadius.only(
                                  bottomLeft:
                                      Radius.circular(kBorderRadius * 2),
                                ),
                              ),
                            ),
                          ),
                    Positioned(
                      top: 143,
                      left: 16,
                      child: state is SingleMovieLoaded
                          ? Poster(
                              posterPath: state.movie.fullPosterPath,
                              posterWidth: posterWidth,
                            )
                          : _PosterSkeleton(posterWidth: posterWidth),
                    ),
                    Positioned(
                      top: 215,
                      right: 0,
                      child: state is SingleMovieLoaded
                          ? ToolBar(movie: state.movie)
                          : _ToolBarSkeleton(),
                    ),
                    CustomBackButton(),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(kPadding),
                  child: Row(
                    children: [
                      Container(width: posterWidth),
                      const SizedBox(width: kPadding),
                      Expanded(
                        child: state is SingleMovieLoaded
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  InfoItem(
                                    defenition: 'Rating:',
                                    value: state.movie.rating.toString(),
                                  ),
                                  const SizedBox(height: 4.0),
                                  Flexible(
                                    child: InfoItem(
                                      defenition: 'Release Date:',
                                      value: state.movie.releaseDate,
                                    ),
                                  ),
                                  const SizedBox(height: 4.0),
                                  state.movie.budget == 0
                                      ? InfoItem(
                                          defenition: 'Budget:', value: '-')
                                      : InfoItem(
                                          defenition: 'Budget:',
                                          value:
                                              '${budgetFormat.format(state.movie.budget)}',
                                        ),
                                ],
                              )
                            : Wrap(
                                direction: Axis.vertical,
                                spacing: 4.0,
                                children: [
                                  const _TextSceleton(width: 120),
                                  const _TextSceleton(width: 120),
                                  const _TextSceleton(width: 120),
                                ],
                              ),
                      )
                    ],
                  ),
                ),
                state is SingleMovieLoaded
                    ? Genres(genres: state.movie.genres)
                    : const Padding(
                        padding: EdgeInsets.symmetric(horizontal: kPadding),
                        child: _TextSceleton(width: 120, height: 32),
                      ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(kPadding),
                    child: state is SingleMovieLoaded
                        ? Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Text(
                                  widget.title,
                                  style: Theme.of(context).textTheme.headline5,
                                ),
                              ),
                              if (state.movie.tagline != '')
                                const SizedBox(height: kPadding / 2),
                              if (state.movie.tagline != '')
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: kPadding / 2),
                                    child: Text(
                                      state.movie.tagline,
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                    ),
                                  ),
                                ),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: kPadding),
                                  child: Text(
                                    state.movie.overview,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ),
                              if (state.movie.youtubeVideoId != '')
                                const SizedBox(height: kPadding),
                              if (state.movie.youtubeVideoId != '')
                                YouTubePlayer(
                                    youtubeVideoId: state.movie.youtubeVideoId)
                            ],
                          )
                        : Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Text(
                                  widget.title,
                                  style: Theme.of(context).textTheme.headline5,
                                ),
                              ),
                              const SizedBox(height: kPadding / 2),
                              const _TextSceleton(height: 14, width: 120),
                              const SizedBox(height: kPadding / 2),
                              const _TextSceleton(height: 120),
                              const SizedBox(height: kPadding),
                              const _YouTubeSkeleton(),
                            ],
                          ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class _YouTubeSkeleton extends StatelessWidget {
  const _YouTubeSkeleton({
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
            color: Theme.of(context).cardColor,
            boxShadow: kShadow,
            borderRadius: BorderRadius.circular(kBorderRadius),
          ),
        ),
      ),
    );
  }
}

class _TextSceleton extends StatelessWidget {
  const _TextSceleton({
    Key? key,
    this.height = 16.0,
    this.width = double.infinity,
  }) : super(key: key);

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SkeletonAnimation(
      borderRadius: BorderRadius.circular(kBorderRadius),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(kBorderRadius),
        ),
      ),
    );
  }
}

class _PosterSkeleton extends StatelessWidget {
  const _PosterSkeleton({
    Key? key,
    required this.posterWidth,
  }) : super(key: key);

  final double posterWidth;

  @override
  Widget build(BuildContext context) {
    return SkeletonAnimation(
      borderRadius: BorderRadius.circular(kBorderRadius),
      child: Container(
        width: posterWidth,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(kBorderRadius),
          boxShadow: kShadow,
        ),
        child: AspectRatio(
          aspectRatio: 2 / 3,
        ),
      ),
    );
  }
}

class _ToolBarSkeleton extends StatelessWidget {
  const _ToolBarSkeleton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SkeletonAnimation(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(kBorderRadius),
        topLeft: Radius.circular(kBorderRadius),
      ),
      child: Container(
        height: 64.0,
        width: 64.0,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          boxShadow: kShadow,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(kBorderRadius),
            topLeft: Radius.circular(kBorderRadius),
          ),
        ),
      ),
    );
  }
}
