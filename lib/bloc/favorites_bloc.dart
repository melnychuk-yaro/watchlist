import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:watchlist/models/movie.dart';
import 'package:watchlist/services/movies_repository.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final MoviesRepository moviesRepository;
  FavoritesBloc(this.moviesRepository) : super(FavoritesInitial());

  @override
  Stream<FavoritesState> mapEventToState(
    FavoritesEvent event,
  ) async* {
    if (event is FavoritesLoad) {
      yield FavoritesLoading();
      try {
        final List<Movie> _loadedMoviesList =
            await moviesRepository.getFavMovies();
        yield FavoritesLoaded(loadedMovies: _loadedMoviesList);
      } catch (e) {
        yield FavoritesError();
      }
    }

    if (event is FavoritesAdd) {
      yield FavoritesAdding();
      try {
        final List<Movie> _loadedMoviesList =
            await moviesRepository.getFavMovies();
        yield FavoritesAdded(
          loadedMovies: _loadedMoviesList,
          newFavMovie: event.movie,
        );
      } catch (e) {
        yield FavoritesError();
      }
    }
  }
}
