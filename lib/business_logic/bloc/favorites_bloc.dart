import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:watchlist/data/models/movie.dart';
import 'package:watchlist/data/repositories/movies_repository.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final MoviesRepository moviesRepository;
  FavoritesBloc(this.moviesRepository) : super(FavoritesInitial(<Movie>[]));

  @override
  Stream<FavoritesState> mapEventToState(
    FavoritesEvent event,
  ) async* {
    if (event is FavoritesLoad) {
      yield* _favoritesLoad();
    }

    if (event is FavoritesAdd) {
      yield* _favoritesAdd(event);
    }

    if (event is FavoritesDelete) {
      yield* _favoritesDelete(event, state);
    }
  }

  Stream<FavoritesState> _favoritesLoad() async* {
    yield FavoritesLoading(state.loadedMovies);
    try {
      final List<Movie> _loadedMoviesList =
          await moviesRepository.getFavMovies();
      yield FavoritesLoaded(loadedMovies: _loadedMoviesList);
    } catch (e) {
      yield FavoritesError(state.loadedMovies);
    }
  }

  Stream<FavoritesState> _favoritesAdd(event) async* {
    yield FavoritesLoading(state.loadedMovies);
    try {
      await moviesRepository.saveFavMovie(event.movie);
      Movie insertedMovie = event.movie.copyWith(isFavorite: true);
      List<Movie> newMovies = List<Movie>.from(state.loadedMovies)
        ..insert(0, insertedMovie);
      yield FavoritesLoaded(loadedMovies: newMovies);
    } catch (e) {
      print(e);
      yield FavoritesError(state.loadedMovies);
    }
  }

  Stream<FavoritesState> _favoritesDelete(event, state) async* {
    yield FavoritesLoading(state.loadedMovies);
    try {
      await moviesRepository.removeFavMovie(event.movieId);
      List<Movie> newMovies = List.from(state.loadedMovies);
      newMovies.removeWhere((movie) => movie.id == event.movieId);
      yield FavoritesLoaded(loadedMovies: newMovies);
    } catch (e) {
      print(e);
      yield FavoritesError(state.loadedMovies);
    }
  }
}
