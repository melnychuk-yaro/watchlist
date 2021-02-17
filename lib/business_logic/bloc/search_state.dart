part of 'search_bloc.dart';

@immutable
abstract class SearchState {
  final int nextPageKey;
  final String query;
  const SearchState({@required this.nextPageKey, @required this.query});
}

class SearchInitial extends SearchState {}

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
