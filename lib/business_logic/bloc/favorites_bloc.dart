import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:watchlist/data/models/movie.dart';
import 'package:watchlist/data/repositories/movies_repository.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final MoviesRepository moviesRepository;
  FavoritesBloc(this.moviesRepository) : super(FavoritesInitial(List<Movie>()));

  @override
  void onTransition(Transition<FavoritesEvent, FavoritesState> transition) {
    print(transition);
    print('movies: ${state.loadedMovies}');
    super.onTransition(transition);
  }

  @override
  Stream<FavoritesState> mapEventToState(
    FavoritesEvent event,
  ) async* {
    if (event is FavoritesLoad) {
      yield FavoritesLoading(state.loadedMovies);
      try {
        final List<Movie> _loadedMoviesList =
            await moviesRepository.getFavMovies();
        yield FavoritesLoaded(loadedMovies: _loadedMoviesList);
      } catch (e) {
        yield FavoritesError(state.loadedMovies);
      }
    }

    if (event is FavoritesAdd) {
      yield FavoritesAdding(state.loadedMovies);
      try {
        await moviesRepository.saveFavMovie(event.movie);
        List<Movie> newMovies = state.loadedMovies + [event.movie];
        yield FavoritesAdded(
          loadedMovies: newMovies,
          newFavMovie: event.movie,
        );
      } catch (e) {
        print(e);
        yield FavoritesError(state.loadedMovies);
      }
    }

    if (event is FavoritesDelete) {
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
}
