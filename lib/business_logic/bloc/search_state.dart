part of 'search_bloc.dart';

@immutable
abstract class SearchState {
  final List<Movie> loadedMovies;
  final int nextPageKey;
  final String query;
  const SearchState(
      {@required this.nextPageKey,
      @required this.query,
      @required this.loadedMovies});
}

class SearchInitial extends SearchState {
  final String query;
  final int nextPageKey;
  final List<Movie> loadedMovies;
  SearchInitial({
    this.query = '',
    this.nextPageKey = 1,
    this.loadedMovies,
  });
}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<Movie> loadedMovies;
  final bool isLastPage;
  final int nextPageKey;
  final String query;
  SearchLoaded({
    @required this.loadedMovies,
    @required this.isLastPage,
    @required this.nextPageKey,
    @required this.query,
  }) : assert(loadedMovies != null);
}

class SearchError extends SearchState {
  final error;
  SearchError(this.error);
}
