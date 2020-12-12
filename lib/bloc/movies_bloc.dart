import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:watchlist/models/movie.dart';
import 'package:watchlist/services/movies_repository.dart';

part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final MoviesRepository moviesRepository;
  MoviesBloc(this.moviesRepository) : super(MoviesInitialState());

  @override
  Stream<MoviesState> mapEventToState(
    MoviesEvent event,
  ) async* {
    if (event is TopMoviesLoadEvent) {
      yield MoviesLoadingState();
      try {
        final List<Movie> _loadedMoviesList =
            await moviesRepository.getTopMovies();
        yield MoviesLoadedState(loadedMovies: _loadedMoviesList);
      } catch (e) {
        yield MoviesErrorState();
      }
    }
    if (event is NewMoviesLoadEvent) {
      yield MoviesLoadingState();
      try {
        final List<Movie> _loadedMoviesList =
            await moviesRepository.getNewMovies();
        yield MoviesLoadedState(loadedMovies: _loadedMoviesList);
      } catch (e) {
        yield MoviesErrorState();
      }
    }
  }
}
