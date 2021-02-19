part of 'favorites_bloc.dart';

@immutable
abstract class FavoritesState {
  final List<Movie> loadedMovies;
  FavoritesState(this.loadedMovies);
}

class FavoritesInitial extends FavoritesState {
  FavoritesInitial(loadedMovies) : super(loadedMovies);
}

class FavoritesLoading extends FavoritesState {
  FavoritesLoading(loadedMovies) : super(loadedMovies);
}

class FavoritesLoaded extends FavoritesState {
  final List<Movie> loadedMovies;
  FavoritesLoaded({@required this.loadedMovies}) : super(loadedMovies);
}

class FavoritesAdding extends FavoritesState {
  FavoritesAdding(loadedMovies) : super(loadedMovies);
}

class FavoritesAdded extends FavoritesState {
  final List<Movie> loadedMovies;
  final Movie newFavMovie;
  FavoritesAdded({@required this.loadedMovies, @required this.newFavMovie})
      : super(loadedMovies);
}

class FavoritesError extends FavoritesState {
  final List<Movie> loadedMovies;
  FavoritesError(this.loadedMovies) : super(loadedMovies);
}
