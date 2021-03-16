part of 'search_bloc.dart';

enum SearchStatus { initial, loading, loaded, failure }

@immutable
class SearchState extends Equatable {
  final SearchStatus status;
  final String query;
  final List<Movie> loadedMovies;
  final int? nextPageKey;
  final String error;
  const SearchState({
    required this.status,
    required this.query,
    required this.loadedMovies,
    this.nextPageKey,
    this.error = '',
  });

  factory SearchState.initial() => SearchState(
        status: SearchStatus.initial,
        query: '',
        loadedMovies: const <Movie>[],
        nextPageKey: 1,
        error: '',
      );

  SearchState copyWith({
    SearchStatus? status,
    String? query,
    List<Movie>? loadedMovies,
    int? Function()? nextPageKey,
    String? error,
  }) {
    return SearchState(
      status: status ?? this.status,
      query: query ?? this.query,
      loadedMovies: loadedMovies ?? this.loadedMovies,
      nextPageKey: nextPageKey != null ? nextPageKey() : this.nextPageKey,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, query, loadedMovies, nextPageKey, error];
}
