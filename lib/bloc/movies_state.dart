part of 'movies_bloc.dart';

@immutable
abstract class MoviesState {}

class MoviesInitialState extends MoviesState {}

class MoviesLoadingState extends MoviesState {}

class MoviesLoadedState extends MoviesState {
  final List<dynamic> loadedMovies;
  MoviesLoadedState({@required this.loadedMovies})
      : assert(loadedMovies != null);
}

class MoviesErrorState extends MoviesState {}
