part of 'top_movies_cubit.dart';

@immutable
abstract class TopMoviesState extends Equatable {
  const TopMoviesState({
    required this.movies,
    this.error,
    this.nextPageKey,
  });

  final List<Movie> movies;
  final String? error;
  final int? nextPageKey;

  @override
  List<Object> get props => [this.movies];
}

class TopMoviesInitial extends TopMoviesState {
  TopMoviesInitial() : super(movies: <Movie>[], nextPageKey: 1, error: null);
}

class TopMoviesLoaded extends TopMoviesState {
  const TopMoviesLoaded({
    required this.movies,
    required this.nextPageKey,
  }) : super(movies: movies, nextPageKey: nextPageKey);

  final List<Movie> movies;
  final int? nextPageKey;
}

class TopMoviesError extends TopMoviesState {
  const TopMoviesError({
    required this.movies,
    required this.error,
    required this.nextPageKey,
  }) : super(movies: movies, nextPageKey: nextPageKey, error: error);

  final List<Movie> movies;
  final String error;
  final int? nextPageKey;
}
