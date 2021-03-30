import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../business_logic/bloc/favorites_bloc.dart';
import '../../business_logic/cubit/all_favorites_cubit.dart';
import '../../data/models/movie.dart';

class AddToFavButton extends StatelessWidget {
  const AddToFavButton({
    required this.key,
    required this.movie,
    this.color,
  }) : super(key: key);

  final Key key;
  final Movie movie;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllFavoritesCubit, AllFavoritesState>(
      builder: (context, state) {
        final isFavorite = state.allFavoriteMovieIds.contains(movie.id);
        return Ink(
          decoration: ShapeDecoration(
            color: color,
            shape: CircleBorder(),
          ),
          child: IconButton(
            onPressed: () {
              if (isFavorite) {
                context.read<FavoritesBloc>().add(FavoritesDelete(movie.id));
                context.read<AllFavoritesCubit>().removeFavMovie(movie.id);
              } else {
                context.read<FavoritesBloc>().add(FavoritesAdd(movie));
                context.read<AllFavoritesCubit>().addFavMovie(movie.id);
              }
            },
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: Colors.red,
            ),
          ),
        );
      },
    );
  }
}
