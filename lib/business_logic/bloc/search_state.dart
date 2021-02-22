part of 'search_bloc.dart';

@immutable
abstract class SearchState extends Equatable {
  final List<Movie> loadedMovies;
  final int nextPageKey;
  final String query;
  const SearchState(
      {@required this.nextPageKey,
      @required this.query,
      @required this.loadedMovies});

  @override
  List<Object> get props => [loadedMovies, nextPageKey, query];
}

class SearchInitial extends SearchState {
  final String query;
  final int nextPageKey;
  final List<Movie> loadedMovies;
  const SearchInitial({
    this.query = '',
    this.nextPageKey = 1,
    this.loadedMovies,
  }) : super(loadedMovies: loadedMovies, query: query, nextPageKey: 1);
}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<Movie> loadedMovies;
  final bool isLastPage;
  final int nextPageKey;
  final String query;
  const SearchLoaded({
    @required this.loadedMovies,
    @required this.isLastPage,
    @required this.nextPageKey,
    @required this.query,
  }) : assert(loadedMovies != null);
}

class SearchError extends SearchState {
  final String error;
  const SearchError(this.error);
}
