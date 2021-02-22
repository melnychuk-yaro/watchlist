part of 'favorites_bloc.dart';

@immutable
abstract class FavoritesState {
  final List<Movie> loadedMovies;
  const FavoritesState(this.loadedMovies);
}

class FavoritesInitial extends FavoritesState {
  const FavoritesInitial(loadedMovies) : super(loadedMovies);
}

class FavoritesLoading extends FavoritesState {
  const FavoritesLoading(loadedMovies) : super(loadedMovies);
}

class FavoritesLoaded extends FavoritesState {
  final List<Movie> loadedMovies;
  const FavoritesLoaded({@required this.loadedMovies}) : super(loadedMovies);
}

class FavoritesAdding extends FavoritesState {
  const FavoritesAdding(loadedMovies) : super(loadedMovies);
}

class FavoritesAdded extends FavoritesState {
  final List<Movie> loadedMovies;
  final Movie newFavMovie;
  const FavoritesAdded(
      {@required this.loadedMovies, @required this.newFavMovie})
      : super(loadedMovies);
}

class FavoritesError extends FavoritesState {
  final List<Movie> loadedMovies;
  const FavoritesError(this.loadedMovies) : super(loadedMovies);
}
