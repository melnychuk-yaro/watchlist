import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../business_logic/cubit/single_movie_cubit.dart';
import '../../../constatns.dart';
import '../../widgets/styled_text.dart';
import 'body/body.dart';
import 'genres.dart';
import 'head/head.dart';
import 'placeholders/text_skeleton.dart';
import 'placeholders/youtube_skeleton.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({
    required this.id,
    required this.title,
    required this.posterPath,
  });
  final int id;
  final String title;
  final String posterPath;

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
        builder: (_, state) {
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
                Head(title: widget.title, posterPath: widget.posterPath),
                state is SingleMovieLoaded
                    ? Genres(genres: state.movie.genres)
                    : const Padding(
                        padding: EdgeInsets.symmetric(horizontal: kPadding),
                        child: TextSkeleton(width: 120, height: 32),
                      ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(kPadding),
                    child: state is SingleMovieLoaded
                        ? Body(movie: state.movie)
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
                              const TextSkeleton(height: 14, width: 120),
                              const SizedBox(height: kPadding / 2),
                              const TextSkeleton(height: 120),
                              const SizedBox(height: kPadding),
                              const YouTubeSkeleton(),
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
