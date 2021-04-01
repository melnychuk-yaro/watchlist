import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeleton_text/skeleton_text.dart';

import '../../business_logic/bloc/favorites_bloc.dart';
import '../../business_logic/cubit/all_favorites_cubit.dart';
import '../../business_logic/cubit/single_movie_cubit.dart';
import '../../constatns.dart';
import '../../data/models/movie.dart';
import '../screens/movie_screen/movie_screen.dart';
import 'add_to_fav_button.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final Key key;
  MovieCard({required this.movie, required this.key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _brightness = MediaQuery.of(context).platformBrightness;

    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: context.read<SingleMovieCubit>()),
              BlocProvider.value(value: context.read<AllFavoritesCubit>()),
              BlocProvider.value(value: context.read<FavoritesBloc>()),
            ],
            child: MovieScreen(
              id: movie.id,
              title: movie.title,
              posterPath: movie.fullPosterPath,
            ),
          ),
        ),
      ),
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kBorderRadius),
        ),
        child: GridTile(
          header: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kPadding / 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  visualDensity: VisualDensity.compact,
                  label: Text('${movie.rating}'),
                ),
                AddToFavButton(
                  key: ValueKey(movie.id),
                  movie: movie,
                ),
              ],
            ),
          ),
          child: Hero(
            tag: movie.fullPosterPath,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(kBorderRadius),
              child: Image.network(
                movie.fullPosterPath,
                fit: BoxFit.cover,
                errorBuilder: (context, exception, stackTrace) {
                  return Container(color: Theme.of(context).cardColor);
                },
                frameBuilder: (_, child, frame, wasSynchronouslyLoaded) {
                  return wasSynchronouslyLoaded || frame != null
                      ? child
                      : SkeletonAnimation(
                          child: Container(color: Theme.of(context).cardColor),
                        );
                },
              ),
            ),
          ),
          footer: Container(
            color: _brightness == Brightness.light ? kLightText : kDarkText,
            padding: const EdgeInsets.symmetric(
                horizontal: kPadding / 2, vertical: kPadding / 2),
            child: Text(
              movie.title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.0),
            ),
          ),
        ),
      ),
    );
  }
}
