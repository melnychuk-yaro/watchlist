import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist/business_logic/bloc/favorites_bloc.dart';
import 'package:watchlist/presentation/widgets/movie-card.dart';

class Favorites extends StatefulWidget {
  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  @override
  void initState() {
    BlocProvider.of<FavoritesBloc>(context).add(FavoritesLoad());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesBloc, FavoritesState>(
      builder: (context, state) {
        if (state is FavoritesError) {
          return Center(
            child: Text('Something went wrong'),
          );
        }
        if (state is FavoritesLoaded) {
          return GridView(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 300.0,
              childAspectRatio: 0.75,
            ),
            padding: const EdgeInsets.all(4.0),
            children: state.loadedMovies
                .map((movie) => MovieCard(movie: movie))
                .toList(),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
