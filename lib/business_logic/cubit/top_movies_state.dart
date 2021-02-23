part of 'top_movies_cubit.dart';

@immutable
abstract class TopMoviesState {
  TopMoviesState({
    @required this.movies,
    @required this.error,
    @required this.nextPageKey,
    @required this.isLastPage,
  });

  final List<Movie> movies;
  final dynamic error;
  final int nextPageKey;
  final bool isLastPage;
}

class TopMoviesInitial extends TopMoviesState {
  TopMoviesInitial({
    @required this.movies,
    this.error = '',
    this.nextPageKey = 1,
    this.isLastPage = false,
  });

  final List<Movie> movies;
  final dynamic error;
  final int nextPageKey;
  final bool isLastPage;
}

class TopMoviesLoading extends TopMoviesState {}

class TopMoviesLoaded extends TopMoviesState {
  TopMoviesLoaded({
    @required this.movies,
    @required this.error,
    @required this.nextPageKey,
    @required this.isLastPage,
  });

  final List<Movie> movies;
  final dynamic error;
  final int nextPageKey;
  final bool isLastPage;
}

class TopMoviesError extends TopMoviesState {
  TopMoviesError({
    @required this.movies,
    @required this.error,
    @required this.nextPageKey,
    @required this.isLastPage,
  });

  final List<Movie> movies;
  final dynamic error;
  final int nextPageKey;
  final bool isLastPage;
}
