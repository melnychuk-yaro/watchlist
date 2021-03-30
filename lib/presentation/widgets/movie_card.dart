import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

    return Stack(
      children: [
        GestureDetector(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
                builder: (_) => MultiBlocProvider(
                      providers: [
                        BlocProvider.value(
                            value: context.read<SingleMovieCubit>()),
                        BlocProvider.value(
                            value: context.read<AllFavoritesCubit>()),
                        BlocProvider.value(
                            value: context.read<FavoritesBloc>()),
                      ],
                      child: MovieScreen(id: movie.id),
                    )),
          ),
          child: Card(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kBorderRadius),
            ),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: movie.posterFileName == ''
                      ? AssetImage('assets/images/dark-gray-bg.jpg')
                      : CachedNetworkImageProvider(movie.fullPosterPath)
                          as ImageProvider,
                  fit: BoxFit.cover,
                ),
              ),
              child: GridTile(
                child: Center(),
                footer: Container(
                  color:
                      _brightness == Brightness.light ? kLightText : kDarkText,
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
          ),
        ),
        Padding(
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
      ],
    );
  }
}
