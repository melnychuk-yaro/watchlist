part of 'now_playing_cubit.dart';

abstract class NowPlayingState extends Equatable {
  const NowPlayingState({
    @required this.moviesPage,
    @required this.error,
    @required this.nextPageKey,
  });

  final MoviesPage moviesPage;
  final dynamic error;
  final int nextPageKey;

  @override
  List<Object> get props => [this.moviesPage, this.error, this.nextPageKey];
}

class NowPlayingInitial extends NowPlayingState {
  const NowPlayingInitial({
    @required this.moviesPage,
    @required this.error,
    @required this.nextPageKey,
  });

  final MoviesPage moviesPage;
  final dynamic error;
  final int nextPageKey;
}

class NowPlayingLoading extends NowPlayingState {}

class NowPlayingLoaded extends NowPlayingState {
  const NowPlayingLoaded({
    @required this.moviesPage,
    @required this.error,
    @required this.nextPageKey,
  });

  final MoviesPage moviesPage;
  final dynamic error;
  final int nextPageKey;
}

class NowPlayingError extends NowPlayingState {
  const NowPlayingError({
    @required this.moviesPage,
    @required this.error,
    @required this.nextPageKey,
  });

  final MoviesPage moviesPage;
  final dynamic error;
  final int nextPageKey;
}
