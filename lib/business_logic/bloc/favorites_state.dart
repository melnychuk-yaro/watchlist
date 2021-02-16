part of 'favorites_bloc.dart';

@immutable
abstract class FavoritesState {}

class FavoritesInitial extends FavoritesState {}

class FavoritesLoading extends FavoritesState {}

class FavoritesLoaded extends FavoritesState {
  final List<dynamic> loadedMovies;
  FavoritesLoaded({@required this.loadedMovies}) : assert(loadedMovies != null);
}

class FavoritesAdding extends FavoritesState {}

class FavoritesAdded extends FavoritesState {
  final List<dynamic> loadedMovies;
  final Movie newFavMovie;
  FavoritesAdded({@required this.loadedMovies, @required this.newFavMovie})
      : assert(loadedMovies != null);
}

class FavoritesError extends FavoritesState {}
