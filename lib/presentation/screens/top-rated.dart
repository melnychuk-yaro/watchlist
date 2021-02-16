import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist/business_logic/cubit/top_movies_cubit.dart';
import 'package:watchlist/presentation/widgets/paged-grid-view.dart';

class TopRated extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TopMoviesCubit topMoviesCubit =
        BlocProvider.of<TopMoviesCubit>(context);

    return PagedMoviesGridView(
      movCubit: topMoviesCubit,
      loadMovies: topMoviesCubit.loadMovies,
      resetMovies: topMoviesCubit.resetMovies,
    );
  }
}
