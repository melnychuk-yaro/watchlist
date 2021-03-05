part of 'search_bloc.dart';

@immutable
abstract class SearchState extends Equatable {
  final String query;
  final List<Movie> loadedMovies;
  final int? nextPageKey;
  final String? error;
  const SearchState({
    required this.query,
    required this.loadedMovies,
    this.nextPageKey,
    this.error,
  });

  @override
  List<Object?> get props => [loadedMovies, query];
}

class SearchInitial extends SearchState {
  SearchInitial()
      : super(
          loadedMovies: <Movie>[],
          query: '',
          nextPageKey: null,
          error: null,
        );
}

class SearchLoading extends SearchState {
  final List<Movie> loadedMovies;
  final String query;
  const SearchLoading({
    required this.query,
    required this.loadedMovies,
  }) : super(loadedMovies: loadedMovies, query: query);
}

class SearchLoaded extends SearchState {
  final String query;
  final List<Movie> loadedMovies;
  final int? nextPageKey;
  const SearchLoaded({
    required this.query,
    required this.loadedMovies,
    required this.nextPageKey,
  }) : super(
          query: query,
          loadedMovies: loadedMovies,
          nextPageKey: nextPageKey,
        );
}

class SearchError extends SearchState {
  final String error;
  final String query;
  final List<Movie> loadedMovies;
  final int? nextPageKey;
  const SearchError({
    required this.error,
    required this.query,
    required this.loadedMovies,
    required this.nextPageKey,
  }) : super(
          query: query,
          loadedMovies: loadedMovies,
          nextPageKey: nextPageKey,
          error: error,
        );
}
