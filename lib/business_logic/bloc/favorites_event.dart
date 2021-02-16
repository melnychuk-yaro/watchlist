part of 'favorites_bloc.dart';

@immutable
abstract class FavoritesEvent {}

class FavoritesLoad extends FavoritesEvent {}

class FavoritesAdd extends FavoritesEvent {
  final Movie movie;
  FavoritesAdd(this.movie);
}

class FavoritesDelete extends FavoritesEvent {
  final int movieId;
  FavoritesDelete(this.movieId);
}
