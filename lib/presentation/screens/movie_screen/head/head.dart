import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../business_logic/cubit/single_movie_cubit.dart';
import '../../../../constatns.dart';
import '../placeholders/backdrop_skeleton.dart';
import '../placeholders/text_skeleton.dart';
import '../placeholders/toolbar_skeleton.dart';
import 'backdrop.dart';
import 'custom_back_button.dart';
import 'info.dart';
import 'poster.dart';
import 'toolbar.dart';

class Head extends StatelessWidget {
  const Head({
    Key? key,
    required this.title,
    required this.posterPath,
  }) : super(key: key);

  final String title;
  final String posterPath;
  static const double posterWidth = 120.0;
  static const double backdropHeight = 250.0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SingleMovieCubit, SingleMovieState>(
      builder: (_, state) {
        return Column(
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
                    : const BackDropSkeleton(
                        backdropHeight: backdropHeight,
                      ),
                Positioned(
                  top: 163,
                  left: 16,
                  child: SingleMoviePoster(
                    posterPath: posterPath,
                    posterWidth: posterWidth,
                  ),
                ),
                Positioned(
                  top: 215,
                  right: 0,
                  child: state is SingleMovieLoaded
                      ? ToolBar(movie: state.movie)
                      : const ToolBarSkeleton(),
                ),
                const CustomBackButton(),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(kPadding),
              child: Row(
                children: [
                  const SizedBox(width: posterWidth),
                  const SizedBox(width: kPadding),
                  Expanded(
                    child: state is SingleMovieLoaded
                        ? Info(movie: state.movie)
                        : Wrap(
                            direction: Axis.vertical,
                            spacing: 4.0,
                            children: [
                              const TextSkeleton(width: 120),
                              const TextSkeleton(width: 120),
                              const TextSkeleton(width: 120),
                            ],
                          ),
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
