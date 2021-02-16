part of 'now_playing_cubit.dart';

@immutable
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

@immutable
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

@immutable
class NowPlayingLoading extends NowPlayingState {}

@immutable
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

@immutable
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
