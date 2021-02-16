part of 'top_movies_cubit.dart';

@immutable
abstract class TopMoviesState {
  TopMoviesState({
    @required this.moviesPage,
    @required this.error,
    @required this.nextPageKey,
  });

  final MoviesPage moviesPage;
  final dynamic error;
  final int nextPageKey;
}

class TopMoviesInitial extends TopMoviesState {
  TopMoviesInitial({
    @required this.moviesPage,
    @required this.error,
    @required this.nextPageKey,
  });

  final MoviesPage moviesPage;
  final dynamic error;
  final int nextPageKey;
}

class TopMoviesLoading extends TopMoviesState {}

class TopMoviesLoaded extends TopMoviesState {
  TopMoviesLoaded({
    @required this.moviesPage,
    @required this.error,
    @required this.nextPageKey,
  });

  final MoviesPage moviesPage;
  final dynamic error;
  final int nextPageKey;
}

class TopMoviesError extends TopMoviesState {
  TopMoviesError({
    @required this.moviesPage,
    @required this.error,
    @required this.nextPageKey,
  });

  final MoviesPage moviesPage;
  final dynamic error;
  final int nextPageKey;
}
