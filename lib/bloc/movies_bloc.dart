import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:watchlist/models/movie.dart';
import 'package:watchlist/services/movies_repository.dart';

part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final MoviesRepository moviesRepository;
  MoviesBloc(this.moviesRepository) : super(MoviesInitial());

  @override
  Stream<MoviesState> mapEventToState(
    MoviesEvent event,
  ) async* {
    if (event is TopMoviesLoadEvent) {
      yield MoviesLoading();
      try {
        final List<Movie> _loadedMoviesList =
            await moviesRepository.getTopMovies();
        yield MoviesLoaded(loadedMovies: _loadedMoviesList);
      } catch (e) {
        yield MoviesError();
      }
    }
    if (event is NewMoviesLoadEvent) {
      yield MoviesLoading();
      try {
        final List<Movie> _loadedMoviesList =
            await moviesRepository.getNewMovies();
        yield MoviesLoaded(loadedMovies: _loadedMoviesList);
      } catch (e) {
        yield MoviesError();
      }
    }
    if (event is SearchMoviesLoadEvent) {
      yield MoviesLoading();
      try {
        final List<Movie> _loadedSearchList =
            await moviesRepository.searchMovies(event.query);
        yield SearchLoaded(loadedMovies: _loadedSearchList);
      } catch (e) {
        yield MoviesError();
      }
    }
  }
}
