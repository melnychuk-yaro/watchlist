part of 'movies_bloc.dart';

@immutable
abstract class MoviesState {}

class MoviesInitial extends MoviesState {}

class MoviesLoading extends MoviesState {}

class MoviesLoaded extends MoviesState {
  final List<dynamic> loadedMovies;
  MoviesLoaded({@required this.loadedMovies}) : assert(loadedMovies != null);
}

class SearchLoaded extends MoviesState {
  final List<dynamic> loadedMovies;
  SearchLoaded({@required this.loadedMovies}) : assert(loadedMovies != null);
}

class MoviesError extends MoviesState {}
