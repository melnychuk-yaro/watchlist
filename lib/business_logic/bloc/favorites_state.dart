part of 'favorites_bloc.dart';

@immutable
abstract class FavoritesState extends Equatable {
  final List<Movie> loadedMovies;
  final int? nextPageKey;
  FavoritesState({required this.loadedMovies, this.nextPageKey});

  @override
  List<Object?> get props => [loadedMovies];
}

class FavoritesInitial extends FavoritesState {
  FavoritesInitial() : super(loadedMovies: <Movie>[], nextPageKey: null);
}

class FavoritesLoading extends FavoritesState {
  FavoritesLoading(loadedMovies) : super(loadedMovies: loadedMovies);
}

class FavoritesLoaded extends FavoritesState {
  final List<Movie> loadedMovies;
  final int? nextPageKey;
  FavoritesLoaded({required this.loadedMovies, required this.nextPageKey})
      : super(loadedMovies: loadedMovies, nextPageKey: nextPageKey);
}

class FavoritesError extends FavoritesState {
  final List<Movie> loadedMovies;
  final String error;
  FavoritesError(this.loadedMovies, this.error)
      : super(loadedMovies: loadedMovies);
}
