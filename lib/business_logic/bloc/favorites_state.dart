part of 'favorites_bloc.dart';

enum FavoritesStatus { initial, loading, empty, loaded, failure }

@immutable
class FavoritesState extends Equatable {
  final FavoritesStatus status;
  final List<Movie> loadedMovies;
  final int? nextPageKey;
  final String userId;
  final DocumentSnapshot? lastDocumentSnapshot;
  final String error;
  FavoritesState({
    required this.status,
    required this.loadedMovies,
    this.nextPageKey = 1,
    this.userId = '',
    this.lastDocumentSnapshot,
    this.error = '',
  });

  factory FavoritesState.initial(String userId) => FavoritesState(
        status: FavoritesStatus.initial,
        loadedMovies: const <Movie>[],
        nextPageKey: null,
        userId: userId,
        lastDocumentSnapshot: null,
        error: '',
      );

  FavoritesState copyWith({
    FavoritesStatus? status,
    List<Movie>? loadedMovies,
    int? Function()? nextPageKey,
    String? userId,
    DocumentSnapshot? Function()? lastDocumentSnapshot,
    String? error,
  }) {
    return FavoritesState(
      status: status ?? this.status,
      loadedMovies: loadedMovies ?? this.loadedMovies,
      nextPageKey: nextPageKey != null ? nextPageKey() : this.nextPageKey,
      userId: userId ?? this.userId,
      lastDocumentSnapshot: lastDocumentSnapshot != null
          ? lastDocumentSnapshot()
          : this.lastDocumentSnapshot,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        status,
        loadedMovies,
        nextPageKey,
        userId,
        lastDocumentSnapshot,
        error,
      ];
}
