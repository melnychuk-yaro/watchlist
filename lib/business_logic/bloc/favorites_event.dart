part of 'favorites_bloc.dart';

@immutable
abstract class FavoritesEvent {}

class FavoritesLoad extends FavoritesEvent {}

class FavoritesAdd extends FavoritesEvent {
  final Movie movie;
  FavoritesAdd(this.movie);
}

class FavoritesChangeUser extends FavoritesEvent {
  final String userId;
  FavoritesChangeUser(this.userId);
}

class FavoritesDelete extends FavoritesEvent {
  final int movieId;
  FavoritesDelete(this.movieId);
}
