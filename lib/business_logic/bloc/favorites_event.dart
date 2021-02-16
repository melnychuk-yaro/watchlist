part of 'favorites_bloc.dart';

@immutable
abstract class FavoritesEvent {}

class FavoritesLoad extends FavoritesEvent {}

class FavoritesAdd extends FavoritesEvent {
  Movie movie;
  FavoritesAdd(this.movie);
}

class FavoritesDelete extends FavoritesEvent {
  int movieId;
  FavoritesDelete(this.movieId);
}
