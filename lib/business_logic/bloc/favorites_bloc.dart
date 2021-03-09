import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:watchlist/data/models/movie.dart';
import 'package:watchlist/data/models/moviesPage.dart';
import 'package:watchlist/data/repositories/movies_repository.dart';

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
    try {
      final MoviesPage moviesPage = await moviesRepository.getFavMovies();
      final List<Movie> updatedMovies = List<Movie>.from(state.loadedMovies)
        ..addAll(moviesPage.itemList);

      yield FavoritesLoaded(
        loadedMovies: updatedMovies,
        nextPageKey: moviesPage.isLastPage ? null : state.nextPageKey ?? 0 + 1,
      );
    } catch (e) {
      yield FavoritesError(state.loadedMovies, e.toString());
    }
  }

  Stream<FavoritesState> _favoritesAdd(event) async* {
    yield FavoritesLoading(state.loadedMovies);
    try {
      await moviesRepository.saveFavMovie(event.movie);
      Movie insertedMovie = event.movie.copyWith(isFavorite: true);
      List<Movie> newMovies = List<Movie>.from(state.loadedMovies)
        ..insert(0, insertedMovie);
      yield FavoritesLoaded(
        loadedMovies: newMovies,
        nextPageKey: state.nextPageKey,
      );
    } catch (e) {
      print(e);
      yield FavoritesError(state.loadedMovies, e.toString());
    }
  }

  Stream<FavoritesState> _favoritesDelete(event, state) async* {
    yield FavoritesLoading(state.loadedMovies);
    try {
      await moviesRepository.removeFavMovie(event.movieId);
      List<Movie> newMovies = List.from(state.loadedMovies);
      newMovies.removeWhere((movie) => movie.id == event.movieId);
      yield FavoritesLoaded(
        loadedMovies: newMovies,
        nextPageKey: state.nextPageKey,
      );
    } catch (e) {
      print(e);
      yield FavoritesError(state.loadedMovies, e.toString());
    }
  }
}
