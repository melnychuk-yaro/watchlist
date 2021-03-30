part of 'now_playing_cubit.dart';

@immutable
abstract class NowPlayingState extends Equatable {
  const NowPlayingState({
    required this.movies,
    this.error,
    this.nextPageKey,
  });

  final List<Movie> movies;
  final String? error;
  final int? nextPageKey;

  @override
  List<Object> get props => [movies];
}

class NowPlayingInitial extends NowPlayingState {
  NowPlayingInitial() : super(movies: <Movie>[], nextPageKey: 1, error: null);
}

class NowPlayingLoaded extends NowPlayingState {
  const NowPlayingLoaded({
    required this.movies,
    required this.nextPageKey,
  }) : super(movies: movies, nextPageKey: nextPageKey);

  final List<Movie> movies;
  final int? nextPageKey;
}

class NowPlayingError extends NowPlayingState {
  const NowPlayingError({
    required this.movies,
    required this.error,
    required this.nextPageKey,
  }) : super(movies: movies, nextPageKey: nextPageKey, error: error);

  final List<Movie> movies;
  final String error;
  final int? nextPageKey;
}
