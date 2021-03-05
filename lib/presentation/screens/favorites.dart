import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist/business_logic/bloc/favorites_bloc.dart';
import 'package:watchlist/presentation/widgets/movie-card.dart';
import 'package:watchlist/presentation/widgets/styled-text.dart';

class Favorites extends StatelessWidget {
  final PageStorageKey key;
  Favorites({required this.key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesBloc, FavoritesState>(
      builder: (context, state) {
        if (state is FavoritesInitial) {
          BlocProvider.of<FavoritesBloc>(context).add(FavoritesLoad());
        }
        if (state is FavoritesError) {
          return Center(
            child: Text('Something went wrong'),
          );
        }
        if (state is FavoritesLoaded) {
          return state.loadedMovies.length > 0
              ? GridView(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 300.0,
                    childAspectRatio: 0.75,
                  ),
                  padding: const EdgeInsets.all(4.0),
                  children: state.loadedMovies
                      .map((movie) => MovieCard(movie: movie))
                      .toList(),
                )
              : StyledText(text: 'Add movies to your watchlist');
        }
        return Center(
          child: const CircularProgressIndicator(),
        );
      },
    );
  }
}
